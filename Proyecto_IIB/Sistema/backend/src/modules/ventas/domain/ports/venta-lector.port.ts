import { EstadoVenta, Venta } from '../venta.entity';

export interface FiltroVentas {
  desde?: Date;
  hasta?: Date;
  estado?: EstadoVenta;
  idCliente?: number;
}

export interface VentaLector {
  buscarTodas(filtro?: FiltroVentas): Promise<Venta[]>;
  buscarPorId(id: number): Promise<Venta | null>;
}
