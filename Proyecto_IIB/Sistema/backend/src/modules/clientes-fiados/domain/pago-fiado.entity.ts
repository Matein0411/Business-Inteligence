export type MetodoPagoFiado = 'efectivo' | 'transferencia';

export class PagoFiado {
  constructor(
    public readonly id: number,
    public readonly idCliente: number,
    public readonly fechaHora: Date,
    public readonly monto: number,
    public readonly metodoPago: MetodoPagoFiado,
    public readonly observacion: string | null,
  ) {}
}

export interface NuevoPagoFiadoDatos {
  idCliente: number;
  monto: number;
  metodoPago?: MetodoPagoFiado;
  observacion?: string | null;
}
