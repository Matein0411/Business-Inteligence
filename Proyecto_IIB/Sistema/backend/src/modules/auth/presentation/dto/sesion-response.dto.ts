import { ResultadoInicioSesion } from '../../application/iniciar-sesion.use-case';
import { UsuarioResponseDto } from './usuario-response.dto';

export class SesionResponseDto {
  token: string;
  usuario: UsuarioResponseDto;

  static desdeResultado(resultado: ResultadoInicioSesion): SesionResponseDto {
    const dto = new SesionResponseDto();
    dto.token = resultado.token;
    dto.usuario = UsuarioResponseDto.desdeDominio(resultado.usuario);
    return dto;
  }
}
