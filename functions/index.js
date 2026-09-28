// Fonctions serveur Nous deux avec Dieu.
// Elles s'exécutent avec les droits du SDK Admin, hors règles de sécurité :
// chaque fonction vérifie elle-même qui l'appelle.
import { initializeApp } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import { getMessaging } from 'firebase-admin/messaging';
import { FieldValue, getFirestore } from 'firebase-admin/firestore';
import { setGlobalOptions } from 'firebase-functions/v2';
import { defineString } from 'firebase-functions/params';
import { HttpsError, onCall } from 'firebase-functions/v2/https';
import { onDocumentCreated, onDocumentWritten } from 'firebase-functions/v2/firestore';
import { onSchedule } from 'firebase-functions/v2/scheduler';
import { logger } from 'firebase-functions';
import {
  destinatairesMessage, jetonsInvalides, notificationExercice, notificationMessage,
} from './notifications.js';
import { changementRendezVous, notificationRendezVous, rappelsDus } from './rendezvous.js';

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

/**
 * Envoie une notification sur tous les téléphones de [uid], dans sa langue.
 * [construire] reçoit la langue et renvoie { notification, data }.
 */
async function envoyerNotification(uid, construire) {
  const refProfil = getFirestore().doc(`users/${uid}`);
  const profil = (await refProfil.get()).data() ?? {};
  const jetons = profil.jetonsNotif ?? [];
  if (jetons.length === 0) return;
  const { notification, data } = construire(profil.langue, profil.decalageMin);
  if (process.env.FUNCTIONS_EMULATOR === 'true') {
    logger.info('Émulateur : notification non envoyée', { uid, notification });
    return;
  }
  const resultat = await getMessaging().sendEachForMulticast({
    tokens: jetons,
    notification,
    data,
    apns: { payload: { aps: { sound: 'default' } } },
  });
  const invalides = jetonsInvalides(jetons, resultat.responses);
  if (invalides.length > 0) {
    await refProfil.update({ jetonsNotif: FieldValue.arrayRemove(...invalides) });
  }
}

/** Nouveau message : prévient le coach, ou les membres si le coach écrit. */
export const notifierMessage = onDocumentCreated(
  'accompagnements/{accompagnementId}/messages/{messageId}',
  async (evenement) => {
    const db = getFirestore();
    const { accompagnementId } = evenement.params;
    const accompagnement = (await db.doc(`accompagnements/${accompagnementId}`).get()).data();
    const message = evenement.data?.data();
    if (!accompagnement || !message) return;
    const coachUid = (await db.doc('systeme/coach').get()).data()?.uid;
    const destinataires = destinatairesMessage({ accompagnement, message, coachUid });
    await Promise.all(destinataires.map((uid) => envoyerNotification(uid, (langue) =>
      notificationMessage({
        accompagnementId, accompagnement, message, pourCoach: uid === coachUid, langue,
      }))));
  },
);

/** Nouvel exercice : prévient les membres de l'accompagnement. */
export const notifierExercice = onDocumentCreated(
  'accompagnements/{accompagnementId}/exercices/{exerciceId}',
  async (evenement) => {
    const { accompagnementId, exerciceId } = evenement.params;
    const accompagnement = (await getFirestore().doc(`accompagnements/${accompagnementId}`).get()).data();
    const exercice = evenement.data?.data();
    if (!accompagnement || !exercice) return;
    await Promise.all((accompagnement.membres ?? []).map((uid) => envoyerNotification(uid, (langue) =>
      notificationExercice({ exerciceId, exercice, langue }))));
  },
);

/** Rendez-vous créé, déplacé ou annulé par le coach : les membres sont prévenus. */
export const notifierRendezVous = onDocumentWritten(
  'accompagnements/{accompagnementId}/rendezVous/{rendezVousId}',
  async (evenement) => {
    const { accompagnementId, rendezVousId } = evenement.params;
    const avant = evenement.data?.before?.data();
    const apres = evenement.data?.after?.data();
    const type = changementRendezVous(avant, apres);
    if (!type) return;
    const accompagnement = (await getFirestore().doc(`accompagnements/${accompagnementId}`).get()).data();
    if (!accompagnement) return;
    await Promise.all((accompagnement.membres ?? []).map((uid) => envoyerNotification(uid,
      (langue, decalageMin) => notificationRendezVous({
        type, accompagnementId, rendezVousId, rdv: apres, langue, decalageMin,
      }))));
  },
);

/**
 * Toutes les 15 minutes : rappels la veille et 1 heure avant chaque séance.
 * Cloud Scheduler : gratuit jusqu'à 3 tâches planifiées par compte.
 */
export const rappelsRendezVous = onSchedule('every 15 minutes', async () => {
  const db = getFirestore();
  const maintenant = new Date();
  const limite = new Date(maintenant.getTime() + 24 * 60 * 60 * 1000);
  const accompagnements = await db.collection('accompagnements').get();
  for (const acc of accompagnements.docs) {
    const rdvs = await acc.ref.collection('rendezVous')
      .where('debut', '>', maintenant)
      .where('debut', '<=', limite)
      .get();
    for (const doc of rdvs.docs) {
      const rdv = doc.data();
      const { envoyer, marquer } = rappelsDus(rdv, maintenant);
      if (Object.keys(marquer).length === 0) continue;
      // Marqué d'abord : jamais deux fois le même rappel.
      await doc.ref.update(marquer);
      for (const type of envoyer) {
        await Promise.all((acc.data().membres ?? []).map((uid) => envoyerNotification(uid,
          (langue, decalageMin) => notificationRendezVous({
            type, accompagnementId: acc.id, rendezVousId: doc.id, rdv, langue, decalageMin,
          }))));
      }
    }
  }
});
