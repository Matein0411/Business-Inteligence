import { ArgumentsHost, Catch, ExceptionFilter } from '@nestjs/common';
import { Response } from 'express';
import { DominioError } from '../domain/errors/dominio.error';
import { NoAutorizadoError } from '../domain/errors/no-autorizado.error';
import { NoEncontradoError } from '../domain/errors/no-encontrado.error';
import { ReglaNegocioError } from '../domain/errors/regla-negocio.error';

/**
 * Traduce errores de dominio (que no conocen HTTP) a respuestas HTTP.
 * Mantiene el dominio/aplicacion libre de detalles de transporte (Dependency Inversion).
 */
@Catch(DominioError)
export class DominioExceptionFilter implements ExceptionFilter {
  catch(exception: DominioError, host: ArgumentsHost) {
    const response = host.switchToHttp().getResponse<Response>();
    const status = this.resolverStatus(exception);

    response.status(status).json({
      statusCode: status,
      error: exception.name,
      message: exception.message,
    });
  }

  private resolverStatus(exception: DominioError): number {
    if (exception instanceof NoEncontradoError) return 404;
    if (exception instanceof NoAutorizadoError) return 401;
    if (exception instanceof ReglaNegocioError) return 409;
    return 400;
  }
}
