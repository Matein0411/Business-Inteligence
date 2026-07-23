import { Categoria } from '../../domain/categoria.entity';

export class CategoriaResponseDto {
  id: number;
  nombre: string;
  descripcion: string | null;

  static desdeDominio(categoria: Categoria): CategoriaResponseDto {
    const dto = new CategoriaResponseDto();
    dto.id = categoria.id;
    dto.nombre = categoria.nombre;
    dto.descripcion = categoria.descripcion;
    return dto;
  }
}
