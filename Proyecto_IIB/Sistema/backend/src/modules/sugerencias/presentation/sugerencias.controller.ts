import { Body, Controller, Get, Param, ParseIntPipe, Post, Query, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../../../shared/auth/jwt-auth.guard';
import { GenerarReglasAsociacionUseCase } from '../application/generar-reglas-asociacion.use-case';
import { ListarSugerenciasProductoUseCase } from '../application/listar-sugerencias-producto.use-case';
import { ListarTodasLasReglasUseCase } from '../application/listar-todas-las-reglas.use-case';
import { RecalcularSugerenciasDto } from './dto/recalcular-sugerencias.dto';
import { ReglaAsociacionResponseDto } from './dto/regla-asociacion-response.dto';

@Controller('sugerencias')
@UseGuards(JwtAuthGuard)
export class SugerenciasController {
  constructor(
    private readonly generarReglas: GenerarReglasAsociacionUseCase,
    private readonly listarSugerenciasProducto: ListarSugerenciasProductoUseCase,
    private readonly listarTodasLasReglas: ListarTodasLasReglasUseCase,
  ) {}

  @Post('recalcular')
  async recalcular(@Body() dto: RecalcularSugerenciasDto) {
    return this.generarReglas.ejecutar(dto);
  }

  @Get()
  async listarTodas(): Promise<ReglaAsociacionResponseDto[]> {
    const reglas = await this.listarTodasLasReglas.ejecutar();
    return reglas.map(ReglaAsociacionResponseDto.desdeDominio);
  }

  @Get(':idProducto')
  async porProducto(
    @Param('idProducto', ParseIntPipe) idProducto: number,
    @Query('limite', new ParseIntPipe({ optional: true })) limite?: number,
  ): Promise<ReglaAsociacionResponseDto[]> {
    const reglas = await this.listarSugerenciasProducto.ejecutar(idProducto, limite ?? 5);
    return reglas.map(ReglaAsociacionResponseDto.desdeDominio);
  }
}
