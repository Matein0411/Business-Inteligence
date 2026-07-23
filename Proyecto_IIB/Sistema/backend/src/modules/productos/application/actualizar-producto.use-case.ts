import { Inject, Injectable } from '@nestjs/common';
import { NoEncontradoError } from '../../../shared/domain/errors/no-encontrado.error';
import type { NuevoProductoDatos } from '../domain/producto.entity';
import { Producto } from '../domain/producto.entity';
import type { ProductoRepository } from '../domain/producto.repository';
import { PRODUCTO_REPOSITORY } from '../domain/producto.repository';

@Injectable()
export class ActualizarProductoUseCase {
  constructor(@Inject(PRODUCTO_REPOSITORY) private readonly productos: ProductoRepository) {}

  async ejecutar(id: number, datos: Partial<NuevoProductoDatos>): Promise<Producto> {
    const existente = await this.productos.buscarPorId(id);
    if (!existente) {
      throw new NoEncontradoError('Producto', id);
    }
    return this.productos.actualizar(id, datos);
  }
}
