import { Injectable } from '@nestjs/common';
import { OpcionesApriori, ReglaCalculada } from '../domain/regla-asociacion.entity';
import { MotorReglasAsociacion } from '../domain/ports/motor-reglas.port';

/**
 * Apriori restringido a itemsets de tamano 2 (pares antecedente -> consecuente).
 * Alcanza para "sugerencias de producto" (quien compra X tambien compra Y) y
 * coincide con la forma de la tabla regla_asociacion (un producto -> un producto);
 * itemsets de 3+ no aportarian aqui porque esa tabla no los podria representar.
 */
@Injectable()
export class AprioriEngine implements MotorReglasAsociacion {
  generar(canastas: number[][], opciones: OpcionesApriori): ReglaCalculada[] {
    const totalTransacciones = canastas.length;
    if (totalTransacciones === 0) return [];

    const soporteItem = this.contarSoporteItems(canastas);

    const itemsFrecuentes = new Set(
      [...soporteItem.entries()]
        .filter(([, conteo]) => conteo / totalTransacciones >= opciones.soporteMinimo)
        .map(([item]) => item),
    );

    const conteoPares = this.contarSoportePares(canastas, itemsFrecuentes);

    const reglas: ReglaCalculada[] = [];
    for (const [clave, conteoPar] of conteoPares) {
      const soportePar = conteoPar / totalTransacciones;
      if (soportePar < opciones.soporteMinimo) continue;

      const [a, b] = clave.split('|').map(Number);
      for (const [antecedente, consecuente] of [
        [a, b],
        [b, a],
      ] as const) {
        const soporteAntecedente = soporteItem.get(antecedente)! / totalTransacciones;
        const confianza = soportePar / soporteAntecedente;
        if (confianza < opciones.confianzaMinima) continue;

        const soporteConsecuente = soporteItem.get(consecuente)! / totalTransacciones;
        const lift = confianza / soporteConsecuente;

        reglas.push({
          idProductoAntecedente: antecedente,
          idProductoConsecuente: consecuente,
          soporte: Number(soportePar.toFixed(5)),
          confianza: Number(confianza.toFixed(5)),
          lift: Number(lift.toFixed(4)),
        });
      }
    }

    return reglas.sort((r1, r2) => r2.confianza - r1.confianza);
  }

  private contarSoporteItems(canastas: number[][]): Map<number, number> {
    const soporteItem = new Map<number, number>();
    for (const canasta of canastas) {
      for (const item of new Set(canasta)) {
        soporteItem.set(item, (soporteItem.get(item) ?? 0) + 1);
      }
    }
    return soporteItem;
  }

  private contarSoportePares(canastas: number[][], itemsFrecuentes: Set<number>): Map<string, number> {
    const conteoPares = new Map<string, number>();
    for (const canasta of canastas) {
      const unicos = [...new Set(canasta)]
        .filter((item) => itemsFrecuentes.has(item))
        .sort((a, b) => a - b);

      for (let i = 0; i < unicos.length; i++) {
        for (let j = i + 1; j < unicos.length; j++) {
          const clave = `${unicos[i]}|${unicos[j]}`;
          conteoPares.set(clave, (conteoPares.get(clave) ?? 0) + 1);
        }
      }
    }
    return conteoPares;
  }
}
