import { Controller, Get } from '@nestjs/common';

@Controller()
export class AppController {
  @Get()
  salud() {
    return { status: 'ok', servicio: 'kipu-data-api' };
  }
}
