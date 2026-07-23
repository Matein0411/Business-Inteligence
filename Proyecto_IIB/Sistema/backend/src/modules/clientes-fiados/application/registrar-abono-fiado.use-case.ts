import { Inject, Injectable } from '@nestjs/common';
import { NoEncontradoError } from '../../../shared/domain/errors/no-encontrado.error';
import { CLIENTE_REPOSITORY, PAGO_FIADO_REPOSITORY } from '../domain/cliente.repository';
import { NuevoPagoFiadoDatos, PagoFiado } from '../domain/pago-fiado.entity';
import type { ClienteLector } from '../domain/ports/cliente-lector.port';
import type { PagoFiadoPort } from '../domain/ports/pago-fiado.port';

@Injectable()
export class RegistrarAbonoFiadoUseCase {
  constructor(
    @Inject(CLIENTE_REPOSITORY) private readonly clientes: ClienteLector,
    @Inject(PAGO_FIADO_REPOSITORY) private readonly pagos: PagoFiadoPort,
  ) {}

  async ejecutar(datos: NuevoPagoFiadoDatos): Promise<PagoFiado> {
    const cliente = await this.clientes.buscarPorId(datos.idCliente);
    if (!cliente) {
      throw new NoEncontradoError('Cliente', datos.idCliente);
    }
    return this.pagos.registrar(datos);
  }
}
