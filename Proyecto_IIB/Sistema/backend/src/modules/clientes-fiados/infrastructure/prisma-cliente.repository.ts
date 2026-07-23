import { Injectable } from '@nestjs/common';
import { Cliente as ClientePrisma } from '@prisma/client';
import { PrismaService } from '../../../shared/prisma/prisma.service';
import { Cliente, NuevoClienteDatos } from '../domain/cliente.entity';
import { ClienteRepository } from '../domain/cliente.repository';
import { FiltroClientes } from '../domain/ports/cliente-lector.port';

@Injectable()
export class PrismaClienteRepository implements ClienteRepository {
  constructor(private readonly prisma: PrismaService) {}

  async buscarTodos(filtro?: FiltroClientes): Promise<Cliente[]> {
    const registros = await this.prisma.cliente.findMany({
      where: { clienteFrecuente: filtro?.soloFrecuentes ? true : undefined },
      orderBy: { nombres: 'asc' },
    });
    return registros.map(this.aDominio);
  }

  async buscarPorId(id: number): Promise<Cliente | null> {
    const registro = await this.prisma.cliente.findUnique({ where: { idCliente: id } });
    return registro ? this.aDominio(registro) : null;
  }

  async crear(datos: NuevoClienteDatos): Promise<Cliente> {
    const registro = await this.prisma.cliente.create({
      data: {
        nombres: datos.nombres,
        cedula: datos.cedula ?? null,
        telefono: datos.telefono ?? null,
        barrio: datos.barrio ?? null,
        clienteFrecuente: datos.clienteFrecuente ?? false,
        limiteCredito: datos.limiteCredito ?? 0,
      },
    });
    return this.aDominio(registro);
  }

  async actualizar(id: number, datos: Partial<NuevoClienteDatos>): Promise<Cliente> {
    const registro = await this.prisma.cliente.update({
      where: { idCliente: id },
      data: datos,
    });
    return this.aDominio(registro);
  }

  private aDominio(registro: ClientePrisma): Cliente {
    return new Cliente(
      registro.idCliente,
      registro.nombres,
      registro.cedula,
      registro.telefono,
      registro.barrio,
      registro.clienteFrecuente,
      Number(registro.limiteCredito),
    );
  }
}
