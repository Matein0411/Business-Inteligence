import { Controller, Get, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../../../shared/auth/jwt-auth.guard';
import { ListarCategoriasUseCase } from '../application/listar-categorias.use-case';
import { CategoriaResponseDto } from './dto/categoria-response.dto';

@Controller('categorias')
@UseGuards(JwtAuthGuard)
export class CategoriasController {
  constructor(private readonly listarCategorias: ListarCategoriasUseCase) {}

  @Get()
  async listar(): Promise<CategoriaResponseDto[]> {
    const categorias = await this.listarCategorias.ejecutar();
    return categorias.map(CategoriaResponseDto.desdeDominio);
  }
}
