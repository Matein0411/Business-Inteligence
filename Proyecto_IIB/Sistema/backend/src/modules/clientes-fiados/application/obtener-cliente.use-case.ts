import { Inject, Injectable } from '@nestjs/common';
import { NoEncontradoError } from '../../../shared/domain/errors/no-encontrado.error';
import { Cliente } from '../domain/cliente.entity';
import { CLIENTE_REPOSITORY } from '../domain/cliente.repository';
import type { ClienteLector } from '../domain/ports/cliente-lector.port';

@Injectable()
export class ObtenerClienteUseCase {
  constructor(@Inject(CLIENTE_REPOSITORY) private readonly clientes: ClienteLector) {}

  async ejecutar(id: number): Promise<Cliente> {
    const cliente = await this.clientes.buscarPorId(id);
    if (!cliente) {
      throw new NoEncontradoError('Cliente', id);
    }
    return cliente;
  }
}
