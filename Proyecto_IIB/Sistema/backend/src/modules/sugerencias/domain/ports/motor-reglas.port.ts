import { OpcionesApriori, ReglaCalculada } from '../regla-asociacion.entity';

/**
 * Puerto del algoritmo de reglas de asociacion. Hoy lo implementa un Apriori
 * escrito a mano (infrastructure/apriori-engine.ts); si en el futuro se
 * quisiera FP-Growth u otro motor, solo se cambia esta implementacion.
 */
export interface MotorReglasAsociacion {
  generar(canastas: number[][], opciones: OpcionesApriori): ReglaCalculada[];
}
