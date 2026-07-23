import { Inject, Injectable } from '@nestjs/common';
import { OpcionesApriori } from '../domain/regla-asociacion.entity';
import type { MotorReglasAsociacion } from '../domain/ports/motor-reglas.port';
import type { ReglaAsociacionRepository } from '../domain/ports/regla-asociacion.port';
import type { TransaccionLector } from '../domain/ports/transaccion-lector.port';
import {
  MOTOR_REGLAS_ASOCIACION,
  REGLA_ASOCIACION_REPOSITORY,
  TRANSACCION_REPOSITORY,
} from '../domain/sugerencias.tokens';

const OPCIONES_POR_DEFECTO: OpcionesApriori = {
  soporteMinimo: 0.02,
  confianzaMinima: 0.3,
};

@Injectable()
export class GenerarReglasAsociacionUseCase {
  constructor(
    @Inject(TRANSACCION_REPOSITORY) private readonly transacciones: TransaccionLector,
    @Inject(MOTOR_REGLAS_ASOCIACION) private readonly motor: MotorReglasAsociacion,
    @Inject(REGLA_ASOCIACION_REPOSITORY) private readonly reglas: ReglaAsociacionRepository,
  ) {}

  async ejecutar(opciones?: Partial<OpcionesApriori>): Promise<{ totalCanastas: number; totalReglas: number }> {
    const canastas = await this.transacciones.obtenerCanastas();
    // Union campo a campo (no spread): un DTO transformado por Nest puede traer
    // soporteMinimo/confianzaMinima como propiedades propias en `undefined`,
    // y un spread ingenuo pisaria el default con ese undefined.
    const opcionesFinales: OpcionesApriori = {
      soporteMinimo: opciones?.soporteMinimo ?? OPCIONES_POR_DEFECTO.soporteMinimo,
      confianzaMinima: opciones?.confianzaMinima ?? OPCIONES_POR_DEFECTO.confianzaMinima,
    };
    const reglasCalculadas = this.motor.generar(canastas, opcionesFinales);
    await this.reglas.reemplazarTodas(reglasCalculadas);
    return { totalCanastas: canastas.length, totalReglas: reglasCalculadas.length };
  }
}
