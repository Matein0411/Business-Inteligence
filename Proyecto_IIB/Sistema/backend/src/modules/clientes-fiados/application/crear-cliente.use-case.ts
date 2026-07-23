import { Inject, Injectable } from '@nestjs/common';
import { Cliente, NuevoClienteDatos } from '../domain/cliente.entity';
import { CLIENTE_REPOSITORY } from '../domain/cliente.repository';
import type { ClienteEscritor } from '../domain/ports/cliente-escritor.port';

@Injectable()
export class CrearClienteUseCase {
  constructor(@Inject(CLIENTE_REPOSITORY) private readonly clientes: ClienteEscritor) {}

  async ejecutar(datos: NuevoClienteDatos): Promise<Cliente> {
    return this.clientes.crear(datos);
  }
}
