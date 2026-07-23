import { CanActivate, ExecutionContext, ForbiddenException, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { JwtPayload, RolUsuario } from './jwt-payload.interface';
import { ROLES_KEY } from './roles.decorator';

/** Debe usarse siempre despues de JwtAuthGuard (necesita request.usuario ya poblado). */
@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const rolesRequeridos = this.reflector.getAllAndOverride<RolUsuario[]>(ROLES_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (!rolesRequeridos || rolesRequeridos.length === 0) {
      return true;
    }

    const usuario: JwtPayload | undefined = context.switchToHttp().getRequest().usuario;
    if (!usuario || !rolesRequeridos.includes(usuario.rol)) {
      throw new ForbiddenException('No tienes permisos para esta accion');
    }
    return true;
  }
}
