import { RiesgoFiado, SaldoCliente } from '../saldo-cliente.entity';

export interface SaldoClientePort {
  consultarSaldo(idCliente: number): Promise<SaldoCliente | null>;
  listarRiesgo(): Promise<RiesgoFiado[]>;
}
