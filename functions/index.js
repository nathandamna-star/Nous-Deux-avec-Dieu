// Fonctions serveur Nous deux avec Dieu.
// Elles s'exécutent avec les droits du SDK Admin, hors règles de sécurité :
// chaque fonction vérifie elle-même qui l'appelle.
import { initializeApp } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import { FieldValue, getFirestore } from 'firebase-admin/firestore';
import { setGlobalOptions } from 'firebase-functions/v2';
import { defineString } from 'firebase-functions/params';
import { HttpsError, onCall } from 'firebase-functions/v2/https';

initializeApp();

// Données en Europe (RGPD) et plafond de coût.
setGlobalOptions({ region: 'europe-west1', maxInstances: 10 });

const EMAIL_COACH = defineString('EMAIL_COACH', {
  description: 'Adresse e-mail du compte du coach dans l\'app',
});

const normaliser = (v) => (v ?? '').trim().toLowerCase();

/**
 * Le coach : le compte dont l'e-mail a été indiqué au déploiement reçoit le
 * custom claim `coach`. Une seule fois ; ensuite, plus personne d'autre.
 */
export const revendiquerCoach = onCall(async (requete) => {
  if (!requete.auth) {
    throw new HttpsError('unauthenticated', 'Connexion requise.');
  }
  const attendu = normaliser(EMAIL_COACH.value());
  if (!attendu || normaliser(requete.auth.token.email) !== attendu) {
    throw new HttpsError('permission-denied', 'Ce compte ne peut pas devenir coach.');
  }
  const uid = requete.auth.uid;
  const db = getFirestore();
  await db.runTransaction(async (t) => {
    const ref = db.doc('systeme/coach');
    const doc = await t.get(ref);
    if (doc.exists && doc.data().uid !== uid) {
      throw new HttpsError('failed-precondition', 'Le coach est déjà désigné.');
    }
    t.set(ref, { uid, designeLe: FieldValue.serverTimestamp() });
  });
  const user = await getAuth().getUser(uid);
  await getAuth().setCustomUserClaims(uid, { ...(user.customClaims ?? {}), coach: true });
  return { coach: true };
});
