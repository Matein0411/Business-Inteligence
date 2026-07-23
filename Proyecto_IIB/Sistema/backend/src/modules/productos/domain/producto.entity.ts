export class Producto {
  constructor(
    public readonly id: number,
    public nombre: string,
    public idCategoria: number,
    public marca: string | null,
    public unidadMedida: string,
    public precioCompra: number,
    public precioVenta: number,
    public stockActual: number,
    public stockMinimo: number,
    public activo: boolean,
  ) {}

  /** Regla de negocio simple vivendo en la entidad, no en un DTO ni en el ORM. */
  get stockBajo(): boolean {
    return this.stockActual <= this.stockMinimo;
  }

  get margenGanancia(): number {
    return Number((this.precioVenta - this.precioCompra).toFixed(2));
  }
}

export interface NuevoProductoDatos {
  nombre: string;
  idCategoria: number;
  marca?: string | null;
  unidadMedida: string;
  precioCompra: number;
  precioVenta: number;
  stockActual: number;
  stockMinimo: number;
  activo?: boolean;
}
