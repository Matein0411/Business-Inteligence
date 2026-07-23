import { RolUsuario } from '../../../shared/auth/jwt-payload.interface';

export class Usuario {
  constructor(
    public readonly id: number,
    public readonly nombreUsuario: string,
    public readonly nombreCompleto: string,
    public readonly rol: RolUsuario,
    public readonly activo: boolean,
  ) {}
}

export interface NuevoUsuarioDatos {
  nombreUsuario: string;
  contrasena: string;
  nombreCompleto: string;
  rol?: RolUsuario;
}

/** Forma interna (con hash) usada solo por el flujo de autenticacion; nunca sale al exterior. */
export interface UsuarioAutenticable {
  id: number;
  nombreUsuario: string;
  nombreCompleto: string;
  rol: RolUsuario;
  activo: boolean;
  contrasenaHash: string;
}
