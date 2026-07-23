export type RolUsuario = 'dueno' | 'vendedor';

export interface JwtPayload {
  sub: number;
  nombreUsuario: string;
  rol: RolUsuario;
}
