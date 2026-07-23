import { IsIn, IsNumber, IsOptional, IsPositive, IsString } from 'class-validator';

const METODOS_PAGO_FIADO = ['efectivo', 'transferencia'] as const;

export class RegistrarAbonoDto {
  @IsNumber()
  @IsPositive()
  monto: number;

  @IsOptional()
  @IsIn(METODOS_PAGO_FIADO)
  metodoPago?: (typeof METODOS_PAGO_FIADO)[number];

  @IsOptional()
  @IsString()
  observacion?: string;
}
