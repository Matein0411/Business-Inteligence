import { IsBoolean, IsNumber, IsOptional, IsString, Matches, Min } from 'class-validator';

export class CrearClienteDto {
  @IsString()
  nombres: string;

  @IsOptional()
  @Matches(/^\d{10}$/, { message: 'cedula debe tener 10 digitos' })
  cedula?: string;

  @IsOptional()
  @IsString()
  telefono?: string;

  @IsOptional()
  @IsString()
  barrio?: string;

  @IsOptional()
  @IsBoolean()
  clienteFrecuente?: boolean;

  @IsOptional()
  @IsNumber()
  @Min(0)
  limiteCredito?: number;
}
