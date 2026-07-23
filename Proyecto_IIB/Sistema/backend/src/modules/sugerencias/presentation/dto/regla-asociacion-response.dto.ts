import { ReglaAsociacion } from '../../domain/regla-asociacion.entity';

export class ReglaAsociacionResponseDto {
  idProductoAntecedente: number;
  nombreAntecedente: string | null;
  idProductoConsecuente: number;
  nombreConsecuente: string | null;
  soporte: number;
  confianza: number;
  lift: number;
  fechaCalculo: Date;

  static desdeDominio(regla: ReglaAsociacion): ReglaAsociacionResponseDto {
    const dto = new ReglaAsociacionResponseDto();
    dto.idProductoAntecedente = regla.idProductoAntecedente;
    dto.nombreAntecedente = regla.nombreAntecedente ?? null;
    dto.idProductoConsecuente = regla.idProductoConsecuente;
    dto.nombreConsecuente = regla.nombreConsecuente ?? null;
    dto.soporte = regla.soporte;
    dto.confianza = regla.confianza;
    dto.lift = regla.lift;
    dto.fechaCalculo = regla.fechaCalculo;
    return dto;
  }
}
