// Fonctions serveur Nous deux avec Dieu.
// Elles s'exécutent avec les droits du SDK Admin, hors règles de sécurité :
// chaque fonction vérifie elle-même qui l'appelle.
import { initializeApp } from 'firebase-admin/app';
import { getAuth } from 'firebase-admin/auth';
import { getMessaging } from 'firebase-admin/messaging';
import { FieldValue, getFirestore } from 'firebase-admin/firestore';
import { setGlobalOptions } from 'firebase-functions/v2';
import { defineString } from 'firebase-functions/params';
import { HttpsError, onCall, onRequest } from 'firebase-functions/v2/https';
import {
  onDocumentCreated, onDocumentUpdated, onDocumentWritten,
} from 'firebase-functions/v2/firestore';
import { onSchedule } from 'firebase-functions/v2/scheduler';
import { logger } from 'firebase-functions';
import { readFileSync } from 'node:fs';
import { getStorage } from 'firebase-admin/storage';
import {
  ANONYME, commandeEnCours, departMembre, profilExporte, versJson,
} from './compte.js';
import { versHtml } from './legal.js';
import {
  destinatairesMessage, jetonsInvalides, notificationExercice, notificationMessage,
} from './notifications.js';
import {
  notificationPaiementAnnonce, notificationPaiementRecu, seancesACrediter, vientDEtreRecu,
} from './paiements.js';
import {
  changementCommande, notificationNouvelleCommande, notificationSuiviCommande,
} from './livres.js';
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

/** Virement annoncé (forfait ou don) : le coach est prévenu. */
export const notifierPaiementAnnonce = onDocumentCreated('paiements/{paiementId}', async (evenement) => {
  const paiement = evenement.data?.data();
  if (!paiement) return;
  const coachUid = (await getFirestore().doc('systeme/coach').get()).data()?.uid;
  if (!coachUid) return;
  await envoyerNotification(coachUid, (langue) => notificationPaiementAnnonce({
    paiementId: evenement.params.paiementId, paiement, langue,
  }));
});

/**
 * Le coach confirme « Paiement reçu » : les séances du forfait sont créditées
 * (une seule fois) et la personne est remerciée.
 */
export const paiementRecu = onDocumentUpdated('paiements/{paiementId}', async (evenement) => {
  const avant = evenement.data?.before?.data();
  const apres = evenement.data?.after?.data();
  if (!vientDEtreRecu(avant, apres)) return;
  const db = getFirestore();
  const ref = evenement.data.after.ref;
  let destinataires = [apres.uid];
  await db.runTransaction(async (t) => {
    const paiement = (await t.get(ref)).data();
    const n = seancesACrediter(paiement);
    if (n === 0) return;
    const refAcc = db.doc(`accompagnements/${paiement.accompagnementId}`);
    const acc = await t.get(refAcc);
    if (!acc.exists) return;
    destinataires = acc.data().membres ?? destinataires;
    t.update(refAcc, { seancesRestantes: FieldValue.increment(n), updatedAt: FieldValue.serverTimestamp() });
    t.update(ref, { seancesCreditees: true });
  });
  const { paiementId } = evenement.params;
  await Promise.all([...new Set(destinataires)].map((uid) => envoyerNotification(uid,
    (langue) => notificationPaiementRecu({ paiementId, paiement: apres, langue }))));
});

/** Commande d'un livre papier : le coach est prévenu. */
export const notifierCommandeLivre = onDocumentCreated('commandesLivres/{commandeId}', async (evenement) => {
  const commande = evenement.data?.data();
  if (!commande) return;
  const coachUid = (await getFirestore().doc('systeme/coach').get()).data()?.uid;
  if (!coachUid) return;
  await envoyerNotification(coachUid, (langue) => notificationNouvelleCommande({
    commandeId: evenement.params.commandeId, commande, langue,
  }));
});

/** Commande payée ou envoyée : le client est prévenu. */
export const suiviCommandeLivre = onDocumentUpdated('commandesLivres/{commandeId}', async (evenement) => {
  const avant = evenement.data?.before?.data();
  const apres = evenement.data?.after?.data();
  const statut = changementCommande(avant, apres);
  if (!statut) return;
  await envoyerNotification(apres.uid, (langue) => notificationSuiviCommande({
    commandeId: evenement.params.commandeId, commande: apres, statut, langue,
  }));
});

// ----- Compte : export, suppression, pages légales -----

const donnees = (s) => s.docs.map((d) => ({ id: d.id, ...versJson(d.data()) }));

/**
 * Export des données personnelles (RGPD, droit d'accès et de portabilité) :
 * profil, progression, accompagnement (sans les notes privées du coach),
 * messages, exercices et réponses, rendez-vous, paiements, commandes de livres.
 */
export const exporterMesDonnees = onCall(async (requete) => {
  if (!requete.auth) throw new HttpsError('unauthenticated', 'Connexion requise.');
  const uid = requete.auth.uid;
  const db = getFirestore();
  const refProfil = db.doc(`users/${uid}`);
  const [profil, progression, accompagnements, paiements, commandes] = await Promise.all([
    refProfil.get(),
    refProfil.collection('progression').get(),
    db.collection('accompagnements').where('membres', 'array-contains', uid).get(),
    db.collection('paiements').where('uid', '==', uid).get(),
    db.collection('commandesLivres').where('uid', '==', uid).get(),
  ]);
  const detailsAccompagnements = [];
  for (const acc of accompagnements.docs) {
    const [messages, exercices, rendezVous] = await Promise.all([
      acc.ref.collection('messages').get(),
      acc.ref.collection('exercices').get(),
      acc.ref.collection('rendezVous').get(),
    ]);
    const reponses = [];
    for (const ex of exercices.docs) {
      for (const cle of [uid, 'couple']) {
        const r = await ex.ref.collection('reponses').doc(cle).get();
        if (r.exists) reponses.push({ exercice: ex.id, cle, ...versJson(r.data()) });
      }
    }
    const { nonLusCoach: _n, ...acces } = acc.data();
    detailsAccompagnements.push({
      id: acc.id,
      ...versJson(acces),
      messages: donnees(messages),
      exercices: donnees(exercices),
      reponses,
      rendezVous: donnees(rendezVous),
    });
  }
  return {
    exporteLe: new Date().toISOString(),
    compte: { uid, email: requete.auth.token.email ?? null },
    profil: profilExporte(profil.data()),
    progression: donnees(progression),
    accompagnements: detailsAccompagnements,
    paiements: donnees(paiements),
    commandesLivres: donnees(commandes),
  };
});

async function supprimerRequete(requete) {
  const db = getFirestore();
  for (;;) {
    const s = await requete.limit(400).get();
    if (s.empty) return;
    const lot = db.batch();
    s.docs.forEach((d) => lot.delete(d.ref));
    await lot.commit();
  }
}

async function supprimerFichiers(prefixe) {
  try {
    await getStorage().bucket().deleteFiles({ prefix: prefixe });
  } catch (e) {
    logger.warn('Suppression de fichiers impossible', { prefixe, message: e.message });
  }
}

/**
 * Suppression du compte (RGPD, exigence de l'App Store) :
 * - refusée pour le coach, et tant qu'un livre payé n'est pas encore envoyé ;
 * - accompagnement : supprimé si la personne est seule, sinon elle en est
 *   retirée (le conjoint le garde) avec ses messages et ses réponses ;
 * - paiements et commandes : conservés, anonymisés (obligations comptables) ;
 * - profil, progression, photo, puis compte de connexion supprimés.
 */
export const supprimerMonCompte = onCall({ timeoutSeconds: 120 }, async (requete) => {
  if (!requete.auth) throw new HttpsError('unauthenticated', 'Connexion requise.');
  if (requete.auth.token.coach === true) {
    throw new HttpsError('failed-precondition', 'compte-coach', { code: 'compte-coach' });
  }
  const uid = requete.auth.uid;
  const db = getFirestore();

  const [commandes, paiements, accompagnements] = await Promise.all([
    db.collection('commandesLivres').where('uid', '==', uid).get(),
    db.collection('paiements').where('uid', '==', uid).get(),
    db.collection('accompagnements').where('membres', 'array-contains', uid).get(),
  ]);
  if (commandeEnCours(commandes.docs.map((d) => d.data()))) {
    throw new HttpsError('failed-precondition', 'commande-en-cours', { code: 'commande-en-cours' });
  }

  const lot = db.batch();
  for (const d of commandes.docs) {
    lot.update(d.ref, {
      uid: ANONYME,
      nom: '',
      adresse: FieldValue.delete(),
      ...(d.data().statut === 'en_attente' ? { statut: 'annulee' } : {}),
    });
  }
  for (const d of paiements.docs) {
    lot.update(d.ref, {
      uid: ANONYME,
      nom: '',
      ...(d.data().statut === 'en_attente' ? { statut: 'annule' } : {}),
    });
  }
  await lot.commit();

  for (const acc of accompagnements.docs) {
    const depart = departMembre(acc.data(), uid);
    if (depart.supprimer) {
      await supprimerFichiers(`messages/${acc.id}/`);
      const code = acc.data().codeInvitation;
      if (code) await db.doc(`invitations/${code}`).delete();
      await db.recursiveDelete(acc.ref);
      continue;
    }
    await supprimerRequete(acc.ref.collection('messages').where('auteur', '==', uid));
    const exercices = await acc.ref.collection('exercices').get();
    for (const ex of exercices.docs) {
      await ex.ref.collection('reponses').doc(uid).delete();
    }
    await acc.ref.update(depart.maj);
  }

  await supprimerFichiers(`users/${uid}/`);
  await db.recursiveDelete(db.doc(`users/${uid}`));
  await getAuth().deleteUser(uid);
  logger.info('Compte supprimé', { uid });
  return { supprime: true };
});

const PAGES = {
  cgu: ['cgu_fr.md', 'Conditions d\'utilisation'],
  confidentialite: ['confidentialite_fr.md', 'Politique de confidentialité'],
  support: ['support_fr.md', 'Aide et contact'],
};

/**
 * Pages légales publiques (adresses demandées par l'App Store et Google Play) :
 * …/legal?page=confidentialite|cgu|support
 */
export const legal = onRequest((requete, reponse) => {
  const [fichier, titre] = PAGES[requete.query.page] ?? PAGES.confidentialite;
  const texte = readFileSync(new URL(`./legal/${fichier}`, import.meta.url), 'utf8');
  reponse.set('Cache-Control', 'public, max-age=3600')
    .set('Content-Type', 'text/html; charset=utf-8')
    .send(versHtml(texte, titre));
});
