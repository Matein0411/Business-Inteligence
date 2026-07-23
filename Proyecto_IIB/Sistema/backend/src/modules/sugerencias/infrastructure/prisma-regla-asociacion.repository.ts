import { Injectable } from '@nestjs/common';
import { Producto as ProductoPrisma, ReglaAsociacion as ReglaAsociacionPrisma } from '@prisma/client';
import { PrismaService } from '../../../shared/prisma/prisma.service';
import { ReglaAsociacion, ReglaCalculada } from '../domain/regla-asociacion.entity';
import { ReglaAsociacionRepository } from '../domain/ports/regla-asociacion.port';

type ReglaConProductos = ReglaAsociacionPrisma & {
  antecedente?: ProductoPrisma;
  consecuente?: ProductoPrisma;
};

@Injectable()
export class PrismaReglaAsociacionRepository implements ReglaAsociacionRepository {
  constructor(private readonly prisma: PrismaService) {}

  async reemplazarTodas(reglas: ReglaCalculada[]): Promise<void> {
    await this.prisma.$transaction([
      this.prisma.reglaAsociacion.deleteMany({}),
      ...(reglas.length > 0
        ? [
            this.prisma.reglaAsociacion.createMany({
              data: reglas.map((r) => ({
                idProductoAntecedente: r.idProductoAntecedente,
                idProductoConsecuente: r.idProductoConsecuente,
                soporte: r.soporte,
                confianza: r.confianza,
                lift: r.lift,
              })),
            }),
          ]
        : []),
    ]);
  }

  async listarPorProducto(idProductoAntecedente: number, limite = 5): Promise<ReglaAsociacion[]> {
    const registros = await this.prisma.reglaAsociacion.findMany({
      where: { idProductoAntecedente },
      include: { antecedente: true, consecuente: true },
      orderBy: [{ confianza: 'desc' }, { lift: 'desc' }],
      take: limite,
    });
    return registros.map((r) => this.aDominio(r));
  }

  async listarTodas(): Promise<ReglaAsociacion[]> {
    const registros = await this.prisma.reglaAsociacion.findMany({
      include: { antecedente: true, consecuente: true },
      orderBy: [{ confianza: 'desc' }],
    });
    return registros.map((r) => this.aDominio(r));
  }

  private aDominio(registro: ReglaConProductos): ReglaAsociacion {
    return new ReglaAsociacion(
      registro.idProductoAntecedente,
      registro.idProductoConsecuente,
      Number(registro.soporte),
      Number(registro.confianza),
      Number(registro.lift),
      registro.fechaCalculo,
      registro.antecedente?.nombre,
      registro.consecuente?.nombre,
    );
  }
}
