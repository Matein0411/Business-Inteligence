import { Module } from '@nestjs/common';
import { GenerarReglasAsociacionUseCase } from './application/generar-reglas-asociacion.use-case';
import { ListarSugerenciasProductoUseCase } from './application/listar-sugerencias-producto.use-case';
import { ListarTodasLasReglasUseCase } from './application/listar-todas-las-reglas.use-case';
import {
  MOTOR_REGLAS_ASOCIACION,
  REGLA_ASOCIACION_REPOSITORY,
  TRANSACCION_REPOSITORY,
} from './domain/sugerencias.tokens';
import { AprioriEngine } from './infrastructure/apriori-engine';
import { PrismaReglaAsociacionRepository } from './infrastructure/prisma-regla-asociacion.repository';
import { PrismaTransaccionRepository } from './infrastructure/prisma-transaccion.repository';
import { SugerenciasController } from './presentation/sugerencias.controller';

@Module({
  controllers: [SugerenciasController],
  providers: [
    GenerarReglasAsociacionUseCase,
    ListarSugerenciasProductoUseCase,
    ListarTodasLasReglasUseCase,
    { provide: TRANSACCION_REPOSITORY, useClass: PrismaTransaccionRepository },
    { provide: REGLA_ASOCIACION_REPOSITORY, useClass: PrismaReglaAsociacionRepository },
    { provide: MOTOR_REGLAS_ASOCIACION, useClass: AprioriEngine },
  ],
})
export class SugerenciasModule {}
