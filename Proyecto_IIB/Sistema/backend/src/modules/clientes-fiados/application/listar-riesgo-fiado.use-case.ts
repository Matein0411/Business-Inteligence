import { Inject, Injectable } from '@nestjs/common';
import { RiesgoFiado } from '../domain/saldo-cliente.entity';
import { SALDO_CLIENTE_REPOSITORY } from '../domain/cliente.repository';
import type { SaldoClientePort } from '../domain/ports/saldo-cliente.port';

@Injectable()
export class ListarRiesgoFiadoUseCase {
  constructor(@Inject(SALDO_CLIENTE_REPOSITORY) private readonly saldos: SaldoClientePort) {}

  async ejecutar(): Promise<RiesgoFiado[]> {
    return this.saldos.listarRiesgo();
  }
}
