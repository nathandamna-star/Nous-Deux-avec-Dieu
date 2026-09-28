import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import { commandeEnCours, departMembre, profilExporte, versJson } from '../compte.js';

describe('compte', () => {
  it('export : dates lisibles, sans jetons de notification', () => {
    const date = new Date('2030-01-10T08:00:00Z');
    const ts = { toDate: () => date };
    assert.deepEqual(versJson({ a: ts, b: [ts, 1], c: { d: null } }),
      { a: '2030-01-10T08:00:00.000Z', b: ['2030-01-10T08:00:00.000Z', 1], c: { d: null } });
    assert.deepEqual(profilExporte({ nom: 'Marie', jetonsNotif: ['x'], createdAt: ts }),
      { nom: 'Marie', createdAt: '2030-01-10T08:00:00.000Z' });
  });

  it('départ d\'un membre : le conjoint garde l\'accompagnement', () => {
    const acc = { membres: ['marie', 'paul'], noms: { marie: 'Marie', paul: 'Paul' }, nonLus: { marie: 1, paul: 2 } };
    assert.deepEqual(departMembre(acc, 'marie'),
      { supprimer: false, maj: { membres: ['paul'], noms: { paul: 'Paul' }, nonLus: { paul: 2 } } });
    assert.deepEqual(departMembre({ membres: ['marie'] }, 'marie'), { supprimer: true });
  });

  it('commande payée pas encore envoyée : suppression refusée', () => {
    assert.equal(commandeEnCours([{ statut: 'envoyee' }, { statut: 'en_attente' }]), false);
    assert.equal(commandeEnCours([{ statut: 'payee' }]), true);
  });
});
