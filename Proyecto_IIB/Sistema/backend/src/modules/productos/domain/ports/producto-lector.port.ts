import { Producto } from '../producto.entity';

export interface FiltroProductos {
  soloActivos?: boolean;
  idCategoria?: number;
}

/** Puerto de solo lectura (Interface Segregation: quien solo lista/consulta no depende de escritura). */
export interface ProductoLector {
  buscarTodos(filtro?: FiltroProductos): Promise<Producto[]>;
  buscarPorId(id: number): Promise<Producto | null>;
}
