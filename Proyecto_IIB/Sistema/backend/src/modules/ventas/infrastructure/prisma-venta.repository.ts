import { Injectable } from '@nestjs/common';
import { Prisma, Venta as VentaPrisma, DetalleVenta as DetalleVentaPrisma, Producto as ProductoPrisma } from '@prisma/client';
import { PrismaService } from '../../../shared/prisma/prisma.service';
import { NoEncontradoError } from '../../../shared/domain/errors/no-encontrado.error';
import { ReglaNegocioError } from '../../../shared/domain/errors/regla-negocio.error';
import { LineaVenta, NuevaVentaDatos, Venta } from '../domain/venta.entity';
import { FiltroVentas } from '../domain/ports/venta-lector.port';
import { VentaRepository } from '../domain/venta.repository';

type VentaConDetalles = VentaPrisma & {
  detalles: (DetalleVentaPrisma & { producto: ProductoPrisma })[];
};

@Injectable()
export class PrismaVentaRepository implements VentaRepository {
  constructor(private readonly prisma: PrismaService) {}

  async buscarTodas(filtro?: FiltroVentas): Promise<Venta[]> {
    const registros = await this.prisma.venta.findMany({
      where: {
        estadoVenta: filtro?.estado,
        idCliente: filtro?.idCliente,
        fechaHora: {
          gte: filtro?.desde,
          lte: filtro?.hasta,
        },
      },
      include: { detalles: { include: { producto: true } } },
      orderBy: { fechaHora: 'desc' },
    });
    return registros.map((r) => this.aDominio(r));
  }

  async buscarPorId(id: number): Promise<Venta | null> {
    const registro = await this.prisma.venta.findUnique({
      where: { idVenta: id },
      include: { detalles: { include: { producto: true } } },
    });
    return registro ? this.aDominio(registro) : null;
  }

  /**
   * Registra la venta y descuenta stock en una sola transaccion de BD.
   * Si metodoPago es 'fiado', el trigger trg_validar_limite_fiado (definido
   * en db/schema.sql) puede rechazar el INSERT si supera el cupo del cliente;
   * ese rechazo se traduce a ReglaNegocioError en manejarErrorPostgres.
   */
  async registrar(datos: NuevaVentaDatos): Promise<Venta> {
    try {
      const registro = await this.prisma.$transaction(async (tx) => {
        let total = 0;
        const detallesData: Prisma.DetalleVentaCreateManyVentaInput[] = [];

        for (const linea of datos.lineas) {
          const producto = await tx.producto.findUnique({ where: { idProducto: linea.idProducto } });
          if (!producto) {
            throw new NoEncontradoError('Producto', linea.idProducto);
          }
          if (producto.stockActual < linea.cantidad) {
            throw new ReglaNegocioError(
              `Stock insuficiente para "${producto.nombre}": disponible ${producto.stockActual}, solicitado ${linea.cantidad}`,
            );
          }

          const precioUnitario = Number(producto.precioVenta);
          const subtotal = Number((precioUnitario * linea.cantidad).toFixed(2));
          total += subtotal;

          detallesData.push({
            idProducto: linea.idProducto,
            cantidad: linea.cantidad,
            precioUnitario,
            subtotal,
          });

          await tx.producto.update({
            where: { idProducto: linea.idProducto },
            data: { stockActual: { decrement: linea.cantidad }, fechaActualizacion: new Date() },
          });
        }

        const ventaCreada = await tx.venta.create({
          data: {
            idCliente: datos.idCliente ?? null,
            metodoPago: datos.metodoPago,
            total: Number(total.toFixed(2)),
            detalles: { createMany: { data: detallesData } },
          },
          include: { detalles: { include: { producto: true } } },
        });

        return ventaCreada;
      });

      return this.aDominio(registro);
    } catch (error) {
      this.manejarErrorPostgres(error);
    }
  }

  async anular(id: number): Promise<Venta> {
    const registro = await this.prisma.$transaction(async (tx) => {
      const venta = await tx.venta.findUniqueOrThrow({
        where: { idVenta: id },
        include: { detalles: true },
      });

      for (const detalle of venta.detalles) {
        await tx.producto.update({
          where: { idProducto: detalle.idProducto },
          data: { stockActual: { increment: detalle.cantidad }, fechaActualizacion: new Date() },
        });
      }

      return tx.venta.update({
        where: { idVenta: id },
        data: { estadoVenta: 'anulada' },
        include: { detalles: { include: { producto: true } } },
      });
    });

    return this.aDominio(registro);
  }

  private aDominio(registro: VentaConDetalles): Venta {
    return new Venta(
      registro.idVenta,
      registro.fechaHora,
      registro.idCliente,
      registro.metodoPago as Venta['metodoPago'],
      registro.estadoVenta as Venta['estadoVenta'],
      Number(registro.total),
      registro.detalles.map(
        (d) =>
          new LineaVenta(d.idProducto, d.producto.nombre, d.cantidad, Number(d.precioUnitario), Number(d.subtotal)),
      ),
    );
  }

  /** Traduce el RAISE EXCEPTION del trigger de fiado (y otros errores de Postgres) a errores de dominio. */
  private manejarErrorPostgres(error: unknown): never {
    if (error instanceof NoEncontradoError || error instanceof ReglaNegocioError) {
      throw error;
    }
    const mensaje = error instanceof Error ? error.message : String(error);
    // El mensaje del trigger (definido en fn_validar_limite_fiado, db/schema.sql) siempre
    // termina en "...esta venta lo llevaria a <numero>"; todo lo que Prisma concatena
    // despues (severity, detail, hint...) se descarta.
    const coincidencia = mensaje.match(/Fiado rechazado:[^"]*llevaria a [\d.]+/);
    if (coincidencia) {
      throw new ReglaNegocioError(coincidencia[0]);
    }
    throw error;
  }
}
