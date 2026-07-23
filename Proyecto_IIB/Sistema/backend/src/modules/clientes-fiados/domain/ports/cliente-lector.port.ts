import { Cliente } from '../cliente.entity';

export interface FiltroClientes {
  soloFrecuentes?: boolean;
}

export interface ClienteLector {
  buscarTodos(filtro?: FiltroClientes): Promise<Cliente[]>;
  buscarPorId(id: number): Promise<Cliente | null>;
}
