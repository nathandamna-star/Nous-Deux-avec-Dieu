import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { describe, it } from 'node:test';
import { versHtml } from '../legal.js';

const lire = (chemin) => readFileSync(new URL(chemin, import.meta.url), 'utf8');

describe('pages légales', () => {
  it('les textes en ligne sont ceux de l\'app', () => {
    for (const f of ['cgu_fr.md', 'confidentialite_fr.md', 'support_fr.md']) {
      assert.equal(lire(`../legal/${f}`), lire(`../../assets/legal/${f}`), f);
    }
  });

  it('conversion en HTML, texte échappé', () => {
    const html = versHtml('# Titre\n## Partie\n- un <b>\n> encadré', 'Titre');
    assert.match(html, /<h1>Titre<\/h1>/);
    assert.match(html, /<li>un &lt;b&gt;<\/li>/);
    assert.match(html, /<aside>encadré<\/aside>/);
    assert.match(html, /Nous deux avec Dieu/);
  });
});
