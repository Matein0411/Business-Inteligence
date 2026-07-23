import { Injectable } from '@nestjs/common';
import { PagoFiado as PagoFiadoPrisma } from '@prisma/client';
import { PrismaService } from '../../../shared/prisma/prisma.service';
import { NuevoPagoFiadoDatos, PagoFiado } from '../domain/pago-fiado.entity';
import { PagoFiadoPort } from '../domain/ports/pago-fiado.port';

@Injectable()
export class PrismaPagoFiadoRepository implements PagoFiadoPort {
  constructor(private readonly prisma: PrismaService) {}

  async registrar(datos: NuevoPagoFiadoDatos): Promise<PagoFiado> {
    const registro = await this.prisma.pagoFiado.create({
      data: {
        idCliente: datos.idCliente,
        monto: datos.monto,
        metodoPago: datos.metodoPago ?? 'efectivo',
        observacion: datos.observacion ?? null,
      },
    });
    return this.aDominio(registro);
  }

  async listarPorCliente(idCliente: number): Promise<PagoFiado[]> {
    const registros = await this.prisma.pagoFiado.findMany({
      where: { idCliente },
      orderBy: { fechaHora: 'desc' },
    });
    return registros.map(this.aDominio);
  }

  private aDominio(registro: PagoFiadoPrisma): PagoFiado {
    return new PagoFiado(
      registro.idPago,
      registro.idCliente,
      registro.fechaHora,
      Number(registro.monto),
      registro.metodoPago as PagoFiado['metodoPago'],
      registro.observacion,
    );
  }
}
