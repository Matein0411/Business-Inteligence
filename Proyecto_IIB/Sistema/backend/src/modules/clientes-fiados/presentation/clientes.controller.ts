import { Body, Controller, Get, Param, ParseIntPipe, Patch, Post, Query, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../../../shared/auth/jwt-auth.guard';
import { ActualizarClienteUseCase } from '../application/actualizar-cliente.use-case';
import { ConsultarSaldoClienteUseCase } from '../application/consultar-saldo-cliente.use-case';
import { CrearClienteUseCase } from '../application/crear-cliente.use-case';
import { ListarAbonosClienteUseCase } from '../application/listar-abonos-cliente.use-case';
import { ListarClientesUseCase } from '../application/listar-clientes.use-case';
import { ListarRiesgoFiadoUseCase } from '../application/listar-riesgo-fiado.use-case';
import { ObtenerClienteUseCase } from '../application/obtener-cliente.use-case';
import { RegistrarAbonoFiadoUseCase } from '../application/registrar-abono-fiado.use-case';
import { ActualizarClienteDto } from './dto/actualizar-cliente.dto';
import { ClienteResponseDto } from './dto/cliente-response.dto';
import { CrearClienteDto } from './dto/crear-cliente.dto';
import { PagoFiadoResponseDto } from './dto/pago-fiado-response.dto';
import { RegistrarAbonoDto } from './dto/registrar-abono.dto';
import { RiesgoFiadoResponseDto, SaldoClienteResponseDto } from './dto/saldo-cliente-response.dto';

@Controller('clientes')
@UseGuards(JwtAuthGuard)
export class ClientesController {
  constructor(
    private readonly listarClientes: ListarClientesUseCase,
    private readonly obtenerCliente: ObtenerClienteUseCase,
    private readonly crearCliente: CrearClienteUseCase,
    private readonly actualizarCliente: ActualizarClienteUseCase,
    private readonly consultarSaldo: ConsultarSaldoClienteUseCase,
    private readonly listarRiesgoFiado: ListarRiesgoFiadoUseCase,
    private readonly registrarAbono: RegistrarAbonoFiadoUseCase,
    private readonly listarAbonos: ListarAbonosClienteUseCase,
  ) {}

  @Get()
  async listar(@Query('frecuentes') frecuentes?: string): Promise<ClienteResponseDto[]> {
    const clientes = await this.listarClientes.ejecutar({ soloFrecuentes: frecuentes === 'true' });
    return clientes.map(ClienteResponseDto.desdeDominio);
  }

  /** Debe declararse antes de ':id' para que Nest no intente parsear 'riesgo' como id numerico. */
  @Get('riesgo')
  async riesgo(): Promise<RiesgoFiadoResponseDto[]> {
    const riesgos = await this.listarRiesgoFiado.ejecutar();
    return riesgos.map(RiesgoFiadoResponseDto.desdeDominio);
  }

  @Get(':id')
  async obtener(@Param('id', ParseIntPipe) id: number): Promise<ClienteResponseDto> {
    const cliente = await this.obtenerCliente.ejecutar(id);
    return ClienteResponseDto.desdeDominio(cliente);
  }

  @Post()
  async crear(@Body() dto: CrearClienteDto): Promise<ClienteResponseDto> {
    const cliente = await this.crearCliente.ejecutar(dto);
    return ClienteResponseDto.desdeDominio(cliente);
  }

  @Patch(':id')
  async actualizar(
    @Param('id', ParseIntPipe) id: number,
    @Body() dto: ActualizarClienteDto,
  ): Promise<ClienteResponseDto> {
    const cliente = await this.actualizarCliente.ejecutar(id, dto);
    return ClienteResponseDto.desdeDominio(cliente);
  }

  @Get(':id/saldo')
  async saldo(@Param('id', ParseIntPipe) id: number): Promise<SaldoClienteResponseDto> {
    const saldo = await this.consultarSaldo.ejecutar(id);
    return SaldoClienteResponseDto.desdeDominio(saldo);
  }

  @Get(':id/abonos')
  async abonos(@Param('id', ParseIntPipe) id: number): Promise<PagoFiadoResponseDto[]> {
    const abonos = await this.listarAbonos.ejecutar(id);
    return abonos.map(PagoFiadoResponseDto.desdeDominio);
  }

  @Post(':id/abonos')
  async registrarAbonoCliente(
    @Param('id', ParseIntPipe) id: number,
    @Body() dto: RegistrarAbonoDto,
  ): Promise<PagoFiadoResponseDto> {
    const abono = await this.registrarAbono.ejecutar({ idCliente: id, ...dto });
    return PagoFiadoResponseDto.desdeDominio(abono);
  }
}
