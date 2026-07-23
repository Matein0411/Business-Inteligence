import { ReglaAsociacion, ReglaCalculada } from '../regla-asociacion.entity';

export interface ReglaAsociacionRepository {
  /** Reemplaza todas las reglas vigentes por el nuevo calculo (recalculo completo, no incremental). */
  reemplazarTodas(reglas: ReglaCalculada[]): Promise<void>;
  listarPorProducto(idProductoAntecedente: number, limite?: number): Promise<ReglaAsociacion[]>;
  listarTodas(): Promise<ReglaAsociacion[]>;
}
