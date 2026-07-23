import { Inject, Injectable } from '@nestjs/common';
import { ReglaNegocioError } from '../../../shared/domain/errors/regla-negocio.error';
import type { NuevaVentaDatos } from '../domain/venta.entity';
import { Venta } from '../domain/venta.entity';
import type { VentaEscritor } from '../domain/ports/venta-escritor.port';
import { VENTA_REPOSITORY } from '../domain/venta.repository';

@Injectable()
export class RegistrarVentaUseCase {
  constructor(@Inject(VENTA_REPOSITORY) private readonly ventas: VentaEscritor) {}

  async ejecutar(datos: NuevaVentaDatos): Promise<Venta> {
    if (datos.metodoPago === 'fiado' && !datos.idCliente) {
      throw new ReglaNegocioError('Una venta a fiado requiere un cliente identificado');
    }
    if (datos.lineas.length === 0) {
      throw new ReglaNegocioError('La venta debe tener al menos un producto');
    }
    return this.ventas.registrar(datos);
  }
}
