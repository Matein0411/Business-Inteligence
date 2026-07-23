import { NuevaVentaDatos, Venta } from '../venta.entity';

export interface VentaEscritor {
  /**
   * Resuelve precio y descuenta stock dentro de una misma transaccion de BD
   * (ver PrismaVentaRepository); el trigger trg_validar_limite_fiado valida
   * el cupo de credito a nivel de base de datos si metodoPago es 'fiado'.
   */
  registrar(datos: NuevaVentaDatos): Promise<Venta>;
  anular(id: number): Promise<Venta>;
}
