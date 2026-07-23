import { Cliente, NuevoClienteDatos } from '../cliente.entity';

export interface ClienteEscritor {
  crear(datos: NuevoClienteDatos): Promise<Cliente>;
  actualizar(id: number, datos: Partial<NuevoClienteDatos>): Promise<Cliente>;
}
