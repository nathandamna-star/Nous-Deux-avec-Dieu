import { readFileSync } from 'node:fs';
import { after, afterEach, before, describe, it } from 'node:test';
import {
  assertFails, assertSucceeds, initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import {
  addDoc, arrayUnion, collection, deleteDoc, doc, getDoc, getDocs, query, serverTimestamp, setDoc,
  updateDoc, where, writeBatch,
} from 'firebase/firestore';

let env;
const marie = () => env.authenticatedContext('marie').firestore();
const paul = () => env.authenticatedContext('paul').firestore();
const coach = () => env.authenticatedContext('coach1', { coach: true }).firestore();
const visiteur = () => env.unauthenticatedContext().firestore();

const profil = (extra = {}) => ({
  nom: 'Marie', email: 'marie@x.com', langue: 'fr', parcours: 'couple',
  consentementLe: serverTimestamp(), createdAt: serverTimestamp(), ...extra,
});

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-ndad',
    firestore: {
      rules: readFileSync(new URL('../firestore.rules', import.meta.url), 'utf8'),
      host: '127.0.0.1',
      port: 8080,
    },
  });
});
afterEach(async () => { await env.clearFirestore(); });
after(async () => { await env.cleanup(); });

describe('profils', () => {
  it('chacun crée son profil avec un consentement daté par le serveur', async () => {
    await assertSucceeds(setDoc(doc(marie(), 'users/marie'), profil()));
  });

  it('création refusée : sans consentement, date inventée, rôle ajouté, pour un autre', async () => {
    const sansConsentement = profil();
    delete sansConsentement.consentementLe;
    await assertFails(setDoc(doc(marie(), 'users/marie'), sansConsentement));
    await assertFails(setDoc(doc(marie(), 'users/marie'), profil({ consentementLe: new Date(2020, 0, 1) })));
    await assertFails(setDoc(doc(marie(), 'users/marie'), profil({ coach: true })));
    await assertFails(setDoc(doc(paul(), 'users/marie'), profil()));
    await assertFails(setDoc(doc(marie(), 'users/marie'), profil({ langue: 'de' })));
  });

  it('lecture : soi-même et le coach, personne d\'autre', async () => {
    await env.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), 'users/marie'), { nom: 'Marie', langue: 'fr', parcours: 'couple' });
    });
    await assertSucceeds(getDoc(doc(marie(), 'users/marie')));
    await assertSucceeds(getDoc(doc(coach(), 'users/marie')));
    await assertFails(getDoc(doc(paul(), 'users/marie')));
    await assertFails(getDoc(doc(visiteur(), 'users/marie')));
  });

  it('modification limitée, suppression par soi-même', async () => {
    await env.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), 'users/marie'), {
        nom: 'Marie', langue: 'fr', parcours: 'couple', consentementLe: new Date(),
      });
    });
    await assertSucceeds(updateDoc(doc(marie(), 'users/marie'), { langue: 'nl' }));
    await assertFails(updateDoc(doc(marie(), 'users/marie'), { consentementLe: new Date(2020, 0, 1) }));
    await assertFails(updateDoc(doc(paul(), 'users/marie'), { nom: 'Pirate' }));
    await assertFails(deleteDoc(doc(paul(), 'users/marie')));
    await assertSucceeds(deleteDoc(doc(marie(), 'users/marie')));
  });

  it('toute autre collection est fermée', async () => {
    await assertFails(setDoc(doc(coach(), 'divers/x'), { a: 1 }));
  });
});

const demandeCouple = (db, uid = 'marie', code = 'ABC234') => {
  const b = writeBatch(db);
  b.set(doc(db, `invitations/${code}`), { accompagnementId: 'a1', createdAt: serverTimestamp() });
  b.set(doc(db, 'accompagnements/a1'), {
    type: 'couple', nom: 'Paul & Marie', membres: [uid], noms: { [uid]: 'Marie' },
    codeInvitation: code, statut: 'demande', message: 'Bonjour',
    createdAt: serverTimestamp(), updatedAt: serverTimestamp(),
  });
  return b.commit();
};

const rejoindre = (db, uid, code) => updateDoc(doc(db, 'accompagnements/a1'), {
  membres: arrayUnion(uid), [`noms.${uid}`]: 'Paul', codeUtilise: code, updatedAt: serverTimestamp(),
});

describe('accompagnements', () => {
  it('une demande de couple avec son code d\'invitation', async () => {
    await assertSucceeds(demandeCouple(marie()));
  });

  it('demande individuelle ; refus si statut, séances ou membres forcés', async () => {
    const base = {
      type: 'individuel', nom: 'Marie', membres: ['marie'], noms: { marie: 'Marie' },
      statut: 'demande', createdAt: serverTimestamp(), updatedAt: serverTimestamp(),
    };
    await assertSucceeds(setDoc(doc(marie(), 'accompagnements/i1'), base));
    await assertFails(setDoc(doc(marie(), 'accompagnements/i2'), { ...base, statut: 'actif' }));
    await assertFails(setDoc(doc(marie(), 'accompagnements/i3'), { ...base, seancesRestantes: 10 }));
    await assertFails(setDoc(doc(marie(), 'accompagnements/i4'), { ...base, membres: ['marie', 'paul'] }));
    // Couple sans document d'invitation : refusé.
    await assertFails(setDoc(doc(marie(), 'accompagnements/i5'), {
      ...base, type: 'couple', codeInvitation: 'ZZZ999',
    }));
  });

  it('le conjoint rejoint avec le bon code, une seule fois', async () => {
    await demandeCouple(marie());
    const lucie = () => env.authenticatedContext('lucie').firestore();
    await assertSucceeds(getDoc(doc(paul(), 'invitations/ABC234')));
    await assertFails(getDocs(collection(paul(), 'invitations')));
    await assertFails(getDoc(doc(paul(), 'accompagnements/a1')));
    await assertFails(rejoindre(paul(), 'paul', 'MAUVAIS'));
    await assertSucceeds(rejoindre(paul(), 'paul', 'ABC234'));
    await assertSucceeds(getDoc(doc(paul(), 'accompagnements/a1')));
    await assertFails(rejoindre(lucie(), 'lucie', 'ABC234'));
  });

  it('un membre ne change ni le statut ni les séances', async () => {
    await demandeCouple(marie());
    await assertFails(updateDoc(doc(marie(), 'accompagnements/a1'), { statut: 'actif' }));
    await assertFails(updateDoc(doc(marie(), 'accompagnements/a1'), { seancesRestantes: 5 }));
  });

  it('chacun ne liste que son accompagnement ; le coach voit tout', async () => {
    await demandeCouple(marie());
    await assertSucceeds(getDocs(query(collection(marie(), 'accompagnements'), where('membres', 'array-contains', 'marie'))));
    await assertFails(getDocs(collection(marie(), 'accompagnements')));
    await assertSucceeds(getDocs(collection(coach(), 'accompagnements')));
  });

  it('le coach accepte, crédite des séances, prend des notes privées', async () => {
    await demandeCouple(marie());
    const ref = doc(coach(), 'accompagnements/a1');
    await assertSucceeds(updateDoc(ref, { statut: 'actif', seancesRestantes: 5, updatedAt: serverTimestamp() }));
    await assertFails(updateDoc(ref, { statut: 'inconnu' }));
    await assertFails(updateDoc(ref, { seancesRestantes: -1 }));
    await assertFails(updateDoc(ref, { membres: ['coach1'] }));
    await assertSucceeds(addDoc(collection(coach(), 'accompagnements/a1/notes'), {
      texte: 'Première séance : communication.', createdAt: serverTimestamp(),
    }));
    await assertSucceeds(getDocs(collection(coach(), 'accompagnements/a1/notes')));
    await assertFails(getDocs(collection(marie(), 'accompagnements/a1/notes')));
    await assertFails(addDoc(collection(marie(), 'accompagnements/a1/notes'), { texte: 'x' }));
  });
});
