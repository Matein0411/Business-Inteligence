import { Venta } from '../../domain/venta.entity';

class LineaVentaResponseDto {
  idProducto: number;
  nombreProducto: string;
  cantidad: number;
  precioUnitario: number;
  subtotal: number;
}

export class VentaResponseDto {
  id: number;
  fechaHora: Date;
  idCliente: number | null;
  metodoPago: string;
  estadoVenta: string;
  total: number;
  lineas: LineaVentaResponseDto[];

  static desdeDominio(venta: Venta): VentaResponseDto {
    const dto = new VentaResponseDto();
    dto.id = venta.id;
    dto.fechaHora = venta.fechaHora;
    dto.idCliente = venta.idCliente;
    dto.metodoPago = venta.metodoPago;
    dto.estadoVenta = venta.estadoVenta;
    dto.total = venta.total;
    dto.lineas = venta.lineas.map((l) => ({
      idProducto: l.idProducto,
      nombreProducto: l.nombreProducto,
      cantidad: l.cantidad,
      precioUnitario: l.precioUnitario,
      subtotal: l.subtotal,
    }));
    return dto;
  }
}
