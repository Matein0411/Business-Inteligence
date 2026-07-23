import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../shared/prisma/prisma.service';
import { Categoria } from '../domain/categoria.entity';
import { CategoriaLector } from '../domain/ports/categoria-lector.port';

@Injectable()
export class PrismaCategoriaRepository implements CategoriaLector {
  constructor(private readonly prisma: PrismaService) {}

  async buscarTodas(): Promise<Categoria[]> {
    const registros = await this.prisma.categoria.findMany({ orderBy: { nombre: 'asc' } });
    return registros.map((r) => new Categoria(r.idCategoria, r.nombre, r.descripcion));
  }
}
