/** Refleja la vista SQL vista_saldo_cliente (db/schema.sql): saldo en tiempo real, sin tablas duplicadas. */
export class SaldoCliente {
  constructor(
    public readonly idCliente: number,
    public readonly nombres: string,
    public readonly limiteCredito: number,
    public readonly totalFiado: number,
    public readonly totalAbonado: number,
    public readonly saldoPendiente: number,
    public readonly creditoDisponible: number,
  ) {}
}

export type NivelRiesgo = 'Sin deuda' | 'Bajo' | 'Medio' | 'Alto' | 'Alto (excede limite)';

/** Refleja la vista SQL vista_riesgo_fiado: semaforo heuristico para clientes con deuda activa. */
export class RiesgoFiado {
  constructor(
    public readonly idCliente: number,
    public readonly nombres: string,
    public readonly saldoPendiente: number,
    public readonly limiteCredito: number,
    public readonly pctUtilizacionCredito: number | null,
    public readonly diasSinAbonar: number | null,
    public readonly nivelRiesgo: NivelRiesgo,
  ) {}
}
