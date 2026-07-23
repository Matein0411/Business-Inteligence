import { RolUsuario } from '../../../../shared/auth/jwt-payload.interface';
import { Usuario, UsuarioAutenticable } from '../usuario.entity';

export interface NuevoUsuarioConHash {
  nombreUsuario: string;
  contrasenaHash: string;
  nombreCompleto: string;
  rol: RolUsuario;
}

export interface UsuarioRepository {
  buscarPorNombreUsuario(nombreUsuario: string): Promise<UsuarioAutenticable | null>;
  crear(datos: NuevoUsuarioConHash): Promise<Usuario>;
}
