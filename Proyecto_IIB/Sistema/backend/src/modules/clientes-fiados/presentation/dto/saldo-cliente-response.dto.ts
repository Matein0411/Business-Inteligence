import { RiesgoFiado, SaldoCliente } from '../../domain/saldo-cliente.entity';

export class SaldoClienteResponseDto {
  idCliente: number;
  nombres: string;
  limiteCredito: number;
  totalFiado: number;
  totalAbonado: number;
  saldoPendiente: number;
  creditoDisponible: number;

  static desdeDominio(saldo: SaldoCliente): SaldoClienteResponseDto {
    const dto = new SaldoClienteResponseDto();
    dto.idCliente = saldo.idCliente;
    dto.nombres = saldo.nombres;
    dto.limiteCredito = saldo.limiteCredito;
    dto.totalFiado = saldo.totalFiado;
    dto.totalAbonado = saldo.totalAbonado;
    dto.saldoPendiente = saldo.saldoPendiente;
    dto.creditoDisponible = saldo.creditoDisponible;
    return dto;
  }
}

export class RiesgoFiadoResponseDto {
  idCliente: number;
  nombres: string;
  saldoPendiente: number;
  limiteCredito: number;
  pctUtilizacionCredito: number | null;
  diasSinAbonar: number | null;
  nivelRiesgo: string;

  static desdeDominio(riesgo: RiesgoFiado): RiesgoFiadoResponseDto {
    const dto = new RiesgoFiadoResponseDto();
    dto.idCliente = riesgo.idCliente;
    dto.nombres = riesgo.nombres;
    dto.saldoPendiente = riesgo.saldoPendiente;
    dto.limiteCredito = riesgo.limiteCredito;
    dto.pctUtilizacionCredito = riesgo.pctUtilizacionCredito;
    dto.diasSinAbonar = riesgo.diasSinAbonar;
    dto.nivelRiesgo = riesgo.nivelRiesgo;
    return dto;
  }
}
