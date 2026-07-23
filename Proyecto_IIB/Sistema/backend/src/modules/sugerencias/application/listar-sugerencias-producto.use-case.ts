import { Inject, Injectable } from '@nestjs/common';
import { ReglaAsociacion } from '../domain/regla-asociacion.entity';
import type { ReglaAsociacionRepository } from '../domain/ports/regla-asociacion.port';
import { REGLA_ASOCIACION_REPOSITORY } from '../domain/sugerencias.tokens';

@Injectable()
export class ListarSugerenciasProductoUseCase {
  constructor(@Inject(REGLA_ASOCIACION_REPOSITORY) private readonly reglas: ReglaAsociacionRepository) {}

  async ejecutar(idProducto: number, limite = 5): Promise<ReglaAsociacion[]> {
    return this.reglas.listarPorProducto(idProducto, limite);
  }
}
