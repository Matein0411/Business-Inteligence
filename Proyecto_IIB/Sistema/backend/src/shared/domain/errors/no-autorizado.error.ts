import { DominioError } from './dominio.error';

export class NoAutorizadoError extends DominioError {
  constructor(message = 'Credenciales invalidas') {
    super(message);
  }
}
