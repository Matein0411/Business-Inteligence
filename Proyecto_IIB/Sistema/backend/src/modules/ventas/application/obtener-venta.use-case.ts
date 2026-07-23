import { Inject, Injectable } from '@nestjs/common';
import { NoEncontradoError } from '../../../shared/domain/errors/no-encontrado.error';
import type { VentaLector } from '../domain/ports/venta-lector.port';
import { Venta } from '../domain/venta.entity';
import { VENTA_REPOSITORY } from '../domain/venta.repository';

@Injectable()
export class ObtenerVentaUseCase {
  constructor(@Inject(VENTA_REPOSITORY) private readonly ventas: VentaLector) {}

  async ejecutar(id: number): Promise<Venta> {
    const venta = await this.ventas.buscarPorId(id);
    if (!venta) {
      throw new NoEncontradoError('Venta', id);
    }
    return venta;
  }
}
