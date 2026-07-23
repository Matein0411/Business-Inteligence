import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../shared/prisma/prisma.service';
import { TransaccionLector } from '../domain/ports/transaccion-lector.port';

@Injectable()
export class PrismaTransaccionRepository implements TransaccionLector {
  constructor(private readonly prisma: PrismaService) {}

  async obtenerCanastas(): Promise<number[][]> {
    const ventas = await this.prisma.venta.findMany({
      where: { estadoVenta: 'completada' },
      select: { detalles: { select: { idProducto: true } } },
    });

    // Se incluyen tambien canastas de un solo producto: aportan 0 pares pero
    // cuentan para el soporte individual del item y el total de transacciones.
    return ventas.map((venta) => venta.detalles.map((d) => d.idProducto));
  }
}
