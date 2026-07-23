import { Inject, Injectable } from '@nestjs/common';
import { NoEncontradoError } from '../../../shared/domain/errors/no-encontrado.error';
import { Producto } from '../domain/producto.entity';
import type { ProductoLector } from '../domain/ports/producto-lector.port';
import { PRODUCTO_REPOSITORY } from '../domain/producto.repository';

@Injectable()
export class ObtenerProductoUseCase {
  constructor(@Inject(PRODUCTO_REPOSITORY) private readonly productos: ProductoLector) {}

  async ejecutar(id: number): Promise<Producto> {
    const producto = await this.productos.buscarPorId(id);
    if (!producto) {
      throw new NoEncontradoError('Producto', id);
    }
    return producto;
  }
}
