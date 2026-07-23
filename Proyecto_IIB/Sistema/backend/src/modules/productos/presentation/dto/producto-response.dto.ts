import { Producto } from '../../domain/producto.entity';

/** Mapea la entidad de dominio a la forma que ve el cliente HTTP (nunca al reves). */
export class ProductoResponseDto {
  id: number;
  nombre: string;
  idCategoria: number;
  marca: string | null;
  unidadMedida: string;
  precioCompra: number;
  precioVenta: number;
  stockActual: number;
  stockMinimo: number;
  stockBajo: boolean;
  margenGanancia: number;
  activo: boolean;

  static desdeDominio(producto: Producto): ProductoResponseDto {
    const dto = new ProductoResponseDto();
    dto.id = producto.id;
    dto.nombre = producto.nombre;
    dto.idCategoria = producto.idCategoria;
    dto.marca = producto.marca;
    dto.unidadMedida = producto.unidadMedida;
    dto.precioCompra = producto.precioCompra;
    dto.precioVenta = producto.precioVenta;
    dto.stockActual = producto.stockActual;
    dto.stockMinimo = producto.stockMinimo;
    dto.stockBajo = producto.stockBajo;
    dto.margenGanancia = producto.margenGanancia;
    dto.activo = producto.activo;
    return dto;
  }
}
