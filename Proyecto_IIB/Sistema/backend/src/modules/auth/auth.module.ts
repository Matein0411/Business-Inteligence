import { Module } from '@nestjs/common';
import { IniciarSesionUseCase } from './application/iniciar-sesion.use-case';
import { RegistrarUsuarioUseCase } from './application/registrar-usuario.use-case';
import { GENERADOR_TOKEN, PASSWORD_HASHER, USUARIO_REPOSITORY } from './domain/auth.tokens';
import { BcryptPasswordHasher } from './infrastructure/bcrypt-password-hasher';
import { JwtTokenGenerador } from './infrastructure/jwt-token-generador';
import { PrismaUsuarioRepository } from './infrastructure/prisma-usuario.repository';
import { AuthController } from './presentation/auth.controller';

@Module({
  controllers: [AuthController],
  providers: [
    IniciarSesionUseCase,
    RegistrarUsuarioUseCase,
    { provide: USUARIO_REPOSITORY, useClass: PrismaUsuarioRepository },
    { provide: PASSWORD_HASHER, useClass: BcryptPasswordHasher },
    { provide: GENERADOR_TOKEN, useClass: JwtTokenGenerador },
  ],
})
export class AuthModule {}
