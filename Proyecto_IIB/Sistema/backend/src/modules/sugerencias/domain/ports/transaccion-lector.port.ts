/** Cada canasta es la lista de ids de producto (sin repetir) de una venta completada. */
export interface TransaccionLector {
  obtenerCanastas(): Promise<number[][]>;
}
