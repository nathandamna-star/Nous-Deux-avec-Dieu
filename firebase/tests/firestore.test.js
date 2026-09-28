import { readFileSync } from 'node:fs';
import { after, afterEach, before, describe, it } from 'node:test';
import {
  assertFails, assertSucceeds, initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import { deleteDoc, doc, getDoc, serverTimestamp, setDoc, updateDoc } from 'firebase/firestore';

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
    await assertFails(getDoc(doc(marie(), 'accompagnements/x')));
    await assertFails(setDoc(doc(coach(), 'divers/x'), { a: 1 }));
  });
});
