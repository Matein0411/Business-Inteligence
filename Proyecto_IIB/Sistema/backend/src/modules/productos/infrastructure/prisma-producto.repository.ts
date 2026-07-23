import { Injectable } from '@nestjs/common';
import { Producto as ProductoPrisma } from '@prisma/client';
import { PrismaService } from '../../../shared/prisma/prisma.service';
import { NuevoProductoDatos, Producto } from '../domain/producto.entity';
import { FiltroProductos } from '../domain/ports/producto-lector.port';
import { ProductoRepository } from '../domain/producto.repository';

@Injectable()
export class PrismaProductoRepository implements ProductoRepository {
  constructor(private readonly prisma: PrismaService) {}

  async buscarTodos(filtro?: FiltroProductos): Promise<Producto[]> {
    const registros = await this.prisma.producto.findMany({
      where: {
        activo: filtro?.soloActivos ? true : undefined,
        idCategoria: filtro?.idCategoria,
      },
      orderBy: { nombre: 'asc' },
    });
    return registros.map(this.aDominio);
  }

  async buscarPorId(id: number): Promise<Producto | null> {
    const registro = await this.prisma.producto.findUnique({ where: { idProducto: id } });
    return registro ? this.aDominio(registro) : null;
  }

  async crear(datos: NuevoProductoDatos): Promise<Producto> {
    const registro = await this.prisma.producto.create({
      data: {
        nombre: datos.nombre,
        idCategoria: datos.idCategoria,
        marca: datos.marca ?? null,
        unidadMedida: datos.unidadMedida,
        precioCompra: datos.precioCompra,
        precioVenta: datos.precioVenta,
        stockActual: datos.stockActual,
        stockMinimo: datos.stockMinimo,
        activo: datos.activo ?? true,
      },
    });
    return this.aDominio(registro);
  }

  async actualizar(id: number, datos: Partial<NuevoProductoDatos>): Promise<Producto> {
    const registro = await this.prisma.producto.update({
      where: { idProducto: id },
      data: {
        ...datos,
        fechaActualizacion: new Date(),
      },
    });
    return this.aDominio(registro);
  }

  private aDominio(registro: ProductoPrisma): Producto {
    return new Producto(
      registro.idProducto,
      registro.nombre,
      registro.idCategoria,
      registro.marca,
      registro.unidadMedida,
      Number(registro.precioCompra),
      Number(registro.precioVenta),
      registro.stockActual,
      registro.stockMinimo,
      registro.activo,
    );
  }
}
