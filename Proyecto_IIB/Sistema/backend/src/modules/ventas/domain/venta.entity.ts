export type MetodoPago = 'efectivo' | 'tarjeta' | 'transferencia' | 'fiado';
export type EstadoVenta = 'completada' | 'anulada';

export class LineaVenta {
  constructor(
    public readonly idProducto: number,
    public readonly nombreProducto: string,
    public readonly cantidad: number,
    public readonly precioUnitario: number,
    public readonly subtotal: number,
  ) {}
}

export class Venta {
  constructor(
    public readonly id: number,
    public readonly fechaHora: Date,
    public readonly idCliente: number | null,
    public readonly metodoPago: MetodoPago,
    public readonly estadoVenta: EstadoVenta,
    public readonly total: number,
    public readonly lineas: LineaVenta[],
  ) {}

  get estaAnulada(): boolean {
    return this.estadoVenta === 'anulada';
  }
}

export interface NuevaLineaVentaDatos {
  idProducto: number;
  cantidad: number;
}

export interface NuevaVentaDatos {
  idCliente?: number | null;
  metodoPago: MetodoPago;
  lineas: NuevaLineaVentaDatos[];
}
