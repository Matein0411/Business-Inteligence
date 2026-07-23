import { Categoria } from '../categoria.entity';

export interface CategoriaLector {
  buscarTodas(): Promise<Categoria[]>;
}
