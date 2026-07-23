export class ReglaAsociacion {
  constructor(
    public readonly idProductoAntecedente: number,
    public readonly idProductoConsecuente: number,
    public readonly soporte: number,
    public readonly confianza: number,
    public readonly lift: number,
    public readonly fechaCalculo: Date,
    public readonly nombreAntecedente?: string,
    public readonly nombreConsecuente?: string,
  ) {}
}

/** Resultado crudo del motor Apriori, antes de persistirse (sin fecha, la pone el repositorio). */
export interface ReglaCalculada {
  idProductoAntecedente: number;
  idProductoConsecuente: number;
  soporte: number;
  confianza: number;
  lift: number;
}

export interface OpcionesApriori {
  /** Proporcion minima de ventas en las que debe aparecer un item/par (ej. 0.02 = 2%). */
  soporteMinimo: number;
  /** P(consecuente | antecedente) minima para aceptar la regla (ej. 0.3 = 30%). */
  confianzaMinima: number;
}
