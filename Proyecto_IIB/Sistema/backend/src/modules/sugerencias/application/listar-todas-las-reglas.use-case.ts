import { Inject, Injectable } from '@nestjs/common';
import { ReglaAsociacion } from '../domain/regla-asociacion.entity';
import type { ReglaAsociacionRepository } from '../domain/ports/regla-asociacion.port';
import { REGLA_ASOCIACION_REPOSITORY } from '../domain/sugerencias.tokens';

@Injectable()
export class ListarTodasLasReglasUseCase {
  constructor(@Inject(REGLA_ASOCIACION_REPOSITORY) private readonly reglas: ReglaAsociacionRepository) {}

  async ejecutar(): Promise<ReglaAsociacion[]> {
    return this.reglas.listarTodas();
  }
}
