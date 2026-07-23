import { Type } from 'class-transformer';
import {
  ArrayMinSize,
  IsArray,
  IsIn,
  IsInt,
  IsOptional,
  IsPositive,
  ValidateNested,
} from 'class-validator';

const METODOS_PAGO = ['efectivo', 'tarjeta', 'transferencia', 'fiado'] as const;

export class LineaVentaDto {
  @IsInt()
  idProducto: number;

  @IsInt()
  @IsPositive()
  cantidad: number;
}

export class RegistrarVentaDto {
  @IsOptional()
  @IsInt()
  idCliente?: number;

  @IsIn(METODOS_PAGO)
  metodoPago: (typeof METODOS_PAGO)[number];

  @IsArray()
  @ArrayMinSize(1)
  @ValidateNested({ each: true })
  @Type(() => LineaVentaDto)
  lineas: LineaVentaDto[];
}
