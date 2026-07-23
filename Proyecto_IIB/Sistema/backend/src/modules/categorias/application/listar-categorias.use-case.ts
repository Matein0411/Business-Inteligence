import { Inject, Injectable } from '@nestjs/common';
import { Categoria } from '../domain/categoria.entity';
import { CATEGORIA_REPOSITORY } from '../domain/categoria.tokens';
import type { CategoriaLector } from '../domain/ports/categoria-lector.port';

@Injectable()
export class ListarCategoriasUseCase {
  constructor(@Inject(CATEGORIA_REPOSITORY) private readonly categorias: CategoriaLector) {}

  async ejecutar(): Promise<Categoria[]> {
    return this.categorias.buscarTodas();
  }
}
