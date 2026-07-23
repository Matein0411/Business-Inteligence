export class Cliente {
  constructor(
    public readonly id: number,
    public nombres: string,
    public cedula: string | null,
    public telefono: string | null,
    public barrio: string | null,
    public clienteFrecuente: boolean,
    public limiteCredito: number,
  ) {}
}

export interface NuevoClienteDatos {
  nombres: string;
  cedula?: string | null;
  telefono?: string | null;
  barrio?: string | null;
  clienteFrecuente?: boolean;
  limiteCredito?: number;
}
