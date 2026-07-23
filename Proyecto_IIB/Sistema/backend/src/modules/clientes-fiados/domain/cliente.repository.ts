import { ClienteEscritor } from './ports/cliente-escritor.port';
import { ClienteLector } from './ports/cliente-lector.port';

export type ClienteRepository = ClienteLector & ClienteEscritor;

export const CLIENTE_REPOSITORY = Symbol('CLIENTE_REPOSITORY');
export const SALDO_CLIENTE_REPOSITORY = Symbol('SALDO_CLIENTE_REPOSITORY');
export const PAGO_FIADO_REPOSITORY = Symbol('PAGO_FIADO_REPOSITORY');
