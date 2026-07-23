import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { JwtPayload } from './jwt-payload.interface';

/**
 * Guard JWT liviano (sin Passport): valida el header Authorization: Bearer <token>
 * y adjunta el payload decodificado como request.usuario para los controladores.
 */
@Injectable()
export class JwtAuthGuard implements CanActivate {
  constructor(private readonly jwtService: JwtService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const token = this.extraerToken(request.headers.authorization);

    if (!token) {
      throw new UnauthorizedException('Se requiere un token de autenticacion');
    }

    try {
      request.usuario = await this.jwtService.verifyAsync<JwtPayload>(token);
      return true;
    } catch {
      throw new UnauthorizedException('Token invalido o expirado');
    }
  }

  private extraerToken(header: string | undefined): string | null {
    if (!header) return null;
    const [tipo, token] = header.split(' ');
    return tipo === 'Bearer' && token ? token : null;
  }
}
