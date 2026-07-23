import { Module } from '@nestjs/common';
import { AnularVentaUseCase } from './application/anular-venta.use-case';
import { ListarVentasUseCase } from './application/listar-ventas.use-case';
import { ObtenerVentaUseCase } from './application/obtener-venta.use-case';
import { RegistrarVentaUseCase } from './application/registrar-venta.use-case';
import { VENTA_REPOSITORY } from './domain/venta.repository';
import { PrismaVentaRepository } from './infrastructure/prisma-venta.repository';
import { VentasController } from './presentation/ventas.controller';

@Module({
  controllers: [VentasController],
  providers: [
    ListarVentasUseCase,
    ObtenerVentaUseCase,
    RegistrarVentaUseCase,
    AnularVentaUseCase,
    { provide: VENTA_REPOSITORY, useClass: PrismaVentaRepository },
  ],
})
export class VentasModule {}
