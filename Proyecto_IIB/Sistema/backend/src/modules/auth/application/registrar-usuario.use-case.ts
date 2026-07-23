import { Inject, Injectable } from '@nestjs/common';
import { NuevoUsuarioDatos, Usuario } from '../domain/usuario.entity';
import { PASSWORD_HASHER, USUARIO_REPOSITORY } from '../domain/auth.tokens';
import type { PasswordHasher } from '../domain/ports/password-hasher.port';
import type { UsuarioRepository } from '../domain/ports/usuario.repository';

@Injectable()
export class RegistrarUsuarioUseCase {
  constructor(
    @Inject(USUARIO_REPOSITORY) private readonly usuarios: UsuarioRepository,
    @Inject(PASSWORD_HASHER) private readonly hasher: PasswordHasher,
  ) {}

  async ejecutar(datos: NuevoUsuarioDatos): Promise<Usuario> {
    const contrasenaHash = await this.hasher.hash(datos.contrasena);
    return this.usuarios.crear({
      nombreUsuario: datos.nombreUsuario,
      contrasenaHash,
      nombreCompleto: datos.nombreCompleto,
      rol: datos.rol ?? 'vendedor',
    });
  }
}
