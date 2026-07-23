import { Injectable } from '@nestjs/common';
import { RolUsuario } from '../../../shared/auth/jwt-payload.interface';
import { PrismaService } from '../../../shared/prisma/prisma.service';
import { Usuario, UsuarioAutenticable } from '../domain/usuario.entity';
import { NuevoUsuarioConHash, UsuarioRepository } from '../domain/ports/usuario.repository';

@Injectable()
export class PrismaUsuarioRepository implements UsuarioRepository {
  constructor(private readonly prisma: PrismaService) {}

  async buscarPorNombreUsuario(nombreUsuario: string): Promise<UsuarioAutenticable | null> {
    const registro = await this.prisma.usuario.findUnique({ where: { nombreUsuario } });
    if (!registro) return null;

    return {
      id: registro.idUsuario,
      nombreUsuario: registro.nombreUsuario,
      nombreCompleto: registro.nombreCompleto,
      rol: registro.rol as RolUsuario,
      activo: registro.activo,
      contrasenaHash: registro.contrasenaHash,
    };
  }

  async crear(datos: NuevoUsuarioConHash): Promise<Usuario> {
    const registro = await this.prisma.usuario.create({
      data: {
        nombreUsuario: datos.nombreUsuario,
        contrasenaHash: datos.contrasenaHash,
        nombreCompleto: datos.nombreCompleto,
        rol: datos.rol,
      },
    });

    return new Usuario(
      registro.idUsuario,
      registro.nombreUsuario,
      registro.nombreCompleto,
      registro.rol as RolUsuario,
      registro.activo,
    );
  }
}
