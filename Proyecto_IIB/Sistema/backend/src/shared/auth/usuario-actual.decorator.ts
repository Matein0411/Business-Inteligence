import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { JwtPayload } from './jwt-payload.interface';

/** Extrae el usuario autenticado (adjuntado por JwtAuthGuard) en un handler de controlador. */
export const UsuarioActual = createParamDecorator((_: unknown, ctx: ExecutionContext): JwtPayload => {
  const request = ctx.switchToHttp().getRequest();
  return request.usuario;
});
