import { Inject, Injectable } from '@nestjs/common';
import { Cliente } from '../domain/cliente.entity';
import { CLIENTE_REPOSITORY } from '../domain/cliente.repository';
import type { ClienteLector, FiltroClientes } from '../domain/ports/cliente-lector.port';

@Injectable()
export class ListarClientesUseCase {
  constructor(@Inject(CLIENTE_REPOSITORY) private readonly clientes: ClienteLector) {}

  async ejecutar(filtro?: FiltroClientes): Promise<Cliente[]> {
    return this.clientes.buscarTodos(filtro);
  }
}
