import { Module } from '@nestjs/common';
import { ListarCategoriasUseCase } from './application/listar-categorias.use-case';
import { CATEGORIA_REPOSITORY } from './domain/categoria.tokens';
import { PrismaCategoriaRepository } from './infrastructure/prisma-categoria.repository';
import { CategoriasController } from './presentation/categorias.controller';

@Module({
  controllers: [CategoriasController],
  providers: [ListarCategoriasUseCase, { provide: CATEGORIA_REPOSITORY, useClass: PrismaCategoriaRepository }],
})
export class CategoriasModule {}
