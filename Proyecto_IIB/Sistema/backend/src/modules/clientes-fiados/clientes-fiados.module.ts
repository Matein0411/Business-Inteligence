import { Module } from '@nestjs/common';
import { ActualizarClienteUseCase } from './application/actualizar-cliente.use-case';
import { ConsultarSaldoClienteUseCase } from './application/consultar-saldo-cliente.use-case';
import { CrearClienteUseCase } from './application/crear-cliente.use-case';
import { ListarAbonosClienteUseCase } from './application/listar-abonos-cliente.use-case';
import { ListarClientesUseCase } from './application/listar-clientes.use-case';
import { ListarRiesgoFiadoUseCase } from './application/listar-riesgo-fiado.use-case';
import { ObtenerClienteUseCase } from './application/obtener-cliente.use-case';
import { RegistrarAbonoFiadoUseCase } from './application/registrar-abono-fiado.use-case';
import { CLIENTE_REPOSITORY, PAGO_FIADO_REPOSITORY, SALDO_CLIENTE_REPOSITORY } from './domain/cliente.repository';
import { PrismaClienteRepository } from './infrastructure/prisma-cliente.repository';
import { PrismaPagoFiadoRepository } from './infrastructure/prisma-pago-fiado.repository';
import { PrismaSaldoClienteRepository } from './infrastructure/prisma-saldo-cliente.repository';
import { ClientesController } from './presentation/clientes.controller';

@Module({
  controllers: [ClientesController],
  providers: [
    ListarClientesUseCase,
    ObtenerClienteUseCase,
    CrearClienteUseCase,
    ActualizarClienteUseCase,
    ConsultarSaldoClienteUseCase,
    ListarRiesgoFiadoUseCase,
    RegistrarAbonoFiadoUseCase,
    ListarAbonosClienteUseCase,
    { provide: CLIENTE_REPOSITORY, useClass: PrismaClienteRepository },
    { provide: SALDO_CLIENTE_REPOSITORY, useClass: PrismaSaldoClienteRepository },
    { provide: PAGO_FIADO_REPOSITORY, useClass: PrismaPagoFiadoRepository },
  ],
})
export class ClientesFiadosModule {}
