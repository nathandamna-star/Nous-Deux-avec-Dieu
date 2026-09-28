// Test avec les émulateurs (lancé par `npm test`, sur GitHub Actions).
import assert from 'node:assert/strict';
import { after, describe, it } from 'node:test';
import { deleteApp, initializeApp } from 'firebase-admin/app';
import { getFirestore } from 'firebase-admin/firestore';

const app = initializeApp({ projectId: 'demo-ndad' }, 'test-paiements');
const db = getFirestore(app);
after(() => deleteApp(app));

async function attendre(condition, delai = 20000) {
  const fin = Date.now() + delai;
  while (Date.now() < fin) {
    if (await condition()) return true;
    await new Promise((r) => setTimeout(r, 300));
  }
  return false;
}

const seances = async () => (await db.doc('accompagnements/acc-p').get()).data().seancesRestantes;

describe('paiement reçu', () => {
  it('crédite les séances du forfait une seule fois', async () => {
    await db.doc('accompagnements/acc-p').set({ nom: 'Paul & Marie', membres: ['marie'], seancesRestantes: 1 });
    const ref = db.doc('paiements/100000000034');
    await ref.set({
      type: 'forfait', uid: 'marie', nom: 'Marie', accompagnementId: 'acc-p', forfaitId: 'f5',
      nbSeances: 5, montant: 250, devise: 'EUR', statut: 'en_attente',
    });
    await ref.update({ statut: 'recu' });
    assert.ok(await attendre(async () => (await ref.get()).data().seancesCreditees === true));
    assert.equal(await seances(), 6);
    // Une nouvelle modification ne recrédite pas.
    await ref.update({ confirmeLe: new Date() });
    await new Promise((r) => setTimeout(r, 1500));
    assert.equal(await seances(), 6);
  });
});
