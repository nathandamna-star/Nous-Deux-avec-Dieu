import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { describe, it } from 'node:test';
import { documentsDepart } from '../depart.js';

const lire = (f) => JSON.parse(readFileSync(new URL(`../depart/${f}`, import.meta.url), 'utf8'));
const contenus = lire('contenus.json');
const parcours = lire('parcours.json');
const LANGUES = ['fr', 'en', 'pt', 'es', 'nl'];

describe('contenus de départ', () => {
  it('30 méditations, 60 questions, 4 parcours de 5 étapes, dans les 5 langues', () => {
    const nb = (t) => contenus.filter((c) => c.type === t).length;
    assert.equal(nb('meditation'), 30);
    assert.equal(nb('question'), 60);
    assert.equal(parcours.length, 4);
    const ids = new Set(contenus.map((c) => c.id));
    assert.equal(ids.size, contenus.length);
    for (const p of parcours) {
      assert.equal(p.etapes.length, 5);
      for (const e of p.etapes) assert.ok(ids.has(e), e);
      assert.deepEqual(Object.keys(p.titre).sort(), [...LANGUES].sort());
    }
    for (const c of contenus) {
      for (const l of LANGUES) {
        assert.ok(c.titre[l]?.length > 0 && c.titre[l].length <= 150, `${c.id} ${l}`);
        if (c.type !== 'question') assert.ok(c.texte[l]?.length > 50, `${c.id} ${l}`);
      }
    }
  });

  it('documents conformes aux règles : publiés, publics, champs attendus', () => {
    const docs = documentsDepart(contenus, parcours, 'maintenant');
    assert.equal(docs.length, 114);
    const med = docs.find((d) => d.chemin === 'contenus/depart-meditation-01').donnees;
    assert.deepEqual(Object.keys(med).sort(), [
      'createdAt', 'ordre', 'publie', 'reference', 'texte', 'theme', 'titre', 'type', 'updatedAt', 'visibilite',
    ]);
    assert.equal(med.publie, true);
    assert.equal(med.visibilite, 'public');
    assert.match(med.texte.fr, /À deux :/);
    const p = docs.find((d) => d.chemin === 'parcours/depart-parcours-pardon').donnees;
    assert.equal(p.etapes[0], 'depart-pardon-1');
  });
});
