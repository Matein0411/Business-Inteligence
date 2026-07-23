import { DominioError } from './dominio.error';

export class NoEncontradoError extends DominioError {
  constructor(entidad: string, id: number | string) {
    super(`${entidad} con id ${id} no fue encontrado`);
  }
}
