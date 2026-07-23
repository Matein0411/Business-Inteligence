import { Inject, Injectable } from '@nestjs/common';
import { Producto } from '../domain/producto.entity';
import type { FiltroProductos, ProductoLector } from '../domain/ports/producto-lector.port';
import { PRODUCTO_REPOSITORY } from '../domain/producto.repository';

@Injectable()
export class ListarProductosUseCase {
  constructor(@Inject(PRODUCTO_REPOSITORY) private readonly productos: ProductoLector) {}

  async ejecutar(filtro?: FiltroProductos): Promise<Producto[]> {
    return this.productos.buscarTodos(filtro);
  }
}
