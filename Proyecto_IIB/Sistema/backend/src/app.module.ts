import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AuthModule } from './modules/auth/auth.module';
import { CategoriasModule } from './modules/categorias/categorias.module';
import { ClientesFiadosModule } from './modules/clientes-fiados/clientes-fiados.module';
import { ProductosModule } from './modules/productos/productos.module';
import { SugerenciasModule } from './modules/sugerencias/sugerencias.module';
import { VentasModule } from './modules/ventas/ventas.module';
import { AuthCoreModule } from './shared/auth/auth-core.module';
import { PrismaModule } from './shared/prisma/prisma.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    PrismaModule,
    AuthCoreModule,
    AuthModule,
    CategoriasModule,
    ProductosModule,
    VentasModule,
    ClientesFiadosModule,
    SugerenciasModule,
  ],
  controllers: [AppController],
})
export class AppModule {}
