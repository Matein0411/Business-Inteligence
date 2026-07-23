export interface PasswordHasher {
  hash(textoPlano: string): Promise<string>;
  comparar(textoPlano: string, hash: string): Promise<boolean>;
}
