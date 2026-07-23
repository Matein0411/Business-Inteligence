import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../../../shared/auth/jwt-auth.guard';
import { Roles } from '../../../shared/auth/roles.decorator';
import { RolesGuard } from '../../../shared/auth/roles.guard';
import { IniciarSesionUseCase } from '../application/iniciar-sesion.use-case';
import { RegistrarUsuarioUseCase } from '../application/registrar-usuario.use-case';
import { IniciarSesionDto } from './dto/iniciar-sesion.dto';
import { RegistrarUsuarioDto } from './dto/registrar-usuario.dto';
import { SesionResponseDto } from './dto/sesion-response.dto';
import { UsuarioResponseDto } from './dto/usuario-response.dto';

@Controller('auth')
export class AuthController {
  constructor(
    private readonly iniciarSesion: IniciarSesionUseCase,
    private readonly registrarUsuario: RegistrarUsuarioUseCase,
  ) {}

  @Post('login')
  async login(@Body() dto: IniciarSesionDto): Promise<SesionResponseDto> {
    const resultado = await this.iniciarSesion.ejecutar(dto.nombreUsuario, dto.contrasena);
    return SesionResponseDto.desdeResultado(resultado);
  }

  /** Solo un dueno autenticado puede dar de alta nuevas cuentas (el primer dueno se crea por migracion/seed). */
  @Post('registrar')
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('dueno')
  async registrar(@Body() dto: RegistrarUsuarioDto): Promise<UsuarioResponseDto> {
    const usuario = await this.registrarUsuario.ejecutar(dto);
    return UsuarioResponseDto.desdeDominio(usuario);
  }
}
