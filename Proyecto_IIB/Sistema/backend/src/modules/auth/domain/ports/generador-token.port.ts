import { JwtPayload } from '../../../../shared/auth/jwt-payload.interface';

export interface GeneradorToken {
  generar(payload: JwtPayload): Promise<string>;
}
