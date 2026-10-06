# Guide de publication (App Store et Google Play)

Textes des fiches : `docs/fiches-stores.md`.

## 1. Adresses web à fournir aux stores

- Politique de confidentialité : https://europe-west1-nous-deux-avec-dieu.cloudfunctions.net/legal?page=confidentialite
- Conditions d'utilisation : https://europe-west1-nous-deux-avec-dieu.cloudfunctions.net/legal?page=cgu
- Aide / support : https://europe-west1-nous-deux-avec-dieu.cloudfunctions.net/legal?page=support

Avant la publication : compléter les passages entre [ ] dans `assets/legal/` (et leurs copies dans
`functions/legal/`), faire relire par un juriste, puis redéployer les fonctions.

## 2. Informations générales

- Identifiant iOS : `com.nousdeuxavecdieu.app` (même compte Apple Developer que Harambee).
- Catégorie : Style de vie (secondaire : Livres ou Santé et forme).
- Âge : 12+ (thèmes de couple et de sexualité abordés de façon éducative et sobre, sans contenu explicite).
- Prix : gratuit. Pas d'achats intégrés.

## 3. Confidentialité (« App Privacy » Apple / « Sécurité des données » Google)

Données collectées, **liées à l'identité**, **jamais utilisées pour le suivi publicitaire** :

- Coordonnées : nom, adresse e-mail.
- Contenu utilisateur : messages, photos, enregistrements audio, réponses aux exercices.
- Informations sensibles : convictions religieuses et vie de couple (déduites des échanges).
- Achats : historique des forfaits payés par virement et des commandes de livres.
- Identifiants : identifiant du compte.
- Adresse postale : seulement pour la commande d'un livre papier.

Usage : fonctionnement de l'app uniquement. Chiffrement en transit : oui. Suppression possible
depuis l'app (Profil → Supprimer mon compte).

## 4. Comptes de test pour les vérificateurs

Créer, juste avant l'envoi en revue, un compte client de test avec un accompagnement accepté,
quelques messages, un rendez-vous et un forfait. Donner l'e-mail et le mot de passe dans les
« Notes pour la revue ». Ne jamais donner l'accès au compte du coach.

## 5. Notes pour la revue Apple (à coller en anglais)

> This app lets a Christian couple coach accompany couples. Coaching sessions are real-time,
> person-to-person services held on Zoom (App Store Review Guideline 3.1.3(d)); session packages are
> paid by bank transfer outside the app. Paperback books are physical goods (3.1.3(e)).
> No digital content is sold or unlocked: all devotionals, questions and courses are free.
> Users can delete their account in Profile → Delete my account.

## 6. Points d'attention (règles des stores)

- **Bouton « Faire un don »** : masqué sur iPhone / iPad (`donsDansAppProvider`, règle 3.2.2 : dons
  réservés aux organismes caritatifs reconnus) ; à la place, « Parlez-en à votre coach ». Gardé sur Android.
- **Liens « Acheter sur… »** : un lien vers l'achat d'un livre **numérique ou audio** peut être
  refusé par Apple (règle 3.1.1). Les liens vers le livre papier ne posent pas de problème. En cas de
  refus : ne mettre que des liens vers le format papier, ou masquer les liens sur iPhone.
- Google Play : même prudence pour les dons (paiement hors Google Play) ; les services de
  personne à personne et les biens physiques sont autorisés.

## 7. Avant d'envoyer l'app en revue

1. Compte Apple Developer validé ; clé APNs (.p8) ajoutée dans Firebase (Paramètres du projet →
   Cloud Messaging) ; dans Xcode, capacités « Push Notifications » et « Background Modes → Remote
   notifications ».
2. Paramètres du coach remplis (IBAN, présentation), forfaits créés, contenus de départ chargés et
   relus (espagnol et néerlandais par un locuteur natif si possible).
3. Icône et logo définitifs.
4. Captures d'écran : iPhone 6,9" et 6,5", Android téléphone ; Accueil, une méditation, un parcours,
   la conversation, l'onglet Séances.
5. `flutter build ipa` puis envoi avec Xcode (Organizer) ; `flutter build appbundle` pour Google Play.
