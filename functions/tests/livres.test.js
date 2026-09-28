import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import { changementCommande, notificationNouvelleCommande, notificationSuiviCommande } from '../livres.js';

const commande = { nom: 'Marie', quantite: 2, livreTitre: 'Aimer selon Dieu', montant: 44.3 };

describe('commandes de livres', () => {
  it('nouvelle commande pour le coach', () => {
    const n = notificationNouvelleCommande({ commandeId: 'c1', commande, langue: 'fr' });
    assert.equal(n.notification.title, 'Commande de livre');
    assert.match(n.notification.body, /^Marie · 2 × Aimer selon Dieu · 44,30\s€$/);
    assert.deepEqual(n.data, { commandeLivreId: 'c1' });
  });

  it('suivi : payée puis envoyée, avec numéro de suivi', () => {
    assert.equal(changementCommande({ statut: 'en_attente' }, { statut: 'payee' }), 'payee');
    assert.equal(changementCommande({ statut: 'payee' }, { statut: 'envoyee' }), 'envoyee');
    assert.equal(changementCommande({ statut: 'payee' }, { statut: 'payee' }), null);
    assert.equal(changementCommande({ statut: 'en_attente' }, { statut: 'annulee' }), null);
    const n = notificationSuiviCommande({
      commandeId: 'c1', commande: { ...commande, numeroSuivi: 'BPOST1' }, statut: 'envoyee', langue: 'nl',
    });
    assert.equal(n.notification.title, 'Je boek is onderweg!');
    assert.equal(n.notification.body, 'Aimer selon Dieu · Tracking : BPOST1');
  });
});
