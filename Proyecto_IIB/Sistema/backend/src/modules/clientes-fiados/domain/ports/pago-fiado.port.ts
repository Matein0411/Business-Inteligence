import { NuevoPagoFiadoDatos, PagoFiado } from '../pago-fiado.entity';

export interface PagoFiadoPort {
  registrar(datos: NuevoPagoFiadoDatos): Promise<PagoFiado>;
  listarPorCliente(idCliente: number): Promise<PagoFiado[]>;
}
