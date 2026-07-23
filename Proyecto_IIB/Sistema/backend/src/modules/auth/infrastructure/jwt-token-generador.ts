import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { JwtPayload } from '../../../shared/auth/jwt-payload.interface';
import { GeneradorToken } from '../domain/ports/generador-token.port';

@Injectable()
export class JwtTokenGenerador implements GeneradorToken {
  constructor(private readonly jwtService: JwtService) {}

  async generar(payload: JwtPayload): Promise<string> {
    return this.jwtService.signAsync(payload);
  }
}
