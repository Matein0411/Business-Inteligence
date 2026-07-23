import { Inject, Injectable } from '@nestjs/common';
import { NoEncontradoError } from '../../../shared/domain/errors/no-encontrado.error';
import { SaldoCliente } from '../domain/saldo-cliente.entity';
import { SALDO_CLIENTE_REPOSITORY } from '../domain/cliente.repository';
import type { SaldoClientePort } from '../domain/ports/saldo-cliente.port';

@Injectable()
export class ConsultarSaldoClienteUseCase {
  constructor(@Inject(SALDO_CLIENTE_REPOSITORY) private readonly saldos: SaldoClientePort) {}

  async ejecutar(idCliente: number): Promise<SaldoCliente> {
    const saldo = await this.saldos.consultarSaldo(idCliente);
    if (!saldo) {
      throw new NoEncontradoError('Cliente', idCliente);
    }
    return saldo;
  }
}
