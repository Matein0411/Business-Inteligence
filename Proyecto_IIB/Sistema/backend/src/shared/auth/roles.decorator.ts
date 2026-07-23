import { SetMetadata } from '@nestjs/common';
import { RolUsuario } from './jwt-payload.interface';

export const ROLES_KEY = 'roles';

/** Restringe un endpoint a los roles indicados; requiere RolesGuard activo. */
export const Roles = (...roles: RolUsuario[]) => SetMetadata(ROLES_KEY, roles);
