import { Inject, Injectable } from '@nestjs/common';
import type { NuevoProductoDatos } from '../domain/producto.entity';
import { Producto } from '../domain/producto.entity';
import type { ProductoEscritor } from '../domain/ports/producto-escritor.port';
import { PRODUCTO_REPOSITORY } from '../domain/producto.repository';

@Injectable()
export class CrearProductoUseCase {
  constructor(@Inject(PRODUCTO_REPOSITORY) private readonly productos: ProductoEscritor) {}

  async ejecutar(datos: NuevoProductoDatos): Promise<Producto> {
    return this.productos.crear(datos);
  }
}
