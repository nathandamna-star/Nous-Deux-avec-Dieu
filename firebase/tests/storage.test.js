import { readFileSync } from 'node:fs';
import { after, before, describe, it } from 'node:test';
import {
  assertFails, assertSucceeds, initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import { ref, uploadBytes } from 'firebase/storage';

let env;
const coach = () => env.authenticatedContext('coach1', { coach: true }).storage();
const marie = () => env.authenticatedContext('marie').storage();
const octets = new Uint8Array([1, 2, 3]);

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-ndad',
    storage: {
      rules: readFileSync(new URL('../storage.rules', import.meta.url), 'utf8'),
      host: '127.0.0.1',
      port: 9199,
    },
  });
});
after(async () => { await env.cleanup(); });

describe('photos de profil', () => {
  it('chacun envoie sa photo, pas celle d\'un autre, images seulement', async () => {
    await assertSucceeds(uploadBytes(ref(marie(), 'users/marie/profil.jpg'), octets, { contentType: 'image/jpeg' }));
    await assertFails(uploadBytes(ref(marie(), 'users/paul/profil.jpg'), octets, { contentType: 'image/jpeg' }));
    await assertFails(uploadBytes(ref(marie(), 'users/marie/profil.mp4'), octets, { contentType: 'video/mp4' }));
  });
});

describe('fichiers des contenus', () => {
  it('le coach envoie audio et vidéo', async () => {
    await assertSucceeds(uploadBytes(ref(coach(), 'contenus/c1/fr.m4a'), octets, { contentType: 'audio/mp4' }));
    await assertSucceeds(uploadBytes(ref(coach(), 'contenus/c1/fr.mp4'), octets, { contentType: 'video/mp4' }));
  });

  it('refusé : autre type de fichier, ou pas le coach', async () => {
    await assertFails(uploadBytes(ref(coach(), 'contenus/c1/x.pdf'), octets, { contentType: 'application/pdf' }));
    await assertFails(uploadBytes(ref(marie(), 'contenus/c1/fr.m4a'), octets, { contentType: 'audio/mp4' }));
    await assertFails(uploadBytes(ref(coach(), 'autre/fr.m4a'), octets, { contentType: 'audio/mp4' }));
  });
});
