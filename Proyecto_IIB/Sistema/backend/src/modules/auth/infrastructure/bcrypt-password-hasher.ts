import { Injectable } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { PasswordHasher } from '../domain/ports/password-hasher.port';

@Injectable()
export class BcryptPasswordHasher implements PasswordHasher {
  private readonly rondas = 10;

  async hash(textoPlano: string): Promise<string> {
    return bcrypt.hash(textoPlano, this.rondas);
  }

  async comparar(textoPlano: string, hash: string): Promise<boolean> {
    return bcrypt.compare(textoPlano, hash);
  }
}
