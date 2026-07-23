import { Inject, Injectable } from '@nestjs/common';
import { ReglaNegocioError } from '../../../shared/domain/errors/regla-negocio.error';
import { NoEncontradoError } from '../../../shared/domain/errors/no-encontrado.error';
import type { VentaRepository } from '../domain/venta.repository';
import { Venta } from '../domain/venta.entity';
import { VENTA_REPOSITORY } from '../domain/venta.repository';

@Injectable()
export class AnularVentaUseCase {
  constructor(@Inject(VENTA_REPOSITORY) private readonly ventas: VentaRepository) {}

  async ejecutar(id: number): Promise<Venta> {
    const venta = await this.ventas.buscarPorId(id);
    if (!venta) {
      throw new NoEncontradoError('Venta', id);
    }
    if (venta.estaAnulada) {
      throw new ReglaNegocioError(`La venta ${id} ya esta anulada`);
    }
    return this.ventas.anular(id);
  }
}
