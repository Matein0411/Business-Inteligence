import { DominioError } from './dominio.error';

/** Se lanza cuando una operacion viola una regla de negocio (ej. limite de fiado, stock insuficiente). */
export class ReglaNegocioError extends DominioError {
  constructor(message: string) {
    super(message);
  }
}
