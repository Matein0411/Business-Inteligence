import {
  Body,
  Controller,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from '../../../shared/auth/jwt-auth.guard';
import { ActualizarProductoUseCase } from '../application/actualizar-producto.use-case';
import { CrearProductoUseCase } from '../application/crear-producto.use-case';
import { ListarProductosUseCase } from '../application/listar-productos.use-case';
import { ObtenerProductoUseCase } from '../application/obtener-producto.use-case';
import { ActualizarProductoDto } from './dto/actualizar-producto.dto';
import { CrearProductoDto } from './dto/crear-producto.dto';
import { ProductoResponseDto } from './dto/producto-response.dto';

@Controller('productos')
@UseGuards(JwtAuthGuard)
export class ProductosController {
  constructor(
    private readonly listarProductos: ListarProductosUseCase,
    private readonly obtenerProducto: ObtenerProductoUseCase,
    private readonly crearProducto: CrearProductoUseCase,
    private readonly actualizarProducto: ActualizarProductoUseCase,
  ) {}

  @Get()
  async listar(
    @Query('activos') activos?: string,
    @Query('idCategoria', new ParseIntPipe({ optional: true })) idCategoria?: number,
  ): Promise<ProductoResponseDto[]> {
    const productos = await this.listarProductos.ejecutar({
      soloActivos: activos === 'true',
      idCategoria,
    });
    return productos.map(ProductoResponseDto.desdeDominio);
  }

  @Get(':id')
  async obtener(@Param('id', ParseIntPipe) id: number): Promise<ProductoResponseDto> {
    const producto = await this.obtenerProducto.ejecutar(id);
    return ProductoResponseDto.desdeDominio(producto);
  }

  @Post()
  async crear(@Body() dto: CrearProductoDto): Promise<ProductoResponseDto> {
    const producto = await this.crearProducto.ejecutar(dto);
    return ProductoResponseDto.desdeDominio(producto);
  }

  @Patch(':id')
  async actualizar(
    @Param('id', ParseIntPipe) id: number,
    @Body() dto: ActualizarProductoDto,
  ): Promise<ProductoResponseDto> {
    const producto = await this.actualizarProducto.ejecutar(id, dto);
    return ProductoResponseDto.desdeDominio(producto);
  }
}
