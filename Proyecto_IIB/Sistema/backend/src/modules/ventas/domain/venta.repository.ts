import { VentaEscritor } from './ports/venta-escritor.port';
import { VentaLector } from './ports/venta-lector.port';

export type VentaRepository = VentaLector & VentaEscritor;

export const VENTA_REPOSITORY = Symbol('VENTA_REPOSITORY');
