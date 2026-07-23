import { Body, Controller, Get, Param, ParseIntPipe, Patch, Post, Query, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../../../shared/auth/jwt-auth.guard';
import { AnularVentaUseCase } from '../application/anular-venta.use-case';
import { ListarVentasUseCase } from '../application/listar-ventas.use-case';
import { ObtenerVentaUseCase } from '../application/obtener-venta.use-case';
import { RegistrarVentaUseCase } from '../application/registrar-venta.use-case';
import type { EstadoVenta } from '../domain/venta.entity';
import { RegistrarVentaDto } from './dto/registrar-venta.dto';
import { VentaResponseDto } from './dto/venta-response.dto';

@Controller('ventas')
@UseGuards(JwtAuthGuard)
export class VentasController {
  constructor(
    private readonly listarVentas: ListarVentasUseCase,
    private readonly obtenerVenta: ObtenerVentaUseCase,
    private readonly registrarVenta: RegistrarVentaUseCase,
    private readonly anularVenta: AnularVentaUseCase,
  ) {}

  @Get()
  async listar(
    @Query('desde') desde?: string,
    @Query('hasta') hasta?: string,
    @Query('estado') estado?: EstadoVenta,
    @Query('idCliente', new ParseIntPipe({ optional: true })) idCliente?: number,
  ): Promise<VentaResponseDto[]> {
    const ventas = await this.listarVentas.ejecutar({
      desde: desde ? new Date(desde) : undefined,
      hasta: hasta ? new Date(hasta) : undefined,
      estado,
      idCliente,
    });
    return ventas.map(VentaResponseDto.desdeDominio);
  }

  @Get(':id')
  async obtener(@Param('id', ParseIntPipe) id: number): Promise<VentaResponseDto> {
    const venta = await this.obtenerVenta.ejecutar(id);
    return VentaResponseDto.desdeDominio(venta);
  }

  @Post()
  async registrar(@Body() dto: RegistrarVentaDto): Promise<VentaResponseDto> {
    const venta = await this.registrarVenta.ejecutar(dto);
    return VentaResponseDto.desdeDominio(venta);
  }

  @Patch(':id/anular')
  async anular(@Param('id', ParseIntPipe) id: number): Promise<VentaResponseDto> {
    const venta = await this.anularVenta.ejecutar(id);
    return VentaResponseDto.desdeDominio(venta);
  }
}
