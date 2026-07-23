import { Usuario } from '../../domain/usuario.entity';

export class UsuarioResponseDto {
  id: number;
  nombreUsuario: string;
  nombreCompleto: string;
  rol: string;
  activo: boolean;

  static desdeDominio(usuario: Usuario): UsuarioResponseDto {
    const dto = new UsuarioResponseDto();
    dto.id = usuario.id;
    dto.nombreUsuario = usuario.nombreUsuario;
    dto.nombreCompleto = usuario.nombreCompleto;
    dto.rol = usuario.rol;
    dto.activo = usuario.activo;
    return dto;
  }
}
