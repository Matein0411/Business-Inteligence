import { Inject, Injectable } from '@nestjs/common';
import { NoEncontradoError } from '../../../shared/domain/errors/no-encontrado.error';
import { Cliente, NuevoClienteDatos } from '../domain/cliente.entity';
import type { ClienteRepository } from '../domain/cliente.repository';
import { CLIENTE_REPOSITORY } from '../domain/cliente.repository';

@Injectable()
export class ActualizarClienteUseCase {
  constructor(@Inject(CLIENTE_REPOSITORY) private readonly clientes: ClienteRepository) {}

  async ejecutar(id: number, datos: Partial<NuevoClienteDatos>): Promise<Cliente> {
    const existente = await this.clientes.buscarPorId(id);
    if (!existente) {
      throw new NoEncontradoError('Cliente', id);
    }
    return this.clientes.actualizar(id, datos);
  }
}
