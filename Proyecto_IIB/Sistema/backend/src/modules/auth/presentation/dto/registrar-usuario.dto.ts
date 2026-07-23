import { IsIn, IsOptional, IsString, MinLength } from 'class-validator';

const ROLES = ['dueno', 'vendedor'] as const;

export class RegistrarUsuarioDto {
  @IsString()
  @MinLength(3)
  nombreUsuario: string;

  @IsString()
  @MinLength(6)
  contrasena: string;

  @IsString()
  @MinLength(3)
  nombreCompleto: string;

  @IsOptional()
  @IsIn(ROLES)
  rol?: (typeof ROLES)[number];
}
