import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import {
  formaterMontant, notificationPaiementAnnonce, notificationPaiementRecu, seancesACrediter, vientDEtreRecu,
} from '../paiements.js';

const achat = { type: 'forfait', nom: 'Marie', accompagnementId: 'a1', nbSeances: 5, montant: 250, forfaitNom: '5 séances' };

describe('paiements', () => {
  it('confirmation détectée une seule fois', () => {
    assert.equal(vientDEtreRecu({ statut: 'en_attente' }, { statut: 'recu' }), true);
    assert.equal(vientDEtreRecu({ statut: 'recu' }, { statut: 'recu' }), false);
    assert.equal(vientDEtreRecu({ statut: 'en_attente' }, { statut: 'annule' }), false);
  });

  it('séances à créditer : forfait seulement, jamais deux fois', () => {
    assert.equal(seancesACrediter(achat), 5);
    assert.equal(seancesACrediter({ ...achat, seancesCreditees: true }), 0);
    assert.equal(seancesACrediter({ type: 'don', montant: 20 }), 0);
    assert.equal(seancesACrediter({ ...achat, nbSeances: -3 }), 0);
  });

  it('notifications traduites', () => {
    const recu = notificationPaiementRecu({ paiementId: 'p1', paiement: achat, langue: 'fr' });
    assert.equal(recu.notification.title, 'Paiement reçu');
    assert.equal(recu.notification.body, '5 séances ajoutées à votre accompagnement.');
    assert.deepEqual(recu.data, { paiementId: 'p1' });
    const don = notificationPaiementRecu({ paiementId: 'p2', paiement: { type: 'don' }, langue: 'pt' });
    assert.equal(don.notification.title, 'Obrigado pelo seu donativo!');
    const annonce = notificationPaiementAnnonce({ paiementId: 'p1', paiement: achat, langue: 'fr' });
    assert.equal(annonce.notification.title, 'Virement annoncé');
    assert.match(annonce.notification.body, /^Marie · 250,00\s€ · 5 séances$/);
    assert.match(formaterMontant(20, 'en'), /€20\.00/);
  });
});
