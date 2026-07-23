import { Inject, Injectable } from '@nestjs/common';
import type { FiltroVentas, VentaLector } from '../domain/ports/venta-lector.port';
import { Venta } from '../domain/venta.entity';
import { VENTA_REPOSITORY } from '../domain/venta.repository';

@Injectable()
export class ListarVentasUseCase {
  constructor(@Inject(VENTA_REPOSITORY) private readonly ventas: VentaLector) {}

  async ejecutar(filtro?: FiltroVentas): Promise<Venta[]> {
    return this.ventas.buscarTodas(filtro);
  }
}
