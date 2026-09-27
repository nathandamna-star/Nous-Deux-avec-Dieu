# CLAUDE.md — Projet « Nous deux avec Dieu »

> Ce fichier décrit l'application à construire. Lis-le en entier avant de commencer.
> Le porteur du projet (le coach) n'est pas développeur : explique chaque étape simplement, en
> français, et dis-lui exactement quoi faire quand une action de sa part est nécessaire
> (créer un compte, copier une clé, installer un outil).

## 1. Le projet

« Nous deux avec Dieu » est l'application d'un **coach de couple chrétien** (un seul coach : le
porteur du projet). Elle lui permet d'accompagner des **couples** et des **personnes seules**
(fiancés, célibataires, personnes mariées venant sans leur conjoint) dans une démarche de foi.

- **Le coach** : suit ses accompagnements, envoie des exercices et des parcours, lit les réponses,
  échange par messages, planifie les séances (lien Zoom), prend des notes privées, publie des
  contenus (textes, audios, vidéos), confirme les paiements reçus par virement.
- **Les clients** : un compte **individuel** ou un compte **couple** (chaque conjoint a son propre
  accès, les deux sont reliés) ; ils font les exercices, voient leurs rendez-vous, écrivent au coach,
  achètent des forfaits de séances et peuvent faire un don.
- **Tout le monde**, même sans accompagnement : contenus gratuits (méditation du jour, questions pour
  discuter à deux, parcours, audios et vidéos publics).

**Modèle économique** : pas d'abonnement. Les contenus sont gratuits. Le coach est rémunéré par les
**forfaits de séances payés par virement** et par les **dons** (virement). Aucun paiement par carte en V1.

## 2. Choix techniques (imposés)

| Sujet | Choix |
|---|---|
| Application | **Flutter** (iOS + Android), Dart, null safety |
| Gestion d'état | Riverpod |
| Navigation | go_router |
| Back-end | **Firebase** : Authentication, Cloud Firestore, Storage, Cloud Messaging, Cloud Functions |
| Région des données | `europe-west1` (RGPD) |
| Langues | **Français** (par défaut), **anglais**, **portugais**, **espagnol**, **néerlandais** via `flutter_localizations` + ARB. Aucun texte en dur dans le code |
| Audio | lecture en arrière-plan et écran verrouillé (`just_audio` + `audio_service` ou équivalent) |
| Vidéo | `video_player` (plein écran, reprise) ; vidéos compressées avant envoi |
| Visio | **Zoom, hors de l'app** : le coach colle le lien Zoom dans le rendez-vous |
| Virements | IBAN + communication structurée belge + QR code de virement européen (EPC / SEPA) |

N'ajoute pas d'autre service payant sans le demander. Même compte Apple Developer que Harambee.

## 3. Identité visuelle (provisoire, à valider)

- Couleurs : principale `#7A2E3A` (bordeaux), secondaire `#C8963E` (or doux), fond `#FBF6F1`
  (ivoire), cartes `#FFFFFF`, texte `#2A1F1D`, texte secondaire `#6B5E58`, bordures `#E8DDD4`.
- Polices : **Cormorant Garamond** (titres) et **Nunito Sans** (texte), incluses dans l'app.
- Ton : chaleureux, bienveillant, jamais culpabilisant. Coins arrondis 12–20 px, zones tactiles
  ≥ 44 px, contraste AA, mode sombre.
- Barre du bas (client) : Accueil, Contenus, Messages, Séances, Profil. Le coach a en plus
  l'onglet **Coach**.

## 4. Modèle de données Firestore

```
users/{uid}
  nom, email, photoUrl, langue: "fr"|"en"|"pt"|"es"|"nl",
  accompagnementId | null, consentementLe, jetonsNotif, createdAt

accompagnements/{id}
  type: "couple" | "individuel", nom (ex. « Paul & Marie »),
  membres: [uid, uid?], codeInvitation (pour relier le conjoint),
  statut: "demande" | "actif" | "en_pause" | "termine",
  seancesRestantes (écrit par Cloud Function), createdAt, updatedAt

accompagnements/{id}/notes/{noteId}          — coach uniquement
  texte, createdAt, updatedAt

accompagnements/{id}/exercices/{exerciceId}
  contenuId | null, titre, consignes, aFaireAvant | null,
  mode: "seul" | "a_deux", reponses: { uid: { texte, le } },
  statut: "a_faire" | "fait", createdAt

accompagnements/{id}/messages/{messageId}
  auteur, texte, photoUrl?, audioUrl?, createdAt
  (+ nonLusCoach / nonLusClients sur l'accompagnement)

rendezVous/{id}
  accompagnementId, debut, dureeMin, lienZoom, statut: "prevu"|"fait"|"annule",
  rappelEnvoye, createdAt

contenus/{id}
  type: "meditation" | "question" | "exercice" | "audio" | "video" | "article",
  theme (communication, pardon, finances, intimité, prière, enfants, fiançailles…),
  titre: { fr, en, pt, es, nl }, texte: { … }, versets: [ … ],
  medias: { fr: url, en: url, … } (audio/vidéo), dureeSec, imageUrl,
  visibilite: "public" | "accompagnes" | "prive", publie: bool, ordre, createdAt

parcours/{id}
  titre: {…}, description: {…}, imageUrl, etapes: [contenuId…], publie, ordre

forfaits/{id}
  nom: {…}, nbSeances, prix, devise: "EUR", actif, ordre

paiements/{id}
  type: "forfait" | "don", uid, accompagnementId | null, forfaitId | null,
  montant, devise, communication (structurée +++xxx/xxxx/xxxxx+++),
  statut: "en_attente" | "recu" | "annule", createdAt, confirmeLe

parametres/coach
  nomAffiche, bio: {…}, photoUrl, titulaire, iban, bic, messageDon: {…}

livres/{id}
  titre: {…}, sousTitre: {…}, description: {…}, couvertureUrl, langues: ["fr", …],
  formats: [{ type: "papier" | "numerique" | "audio", prix, devise }],
  liensAchat: [{ libelle (ex. « Amazon », « Fnac », « Mon site »), url }],
  commandeDirecte: bool (livre papier commandé au coach, payé par virement),
  extraitUrl | null, publie, ordre, createdAt

commandesLivres/{id}
  uid, livreId, quantite, montant (prix + frais d'envoi), devise,
  adresse: { nom, rue, codePostal, ville, pays }, communication (structurée),
  statut: "en_attente" | "payee" | "envoyee" | "annulee", createdAt
```

Les textes des contenus existent en plusieurs langues ; si une langue manque, l'app affiche le
français (ou la première version disponible) avec une petite mention.

## 5. Règles de sécurité (obligatoires, testées avec l'émulateur)

- Le rôle **coach** est un *custom claim* (`coach: true`), attribué par une Cloud Function au compte
  dont l'e-mail est donné au déploiement, jamais par l'app.
- Un client ne lit que **son** accompagnement (il en est membre) et ses sous-collections, sauf les
  **notes**, réservées au coach. Le coach lit et écrit tout.
- Un client rejoint un accompagnement couple uniquement avec le bon `codeInvitation` (Cloud Function).
- Exercices : le client n'écrit que **sa** réponse et le statut ; titre et consignes par le coach.
- Contenus, parcours, forfaits : lisibles par tous s'ils sont publiés (et `visibilite` compatible) ;
  écrits par le coach seulement.
- Paiements : le client crée un paiement `en_attente` à son nom ; seul le coach le passe à `recu` ou
  `annule` ; `seancesRestantes` n'est jamais écrit par l'app (Cloud Function).
- `parametres/coach` : lisible par les utilisateurs connectés, écrit par le coach.
- Storage : images, audios et vidéos ; écriture par le coach (contenus) ou par les membres de
  l'accompagnement (photos/audios des messages) ; tailles limitées (image 5 Mo, audio 50 Mo,
  vidéo 500 Mo).

## 6. Données sensibles (RGPD) — priorité absolue

Foi, vie de couple, intimité, conflits, santé : ce sont des **données sensibles** (article 9 RGPD).

- **Consentement explicite** à l'inscription (case non pré-cochée, texte clair), date enregistrée.
- Minimisation : ne demander que le nécessaire. Notes du coach visibles par lui seul.
- Export et **suppression du compte** depuis l'app (Cloud Function) ; quand un conjoint supprime son
  compte, l'autre garde l'accès à ses propres données.
- Données en Europe, connexions chiffrées ; aucune donnée envoyée à un outil d'analyse ou de publicité.
- Politique de confidentialité et CGU spécifiques (modèles à faire relire par un juriste).

## 7. Écrans de la version 1

**Clients**
1. **Bienvenue / connexion** : e-mail, Google, Apple (obligatoire sur iOS si Google). Choix
   « Je viens en couple » / « Je viens seul(e) » / « Je découvre seulement ». Consentement RGPD.
2. **Accueil** : méditation du jour, prochain rendez-vous (bouton « Rejoindre sur Zoom »), exercices à
   faire, dernier contenu publié par le coach.
3. **Contenus** : bibliothèque par thème et par type (méditations, questions à deux, parcours,
   audios, vidéos) ; lecteur audio (arrière-plan, écran verrouillé, vitesse, reprise) ; lecteur vidéo ;
   favoris ; progression dans les parcours.
4. **Messages** : conversation avec le coach (les deux conjoints voient la même conversation),
   photos et messages vocaux ; notifications.
5. **Séances** : prochains rendez-vous, historique, séances restantes ; **acheter un forfait**
   (IBAN, montant, communication structurée, QR code de virement, bouton copier) ; état du paiement.
6. **Mes livres** (accessible depuis l'Accueil et les Contenus) : tous les livres publiés par le coach,
   avec couverture, présentation, extrait éventuel, formats et prix ; boutons **« Acheter sur … »**
   (liens vers Amazon, Fnac, le site du coach…) et, pour le livre papier, **« Commander au coach »**
   (adresse de livraison, paiement par virement avec QR code, suivi : payée, envoyée).
7. **Profil** : langue, relier son conjoint (code d'invitation), **Faire un don**, notifications,
   export et suppression du compte, CGU et confidentialité.

**Coach** (onglet Coach)
8. **Tableau de bord** : demandes d'accompagnement, paiements à confirmer, exercices rendus,
   rendez-vous du jour, messages non lus.
9. **Accompagnements** : liste (couples / individuels, statut), fiche : membres, séances restantes,
   exercices (envoyer depuis la bibliothèque ou créer, lire les réponses), rendez-vous, messages,
   **notes privées**.
10. **Agenda** : créer / modifier / annuler un rendez-vous avec lien Zoom ; rappels automatiques
   (veille et 1 h avant).
11. **Éditeur de contenus** : créer et modifier méditations, questions, exercices, articles, parcours,
    **audios et vidéos** (enregistrer, ou choisir un fichier), une version par langue, visibilité,
    publication ; notification « nouveau contenu » optionnelle.
12. **Paiements et dons** : liste, confirmer « Paiement reçu » (crédite les séances), annuler ;
    totaux par mois ; forfaits (nom, nombre de séances, prix).
13. **Livres** : ajouter / modifier un livre (couverture, textes par langue, formats, prix, liens
    d'achat, commande directe, frais d'envoi) ; commandes de livres à confirmer puis marquer « envoyée ».
14. **Paramètres coach** : nom affiché, photo, présentation, coordonnées bancaires (IBAN, BIC,
    titulaire), message de remerciement des dons.

## 8. Paiements par virement et dons (règles des stores)

- Les **séances** sont un service réel de personne à personne : le paiement hors des stores
  (virement) est autorisé.
- Le **don** est entièrement libre et **ne débloque rien** (sinon Apple exigerait son propre système
  de paiement). Aucun contenu n'est réservé aux donateurs.
- **Livres** : un livre papier est un bien physique, il peut être payé par virement ou acheté via
  un lien externe. Un livre numérique n'est **jamais lu ni téléchargé dans l'app** : on renvoie vers
  la boutique qui le vend (Amazon, Fnac, site du coach), sinon Apple exigerait son système de paiement.
- Communication structurée belge générée par paiement (modulo 97), QR code EPC (norme SEPA) lisible
  par les applications bancaires.
- Le coach confirme la réception manuellement ; une Cloud Function crédite alors les séances et
  prévient le client.

## 9. Contenus de départ

Rédigés par Claude en français puis traduits dans les 4 autres langues (relecture native conseillée
pour l'espagnol et le néerlandais) : 30 méditations quotidiennes, 60 questions pour discuter à deux,
4 parcours (Mieux communiquer, Le pardon, Nos finances, Se préparer au mariage), textes de bienvenue.
Ils sont chargés dans Firestore par un script, puis **modifiables par le coach dans l'app**.

## 10. Hors périmètre V1

Abonnement, paiement par carte, visio intégrée (Zoom reste à part), groupes et forums, plusieurs coachs.

## 11. Ordre de travail

À la fin de chaque étape : l'app compile, les tests passent, commit, résumé en français et ce que le
coach doit vérifier sur son téléphone.

1. Projet Flutter, thème, polices, 5 langues, navigation avec écrans vides.
2. Projet Firebase (guider le coach), authentification (e-mail, Google, Apple), consentement, rôle coach.
3. Modèle de données, règles de sécurité et leurs tests.
4. Accompagnements : demande, compte couple (code d'invitation), espace coach (liste, fiche, notes).
5. Contenus : bibliothèque, lecteurs audio et vidéo, éditeur du coach (textes, audios, vidéos, langues).
6. Exercices et parcours (envoi, réponses, progression).
7. Messagerie et notifications.
8. Rendez-vous, lien Zoom, rappels.
9. Forfaits, paiements par virement (QR code, communication structurée), dons, confirmation.
9 bis. Rubrique « Mes livres » (catalogue, liens d'achat, commande directe par virement, suivi).
10. Profil, export et suppression du compte, pages légales.
11. Contenus de départ (5 langues), tests sur appareils, fiches App Store / Google Play.

Avant toute décision importante non prévue ici, pose la question au lieu de choisir seul.

## Notes techniques (tenues à jour au fil des étapes)

- Structure : `lib/core/` (thème, navigation), `lib/features/<fonctionnalité>/`, `lib/shared/widgets/`.
- Traductions : `lib/l10n/app_fr.arb` (modèle), `app_en.arb`, `app_pt.arb`, `app_es.arb`, `app_nl.arb` ;
  code généré par `flutter gen-l10n` (`generate: true`). Langue du téléphone, sinon français.
- Polices incluses dans `assets/google_fonts/` (Cormorant Garamond, Nunito Sans ; licences OFL jointes).
- Identifiant de l'app : `com.nousdeuxavecdieu.app` (iOS et Android).
- Navigation : `StatefulShellRoute` à 5 onglets ; onglet Coach si `estCoachProvider` (branché à l'étape 2).
- Vérifier avant chaque commit : `flutter analyze` et `flutter test` (CI : `.github/workflows/ci.yml`).
