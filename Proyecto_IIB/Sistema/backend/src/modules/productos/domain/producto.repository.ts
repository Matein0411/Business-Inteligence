import { ProductoEscritor } from './ports/producto-escritor.port';
import { ProductoLector } from './ports/producto-lector.port';

/** El repositorio completo compone los dos puertos; los casos de uso solo piden el que necesitan. */
export type ProductoRepository = ProductoLector & ProductoEscritor;

/** Token de inyeccion: NestJS no puede inyectar por interfaz TS (se borra en tiempo de ejecucion). */
export const PRODUCTO_REPOSITORY = Symbol('PRODUCTO_REPOSITORY');
