import { Module } from '@nestjs/common';
import { ActualizarProductoUseCase } from './application/actualizar-producto.use-case';
import { CrearProductoUseCase } from './application/crear-producto.use-case';
import { ListarProductosUseCase } from './application/listar-productos.use-case';
import { ObtenerProductoUseCase } from './application/obtener-producto.use-case';
import { PRODUCTO_REPOSITORY } from './domain/producto.repository';
import { PrismaProductoRepository } from './infrastructure/prisma-producto.repository';
import { ProductosController } from './presentation/productos.controller';

@Module({
  controllers: [ProductosController],
  providers: [
    ListarProductosUseCase,
    ObtenerProductoUseCase,
    CrearProductoUseCase,
    ActualizarProductoUseCase,
    { provide: PRODUCTO_REPOSITORY, useClass: PrismaProductoRepository },
  ],
})
export class ProductosModule {}
