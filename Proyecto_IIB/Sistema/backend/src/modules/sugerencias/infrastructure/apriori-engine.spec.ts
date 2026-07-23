import { AprioriEngine } from './apriori-engine';

describe('AprioriEngine', () => {
  it('genera una regla cuando un par co-ocurre por encima de los umbrales', () => {
    const motor = new AprioriEngine();
    // 15 y 16 co-ocurren en 3 de 6 canastas; 15 aparece en 4, 16 en 3.
    const canastas = [
      [15, 16],
      [15, 16],
      [15, 16],
      [15],
      [16, 99],
      [22],
    ];

    const reglas = motor.generar(canastas, { soporteMinimo: 0.02, confianzaMinima: 0.3 });
    console.log(JSON.stringify(reglas));

    const regla15a16 = reglas.find((r) => r.idProductoAntecedente === 15 && r.idProductoConsecuente === 16);
    expect(regla15a16).toBeDefined();
    expect(regla15a16!.soporte).toBeCloseTo(3 / 6, 5);
    expect(regla15a16!.confianza).toBeCloseTo(3 / 4, 5);
  });
});
