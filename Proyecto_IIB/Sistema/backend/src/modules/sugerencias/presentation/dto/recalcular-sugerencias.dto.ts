import { IsNumber, IsOptional, Max, Min } from 'class-validator';

export class RecalcularSugerenciasDto {
  @IsOptional()
  @IsNumber()
  @Min(0)
  @Max(1)
  soporteMinimo?: number;

  @IsOptional()
  @IsNumber()
  @Min(0)
  @Max(1)
  confianzaMinima?: number;
}
