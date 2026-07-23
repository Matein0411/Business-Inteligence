import {
  IsBoolean,
  IsIn,
  IsInt,
  IsNumber,
  IsOptional,
  IsPositive,
  IsString,
  Min,
} from 'class-validator';

const UNIDADES_MEDIDA = ['unidad', 'kg', 'g', 'litro', 'ml', 'paquete'] as const;

export class CrearProductoDto {
  @IsString()
  nombre: string;

  @IsInt()
  idCategoria: number;

  @IsOptional()
  @IsString()
  marca?: string;

  @IsIn(UNIDADES_MEDIDA)
  unidadMedida: (typeof UNIDADES_MEDIDA)[number];

  @IsNumber()
  @IsPositive()
  precioCompra: number;

  @IsNumber()
  @IsPositive()
  precioVenta: number;

  @IsInt()
  @Min(0)
  stockActual: number;

  @IsInt()
  @Min(0)
  stockMinimo: number;

  @IsOptional()
  @IsBoolean()
  activo?: boolean;
}
