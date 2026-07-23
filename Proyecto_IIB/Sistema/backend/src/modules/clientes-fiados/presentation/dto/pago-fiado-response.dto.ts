import { PagoFiado } from '../../domain/pago-fiado.entity';

export class PagoFiadoResponseDto {
  id: number;
  idCliente: number;
  fechaHora: Date;
  monto: number;
  metodoPago: string;
  observacion: string | null;

  static desdeDominio(pago: PagoFiado): PagoFiadoResponseDto {
    const dto = new PagoFiadoResponseDto();
    dto.id = pago.id;
    dto.idCliente = pago.idCliente;
    dto.fechaHora = pago.fechaHora;
    dto.monto = pago.monto;
    dto.metodoPago = pago.metodoPago;
    dto.observacion = pago.observacion;
    return dto;
  }
}
