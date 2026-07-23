import { Cliente } from '../../domain/cliente.entity';

export class ClienteResponseDto {
  id: number;
  nombres: string;
  cedula: string | null;
  telefono: string | null;
  barrio: string | null;
  clienteFrecuente: boolean;
  limiteCredito: number;

  static desdeDominio(cliente: Cliente): ClienteResponseDto {
    const dto = new ClienteResponseDto();
    dto.id = cliente.id;
    dto.nombres = cliente.nombres;
    dto.cedula = cliente.cedula;
    dto.telefono = cliente.telefono;
    dto.barrio = cliente.barrio;
    dto.clienteFrecuente = cliente.clienteFrecuente;
    dto.limiteCredito = cliente.limiteCredito;
    return dto;
  }
}
