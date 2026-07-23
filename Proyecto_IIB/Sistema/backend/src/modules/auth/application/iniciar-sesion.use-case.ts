import { Inject, Injectable } from '@nestjs/common';
import { NoAutorizadoError } from '../../../shared/domain/errors/no-autorizado.error';
import { Usuario } from '../domain/usuario.entity';
import { GENERADOR_TOKEN, PASSWORD_HASHER, USUARIO_REPOSITORY } from '../domain/auth.tokens';
import type { GeneradorToken } from '../domain/ports/generador-token.port';
import type { PasswordHasher } from '../domain/ports/password-hasher.port';
import type { UsuarioRepository } from '../domain/ports/usuario.repository';

export interface ResultadoInicioSesion {
  token: string;
  usuario: Usuario;
}

@Injectable()
export class IniciarSesionUseCase {
  constructor(
    @Inject(USUARIO_REPOSITORY) private readonly usuarios: UsuarioRepository,
    @Inject(PASSWORD_HASHER) private readonly hasher: PasswordHasher,
    @Inject(GENERADOR_TOKEN) private readonly generadorToken: GeneradorToken,
  ) {}

  async ejecutar(nombreUsuario: string, contrasena: string): Promise<ResultadoInicioSesion> {
    const encontrado = await this.usuarios.buscarPorNombreUsuario(nombreUsuario);
    if (!encontrado || !encontrado.activo) {
      throw new NoAutorizadoError('Usuario o contrasena incorrectos');
    }

    const contrasenaValida = await this.hasher.comparar(contrasena, encontrado.contrasenaHash);
    if (!contrasenaValida) {
      throw new NoAutorizadoError('Usuario o contrasena incorrectos');
    }

    const token = await this.generadorToken.generar({
      sub: encontrado.id,
      nombreUsuario: encontrado.nombreUsuario,
      rol: encontrado.rol,
    });

    return {
      token,
      usuario: new Usuario(encontrado.id, encontrado.nombreUsuario, encontrado.nombreCompleto, encontrado.rol, encontrado.activo),
    };
  }
}
