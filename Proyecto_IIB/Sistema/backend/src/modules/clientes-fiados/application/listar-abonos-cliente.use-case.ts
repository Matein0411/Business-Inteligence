import { Inject, Injectable } from '@nestjs/common';
import { PAGO_FIADO_REPOSITORY } from '../domain/cliente.repository';
import { PagoFiado } from '../domain/pago-fiado.entity';
import type { PagoFiadoPort } from '../domain/ports/pago-fiado.port';

@Injectable()
export class ListarAbonosClienteUseCase {
  constructor(@Inject(PAGO_FIADO_REPOSITORY) private readonly pagos: PagoFiadoPort) {}

  async ejecutar(idCliente: number): Promise<PagoFiado[]> {
    return this.pagos.listarPorCliente(idCliente);
  }
}
