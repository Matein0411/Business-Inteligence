import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from '../../../shared/prisma/prisma.service';
import { NivelRiesgo, RiesgoFiado, SaldoCliente } from '../domain/saldo-cliente.entity';
import { SaldoClientePort } from '../domain/ports/saldo-cliente.port';

interface FilaVistaSaldoCliente {
  id_cliente: number;
  nombres: string;
  limite_credito: unknown;
  total_fiado: unknown;
  total_abonado: unknown;
  saldo_pendiente: unknown;
  credito_disponible: unknown;
}

interface FilaVistaRiesgoFiado extends FilaVistaSaldoCliente {
  pct_utilizacion_credito: unknown;
  dias_sin_abonar: unknown;
  nivel_riesgo: NivelRiesgo;
}

const numero = (valor: unknown): number => (valor === null || valor === undefined ? 0 : Number(valor));
const numeroONulo = (valor: unknown): number | null => (valor === null || valor === undefined ? null : Number(valor));

/**
 * Lee las vistas vista_saldo_cliente / vista_riesgo_fiado (db/schema.sql) via SQL
 * crudo: Prisma no modela vistas por defecto y aqui no aporta nada modelarlas,
 * son solo lecturas agregadas ya resueltas por Postgres.
 */
@Injectable()
export class PrismaSaldoClienteRepository implements SaldoClientePort {
  constructor(private readonly prisma: PrismaService) {}

  async consultarSaldo(idCliente: number): Promise<SaldoCliente | null> {
    const filas = await this.prisma.$queryRaw<FilaVistaSaldoCliente[]>(
      Prisma.sql`SELECT id_cliente, nombres, limite_credito, total_fiado, total_abonado, saldo_pendiente, credito_disponible
                 FROM vista_saldo_cliente WHERE id_cliente = ${idCliente}`,
    );
    const fila = filas[0];
    if (!fila) return null;

    return new SaldoCliente(
      fila.id_cliente,
      fila.nombres,
      numero(fila.limite_credito),
      numero(fila.total_fiado),
      numero(fila.total_abonado),
      numero(fila.saldo_pendiente),
      numero(fila.credito_disponible),
    );
  }

  async listarRiesgo(): Promise<RiesgoFiado[]> {
    const filas = await this.prisma.$queryRaw<FilaVistaRiesgoFiado[]>(
      Prisma.sql`SELECT id_cliente, nombres, limite_credito, saldo_pendiente,
                        pct_utilizacion_credito, dias_sin_abonar, nivel_riesgo
                 FROM vista_riesgo_fiado ORDER BY saldo_pendiente DESC`,
    );

    return filas.map(
      (fila) =>
        new RiesgoFiado(
          fila.id_cliente,
          fila.nombres,
          numero(fila.saldo_pendiente),
          numero(fila.limite_credito),
          numeroONulo(fila.pct_utilizacion_credito),
          numeroONulo(fila.dias_sin_abonar),
          fila.nivel_riesgo,
        ),
    );
  }
}
