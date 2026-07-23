import { NuevoProductoDatos, Producto } from '../producto.entity';

/** Puerto de escritura, separado del de lectura (ISP). */
export interface ProductoEscritor {
  crear(datos: NuevoProductoDatos): Promise<Producto>;
  actualizar(id: number, datos: Partial<NuevoProductoDatos>): Promise<Producto>;
}
