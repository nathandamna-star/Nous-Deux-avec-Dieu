import assert from 'node:assert/strict';
import { after, beforeEach, describe, it } from 'node:test';
import { deleteApp, initializeApp } from 'firebase/app';
import {
  connectAuthEmulator, createUserWithEmailAndPassword, getAuth, signOut,
} from 'firebase/auth';
import { connectFunctionsEmulator, getFunctions, httpsCallable } from 'firebase/functions';

const PROJET = 'demo-ndad';
const app = initializeApp({ projectId: PROJET, apiKey: 'demo-cle' });
const auth = getAuth(app);
connectAuthEmulator(auth, 'http://127.0.0.1:9099', { disableWarnings: true });
const fonctions = getFunctions(app, 'europe-west1');
connectFunctionsEmulator(fonctions, '127.0.0.1', 5001);
const revendiquer = httpsCallable(fonctions, 'revendiquerCoach');

async function vider() {
  await fetch(`http://127.0.0.1:9099/emulator/v1/projects/${PROJET}/accounts`, { method: 'DELETE' });
  await fetch(`http://127.0.0.1:8080/emulator/v1/projects/${PROJET}/databases/(default)/documents`, { method: 'DELETE' });
}

async function compte(email) {
  return (await createUserWithEmailAndPassword(auth, email, 'motdepasse1')).user;
}

const estCoach = async (user) => (await user.getIdTokenResult(true)).claims.coach === true;
const refuse = (p, code) => assert.rejects(p, (e) => e.code === `functions/${code}`);

after(async () => { await signOut(auth); await deleteApp(app); });

describe('compte coach', () => {
  beforeEach(vider);

  it('le compte configuré devient coach (majuscules tolérées)', async () => {
    const user = await compte('Coach@Exemple.com');
    assert.equal(await estCoach(user), false);
    await revendiquer();
    assert.equal(await estCoach(user), true);
  });

  it('un autre compte est refusé', async () => {
    const user = await compte('intrus@exemple.com');
    await refuse(revendiquer(), 'permission-denied');
    assert.equal(await estCoach(user), false);
  });

  it('sans connexion : refusé', async () => {
    await signOut(auth);
    await refuse(revendiquer(), 'unauthenticated');
  });
});
