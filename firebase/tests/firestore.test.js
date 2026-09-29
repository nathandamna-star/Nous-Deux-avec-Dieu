import { readFileSync } from 'node:fs';
import { after, afterEach, before, describe, it } from 'node:test';
import {
  assertFails, assertSucceeds, initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import {
  addDoc, arrayUnion, collection, collectionGroup, deleteDoc, doc, getDoc, getDocs, query, serverTimestamp, setDoc,
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
    await assertSucceeds(updateDoc(doc(marie(), 'users/marie'), { photoUrl: 'https://stockage/marie.jpg' }));
    await assertSucceeds(updateDoc(doc(marie(), 'users/marie'), { photoUrl: null }));
    await assertFails(updateDoc(doc(marie(), 'users/marie'), { photoUrl: 'javascript:alert(1)' }));
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

const contenu = (extra = {}) => ({
  type: 'meditation', theme: 'priere', titre: { fr: 'Prier à deux', nl: 'Samen bidden' },
  texte: { fr: 'Texte' }, reference: 'Matthieu 18:20', visibilite: 'public', publie: true, ordre: 1,
  createdAt: serverTimestamp(), updatedAt: serverTimestamp(), ...extra,
});

describe('contenus', () => {
  const avecContenus = () => env.withSecurityRulesDisabled(async (ctx) => {
    const db = ctx.firestore();
    await setDoc(doc(db, 'contenus/public'), contenu());
    await setDoc(doc(db, 'contenus/membres'), contenu({ visibilite: 'connectes' }));
    await setDoc(doc(db, 'contenus/brouillon'), contenu({ publie: false }));
  });

  it('sans compte : seulement les contenus publics publiés', async () => {
    await avecContenus();
    await assertSucceeds(getDoc(doc(visiteur(), 'contenus/public')));
    await assertFails(getDoc(doc(visiteur(), 'contenus/membres')));
    await assertFails(getDoc(doc(visiteur(), 'contenus/brouillon')));
    await assertSucceeds(getDocs(query(collection(visiteur(), 'contenus'),
      where('publie', '==', true), where('visibilite', '==', 'public'))));
    await assertFails(getDocs(query(collection(visiteur(), 'contenus'), where('publie', '==', true))));
  });

  it('connecté : tous les publiés, pas les brouillons', async () => {
    await avecContenus();
    await assertSucceeds(getDoc(doc(marie(), 'contenus/membres')));
    await assertFails(getDoc(doc(marie(), 'contenus/brouillon')));
    await assertSucceeds(getDocs(query(collection(marie(), 'contenus'), where('publie', '==', true))));
    await assertFails(getDocs(collection(marie(), 'contenus')));
  });

  it('le coach écrit, lit ses brouillons, supprime ; personne d\'autre', async () => {
    await assertSucceeds(setDoc(doc(coach(), 'contenus/c1'), contenu({ publie: false })));
    await assertSucceeds(getDoc(doc(coach(), 'contenus/c1')));
    await assertFails(setDoc(doc(marie(), 'contenus/c2'), contenu()));
    await assertFails(setDoc(doc(coach(), 'contenus/c3'), contenu({ titre: { en: 'Only English' } })));
    await assertFails(setDoc(doc(coach(), 'contenus/c4'), contenu({ titre: { fr: 'x', de: 'y' } })));
    await assertFails(setDoc(doc(coach(), 'contenus/c5'), contenu({ type: 'podcast' })));
    await assertSucceeds(setDoc(doc(coach(), 'contenus/c6'), contenu({
      type: 'audio', medias: { fr: 'https://x/fr.m4a', en: 'https://x/en.m4a' },
    })));
    await assertFails(setDoc(doc(coach(), 'contenus/c7'), contenu({ type: 'audio', medias: { de: 'x' } })));
    await assertSucceeds(deleteDoc(doc(coach(), 'contenus/c1')));
  });
});

describe('exercices', () => {
  const exercice = (mode) => ({
    titre: 'Trois qualités', consignes: 'Écrivez trois qualités de votre conjoint.',
    mode, repondu: [], statut: 'a_faire', createdAt: serverTimestamp(),
  });
  const couple = async () => env.withSecurityRulesDisabled(async (ctx) => {
    await setDoc(doc(ctx.firestore(), 'accompagnements/a1'), {
      type: 'couple', nom: 'Paul & Marie', membres: ['marie', 'paul'], statut: 'actif',
    });
  });
  const reponse = (db, cle, uid) => setDoc(doc(db, `accompagnements/a1/exercices/e1/reponses/${cle}`), {
    texte: 'Doux, fidèle, drôle.', auteur: uid, updatedAt: serverTimestamp(),
  });

  it('seul le coach envoie et supprime un exercice ; les membres le lisent', async () => {
    await couple();
    await assertSucceeds(setDoc(doc(coach(), 'accompagnements/a1/exercices/e1'), exercice('seul')));
    await assertFails(setDoc(doc(marie(), 'accompagnements/a1/exercices/e2'), exercice('seul')));
    await assertSucceeds(getDoc(doc(marie(), 'accompagnements/a1/exercices/e1')));
    const lucie = env.authenticatedContext('lucie').firestore();
    await assertFails(getDoc(doc(lucie, 'accompagnements/a1/exercices/e1')));
    await assertFails(deleteDoc(doc(marie(), 'accompagnements/a1/exercices/e1')));
  });

  it('chacun de son côté : réponse privée (soi et le coach)', async () => {
    await couple();
    await setDoc(doc(coach(), 'accompagnements/a1/exercices/e1'), exercice('seul'));
    await assertSucceeds(reponse(marie(), 'marie', 'marie'));
    await assertFails(reponse(marie(), 'paul', 'marie'));
    await assertFails(reponse(marie(), 'couple', 'marie'));
    await assertSucceeds(getDoc(doc(marie(), 'accompagnements/a1/exercices/e1/reponses/marie')));
    await assertFails(getDoc(doc(paul(), 'accompagnements/a1/exercices/e1/reponses/marie')));
    await assertSucceeds(getDoc(doc(coach(), 'accompagnements/a1/exercices/e1/reponses/marie')));
    // Marquer sa réponse, pas celle de l'autre.
    await assertSucceeds(updateDoc(doc(marie(), 'accompagnements/a1/exercices/e1'), { repondu: ['marie'] }));
    await assertFails(updateDoc(doc(marie(), 'accompagnements/a1/exercices/e1'), { repondu: ['marie', 'paul'] }));
    await assertFails(updateDoc(doc(marie(), 'accompagnements/a1/exercices/e1'), { titre: 'Autre' }));
  });

  it('à deux : une réponse commune lisible par les deux', async () => {
    await couple();
    await setDoc(doc(coach(), 'accompagnements/a1/exercices/e1'), exercice('a_deux'));
    await assertSucceeds(reponse(paul(), 'couple', 'paul'));
    await assertFails(reponse(paul(), 'paul', 'paul'));
    await assertSucceeds(getDoc(doc(marie(), 'accompagnements/a1/exercices/e1/reponses/couple')));
    await assertFails(reponse(paul(), 'couple', 'marie'));
  });
});

describe('parcours', () => {
  const parcours = (extra = {}) => ({
    titre: { fr: 'Mieux communiquer' }, description: { fr: '30 jours' }, etapes: ['c1', 'c2'],
    visibilite: 'public', publie: true, ordre: 0, createdAt: serverTimestamp(), ...extra,
  });

  it('le coach crée un parcours ; tout le monde lit les publics publiés', async () => {
    await assertSucceeds(setDoc(doc(coach(), 'parcours/p1'), parcours()));
    await assertSucceeds(setDoc(doc(coach(), 'parcours/p2'), parcours({ publie: false })));
    await assertFails(setDoc(doc(marie(), 'parcours/p3'), parcours()));
    await assertFails(setDoc(doc(coach(), 'parcours/p4'), parcours({ titre: { en: 'x' } })));
    await assertSucceeds(getDoc(doc(visiteur(), 'parcours/p1')));
    await assertFails(getDoc(doc(marie(), 'parcours/p2')));
  });

  it('progression : chacun la sienne, le coach la lit', async () => {
    const ref = (db, uid) => doc(db, `users/${uid}/progression/p1`);
    await assertSucceeds(setDoc(ref(marie(), 'marie'), { faits: ['c1'], updatedAt: serverTimestamp() }));
    await assertFails(setDoc(ref(paul(), 'marie'), { faits: ['c1'] }));
    await assertFails(getDoc(ref(paul(), 'marie')));
    await assertSucceeds(getDoc(ref(coach(), 'marie')));
    await assertFails(setDoc(ref(marie(), 'marie'), { faits: ['c1'], note: 'x' }));
  });
});

describe('messagerie', () => {
  const couple = () => env.withSecurityRulesDisabled(async (ctx) => {
    await setDoc(doc(ctx.firestore(), 'accompagnements/a1'), {
      type: 'couple', nom: 'Paul & Marie', membres: ['marie', 'paul'], statut: 'actif',
      nonLusCoach: 0, nonLus: { marie: 2, paul: 3 },
    });
  });
  const message = (auteur, extra = {}) => ({ auteur, texte: 'Bonjour', createdAt: serverTimestamp(), ...extra });

  it('membres et coach écrivent en leur nom ; les autres non', async () => {
    await couple();
    await assertSucceeds(setDoc(doc(marie(), 'accompagnements/a1/messages/m1'), message('marie')));
    await assertSucceeds(setDoc(doc(coach(), 'accompagnements/a1/messages/m2'), message('coach1')));
    await assertFails(setDoc(doc(marie(), 'accompagnements/a1/messages/m3'), message('paul')));
    const lucie = env.authenticatedContext('lucie').firestore();
    await assertFails(setDoc(doc(lucie, 'accompagnements/a1/messages/m4'), message('lucie')));
    await assertFails(getDocs(collection(lucie, 'accompagnements/a1/messages')));
    await assertSucceeds(getDocs(collection(paul(), 'accompagnements/a1/messages')));
    await assertFails(setDoc(doc(marie(), 'accompagnements/a1/messages/m5'), message('marie', { texte: '' })));
    await assertSucceeds(setDoc(doc(marie(), 'accompagnements/a1/messages/m6'),
      message('marie', { texte: '', audioUrl: 'https://x/v.m4a' })));
  });

  it('non-lus : chacun remet les siens à zéro, pas ceux du conjoint', async () => {
    await couple();
    const ref = (db) => doc(db, 'accompagnements/a1');
    await assertSucceeds(updateDoc(ref(marie()), { 'nonLus.marie': 0 }));
    await assertFails(updateDoc(ref(marie()), { 'nonLus.paul': 0 }));
    await assertSucceeds(updateDoc(ref(marie()), { nonLusCoach: 1, dernierMessage: 'Bonjour', dernierMessageLe: serverTimestamp() }));
    await assertFails(updateDoc(ref(marie()), { statut: 'termine' }));
    await assertSucceeds(updateDoc(ref(coach()), { 'nonLus.marie': 1, 'nonLus.paul': 4, nonLusCoach: 0 }));
  });

  it('jetons de notification dans son profil', async () => {
    await env.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), 'users/marie'), { nom: 'Marie', langue: 'fr', parcours: 'couple' });
    });
    await assertSucceeds(updateDoc(doc(marie(), 'users/marie'), { jetonsNotif: ['jeton1'], decalageMin: 120 }));
    await assertFails(updateDoc(doc(marie(), 'users/marie'), { decalageMin: 5000 }));
    await assertFails(updateDoc(doc(paul(), 'users/marie'), { jetonsNotif: ['pirate'] }));
  });
});

describe('rendez-vous', () => {
  const couple = () => env.withSecurityRulesDisabled(async (ctx) => {
    await setDoc(doc(ctx.firestore(), 'accompagnements/a1'), {
      type: 'couple', nom: 'Paul & Marie', membres: ['marie', 'paul'], statut: 'actif',
    });
  });
  const rdv = (extra = {}) => ({
    nom: 'Paul & Marie', debut: new Date(2030, 0, 10, 19), dureeMin: 60,
    lienZoom: 'https://zoom.us/j/123', statut: 'prevu', rappelVeille: false, rappelHeure: false,
    createdAt: serverTimestamp(), updatedAt: serverTimestamp(), ...extra,
  });

  it('seul le coach planifie ; les membres lisent', async () => {
    await couple();
    await assertSucceeds(setDoc(doc(coach(), 'accompagnements/a1/rendezVous/r1'), rdv()));
    await assertFails(setDoc(doc(marie(), 'accompagnements/a1/rendezVous/r2'), rdv()));
    await assertFails(updateDoc(doc(marie(), 'accompagnements/a1/rendezVous/r1'), { statut: 'annule' }));
    await assertSucceeds(getDocs(collection(paul(), 'accompagnements/a1/rendezVous')));
    const lucie = env.authenticatedContext('lucie').firestore();
    await assertFails(getDocs(collection(lucie, 'accompagnements/a1/rendezVous')));
    await assertSucceeds(updateDoc(doc(coach(), 'accompagnements/a1/rendezVous/r1'), { statut: 'annule' }));
  });

  it('lien Zoom, durée et champs vérifiés', async () => {
    await couple();
    const ref = (id) => doc(coach(), `accompagnements/a1/rendezVous/${id}`);
    await assertSucceeds(setDoc(ref('r1'), rdv({ lienZoom: '' })));
    await assertFails(setDoc(ref('r2'), rdv({ lienZoom: 'javascript:alert(1)' })));
    await assertFails(setDoc(ref('r3'), rdv({ dureeMin: 600 })));
    await assertFails(setDoc(ref('r4'), rdv({ statut: 'inconnu' })));
    await assertFails(setDoc(ref('r5'), rdv({ pirate: true })));
  });

  it('agenda : le coach seul liste tous les rendez-vous', async () => {
    await couple();
    await env.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), 'accompagnements/a1/rendezVous/r1'), rdv());
    });
    await assertSucceeds(getDocs(collectionGroup(coach(), 'rendezVous')));
    await assertFails(getDocs(collectionGroup(marie(), 'rendezVous')));
  });
});

describe('forfaits et paiements', () => {
  // 1000000000 % 97 = 34 → communication 100000000034.
  const COMM = '100000000034';
  const donnees = async () => env.withSecurityRulesDisabled(async (ctx) => {
    const db = ctx.firestore();
    await setDoc(doc(db, 'accompagnements/a1'), {
      type: 'couple', nom: 'Paul & Marie', membres: ['marie', 'paul'], statut: 'actif', seancesRestantes: 0,
    });
    await setDoc(doc(db, 'forfaits/f5'), { nom: { fr: '5 séances' }, nbSeances: 5, prix: 250, devise: 'EUR', actif: true, ordre: 0 });
    await setDoc(doc(db, 'forfaits/vieux'), { nom: { fr: 'Ancien' }, nbSeances: 10, prix: 100, devise: 'EUR', actif: false, ordre: 1 });
  });
  const achat = (extra = {}) => ({
    type: 'forfait', uid: 'marie', nom: 'Marie', accompagnementId: 'a1', forfaitId: 'f5',
    forfaitNom: '5 séances', nbSeances: 5, montant: 250, devise: 'EUR', statut: 'en_attente',
    createdAt: serverTimestamp(), ...extra,
  });
  const don = (extra = {}) => ({
    type: 'don', uid: 'marie', nom: 'Marie', montant: 20, devise: 'EUR', statut: 'en_attente',
    createdAt: serverTimestamp(), ...extra,
  });

  it('forfaits : actifs visibles par tous, écrits par le coach', async () => {
    await donnees();
    await assertSucceeds(getDoc(doc(visiteur(), 'forfaits/f5')));
    await assertFails(getDoc(doc(marie(), 'forfaits/vieux')));
    await assertSucceeds(getDocs(query(collection(visiteur(), 'forfaits'), where('actif', '==', true))));
    await assertSucceeds(setDoc(doc(coach(), 'forfaits/f10'),
      { nom: { fr: '10 séances', en: '10 sessions' }, nbSeances: 10, prix: 450, devise: 'EUR', actif: true, ordre: 2 }));
    await assertFails(setDoc(doc(marie(), 'forfaits/f11'),
      { nom: { fr: 'Gratuit' }, nbSeances: 10, prix: 1, devise: 'EUR', actif: true, ordre: 2 }));
    await assertFails(setDoc(doc(coach(), 'forfaits/f12'),
      { nom: { fr: 'X' }, nbSeances: 0, prix: 10, devise: 'EUR', actif: true, ordre: 2 }));
  });

  it('achat : communication valide, prix et séances du forfait, son accompagnement', async () => {
    await donnees();
    await assertSucceeds(setDoc(doc(marie(), `paiements/${COMM}`), achat()));
    await assertFails(setDoc(doc(marie(), 'paiements/100000000035'), achat()));
    await assertFails(setDoc(doc(marie(), 'paiements/200000000068'), achat({ montant: 1 })));
    await assertFails(setDoc(doc(marie(), 'paiements/200000000068'), achat({ nbSeances: 50 })));
    await assertFails(setDoc(doc(marie(), 'paiements/200000000068'), achat({ forfaitId: 'vieux', montant: 100, nbSeances: 10 })));
    await assertFails(setDoc(doc(marie(), 'paiements/200000000068'), achat({ statut: 'recu' })));
    await assertFails(setDoc(doc(marie(), 'paiements/200000000068'), achat({ uid: 'paul' })));
    const lucie = env.authenticatedContext('lucie').firestore();
    await assertFails(setDoc(doc(lucie, 'paiements/200000000068'), achat({ uid: 'lucie' })));
  });

  it('don libre, lecture de ses paiements seulement', async () => {
    await donnees();
    await assertSucceeds(setDoc(doc(marie(), `paiements/${COMM}`), don()));
    await assertFails(setDoc(doc(marie(), 'paiements/200000000068'), don({ montant: 0 })));
    await assertFails(setDoc(doc(marie(), 'paiements/200000000068'), don({ nbSeances: 5 })));
    await assertSucceeds(getDoc(doc(marie(), `paiements/${COMM}`)));
    await assertFails(getDoc(doc(paul(), `paiements/${COMM}`)));
    await assertSucceeds(getDocs(query(collection(marie(), 'paiements'), where('uid', '==', 'marie'))));
    await assertSucceeds(getDocs(collection(coach(), 'paiements')));
  });

  it('seul le coach confirme ; le client peut renoncer tant que c\'est en attente', async () => {
    await donnees();
    await assertSucceeds(setDoc(doc(marie(), `paiements/${COMM}`), achat()));
    const ref = (db) => doc(db, `paiements/${COMM}`);
    await assertFails(updateDoc(ref(marie()), { statut: 'recu' }));
    await assertFails(updateDoc(ref(marie()), { montant: 1 }));
    await assertSucceeds(updateDoc(ref(coach()), { statut: 'recu', confirmeLe: serverTimestamp() }));
    await assertFails(updateDoc(ref(marie()), { statut: 'annule' }));
    await assertFails(updateDoc(ref(coach()), { statut: 'annule' }));
    // Les séances ne sont jamais créditées par un membre.
    await assertFails(updateDoc(doc(marie(), 'accompagnements/a1'), { seancesRestantes: 5 }));
  });

  it('paramètres du coach : lus par les connectés, IBAN vérifié', async () => {
    const p = { nomAffiche: 'Nathan', titulaire: 'Nathan Damna', iban: 'BE71096123456769', bic: 'GKCCBEBB', messageDon: { fr: 'Merci !' } };
    await assertSucceeds(setDoc(doc(coach(), 'parametres/coach'), p));
    await assertFails(setDoc(doc(coach(), 'parametres/coach'), { ...p, iban: 'BE71 0961' }));
    await assertFails(setDoc(doc(marie(), 'parametres/coach'), p));
    await assertSucceeds(getDoc(doc(marie(), 'parametres/coach')));
    await assertFails(getDoc(doc(visiteur(), 'parametres/coach')));
  });
});

describe('livres et commandes', () => {
  const COMM = '100000000034';
  const livre = (extra = {}) => ({
    titre: { fr: 'Aimer selon Dieu' }, sousTitre: {}, description: { fr: 'Un livre.' },
    couvertureUrl: 'https://x/c.jpg', langues: ['fr'],
    formats: [{ type: 'papier', prix: 19.9, devise: 'EUR' }, { type: 'numerique', prix: 9.99, devise: 'EUR' }],
    prixPapier: 19.9, liensAchat: [{ libelle: 'Amazon', url: 'https://amazon.fr/x' }],
    commandeDirecte: true, fraisEnvoi: 4.5, extraitUrl: '', publie: true, ordre: 0, ...extra,
  });
  const preparer = () => env.withSecurityRulesDisabled(async (ctx) => {
    await setDoc(doc(ctx.firestore(), 'livres/l1'), livre());
    await setDoc(doc(ctx.firestore(), 'livres/brouillon'), livre({ publie: false }));
    await setDoc(doc(ctx.firestore(), 'livres/liens'), livre({ commandeDirecte: false }));
  });
  const adresse = { nom: 'Marie', rue: 'Rue de la Paix 1', codePostal: '1000', ville: 'Bruxelles', pays: 'Belgique' };
  const commande = (extra = {}) => ({
    uid: 'marie', nom: 'Marie', livreId: 'l1', livreTitre: 'Aimer selon Dieu', quantite: 2,
    montant: 19.9 * 2 + 4.5, devise: 'EUR', adresse, statut: 'en_attente', createdAt: serverTimestamp(), ...extra,
  });

  it('livres publiés visibles par tous ; brouillons et écriture : le coach', async () => {
    await preparer();
    await assertSucceeds(getDoc(doc(visiteur(), 'livres/l1')));
    await assertFails(getDoc(doc(visiteur(), 'livres/brouillon')));
    await assertSucceeds(getDoc(doc(coach(), 'livres/brouillon')));
    await assertSucceeds(setDoc(doc(coach(), 'livres/l2'), livre()));
    // Boutique : un livre ou un autre article, rien d'autre.
    await assertSucceeds(setDoc(doc(coach(), 'livres/a1'), livre({ categorie: 'autre' })));
    await assertFails(setDoc(doc(coach(), 'livres/a2'), livre({ categorie: 'numerique' })));
    await assertFails(setDoc(doc(marie(), 'livres/l3'), livre()));
    await assertFails(setDoc(doc(coach(), 'livres/l4'), livre({ extraitUrl: 'javascript:alert(1)' })));
    await assertFails(setDoc(doc(coach(), 'livres/l5'), livre({ prixPapier: null })));
  });

  it('commande : montant du livre, commande directe, livre publié', async () => {
    await preparer();
    await assertSucceeds(setDoc(doc(marie(), `commandesLivres/${COMM}`), commande()));
    await assertFails(setDoc(doc(marie(), 'commandesLivres/200000000068'), commande({ montant: 1 })));
    await assertFails(setDoc(doc(marie(), 'commandesLivres/200000000068'), commande({ livreId: 'brouillon' })));
    await assertFails(setDoc(doc(marie(), 'commandesLivres/200000000068'), commande({ livreId: 'liens' })));
    await assertFails(setDoc(doc(marie(), 'commandesLivres/200000000068'), commande({ quantite: 50, montant: 19.9 * 50 + 4.5 })));
    await assertFails(setDoc(doc(marie(), 'commandesLivres/200000000068'), commande({ statut: 'payee' })));
    await assertFails(setDoc(doc(marie(), 'commandesLivres/100000000035'), commande()));
    await assertFails(setDoc(doc(marie(), 'commandesLivres/200000000068'), commande({ adresse: { nom: 'Marie' } })));
  });

  it('suivi : le coach passe à payée puis envoyée ; le client renonce seulement en attente', async () => {
    await preparer();
    await assertSucceeds(setDoc(doc(marie(), `commandesLivres/${COMM}`), commande()));
    const ref = (db) => doc(db, `commandesLivres/${COMM}`);
    await assertFails(getDoc(ref(paul())));
    await assertFails(updateDoc(ref(marie()), { statut: 'payee' }));
    await assertFails(updateDoc(ref(coach()), { statut: 'envoyee' }));
    await assertSucceeds(updateDoc(ref(coach()), { statut: 'payee', payeeLe: serverTimestamp() }));
    await assertFails(updateDoc(ref(marie()), { statut: 'annulee' }));
    await assertSucceeds(updateDoc(ref(coach()), { statut: 'envoyee', envoyeeLe: serverTimestamp(), numeroSuivi: 'BPOST123' }));
    await assertSucceeds(getDoc(ref(marie())));
  });
});

describe('présentation du coach', () => {
  it('visible par tous, écrite par le coach seulement', async () => {
    const p = { nomAffiche: 'Nathan', bio: { fr: 'Coach de couple.' }, photoUrl: 'https://x/p.jpg' };
    await assertSucceeds(setDoc(doc(coach(), 'parametres/presentation'), p));
    await assertSucceeds(getDoc(doc(visiteur(), 'parametres/presentation')));
    await assertFails(setDoc(doc(marie(), 'parametres/presentation'), p));
    await assertFails(setDoc(doc(coach(), 'parametres/presentation'), { ...p, iban: 'BE71096123456769' }));
    // Les coordonnées bancaires restent réservées aux personnes connectées.
    await assertFails(getDoc(doc(visiteur(), 'parametres/coach')));
  });
});
