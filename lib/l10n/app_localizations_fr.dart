// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Nous deux avec Dieu';

  @override
  String get slogan => 'Grandir à deux, avec Dieu au centre.';

  @override
  String get navAccueil => 'Accueil';

  @override
  String get navContenus => 'Contenus';

  @override
  String get navMessages => 'Messages';

  @override
  String get navSeances => 'Séances';

  @override
  String get navProfil => 'Profil';

  @override
  String get navCoach => 'Coach';

  @override
  String get bientot => 'Bientôt disponible';

  @override
  String get accueilAVenir =>
      'Ici : la méditation du jour, votre prochain rendez-vous et vos exercices.';

  @override
  String get contenusAVenir =>
      'Ici : méditations, questions à deux, parcours, audios et vidéos.';

  @override
  String get messagesAVenir => 'Ici : votre conversation avec votre coach.';

  @override
  String get seancesAVenir =>
      'Ici : vos rendez-vous, vos séances restantes et les forfaits.';

  @override
  String get profilAVenir =>
      'Ici : votre langue, votre conjoint, les dons et vos données.';

  @override
  String get coachAVenir =>
      'Ici : vos accompagnements, votre agenda, vos contenus et les paiements.';

  @override
  String get bienvenueQuestion => 'Qu\'est-ce qui vous amène ?';

  @override
  String get parcoursCouple => 'Nous venons en couple';

  @override
  String get parcoursCoupleAide => 'Mariés, fiancés ou en couple';

  @override
  String get parcoursSeul => 'Je viens seul(e)';

  @override
  String get parcoursSeulAide =>
      'Pour avancer personnellement ou préparer l\'avenir';

  @override
  String get parcoursDecouverte => 'Je découvre';

  @override
  String get parcoursDecouverteAide =>
      'Méditations, questions à deux, audios et vidéos';

  @override
  String get continuerEmail => 'Continuer avec l\'e-mail';

  @override
  String get explorerSansCompte => 'Découvrir sans compte';

  @override
  String get seConnecter => 'Se connecter';

  @override
  String get creerCompte => 'Créer un compte';

  @override
  String get seDeconnecter => 'Se déconnecter';

  @override
  String get champNom => 'Prénom et nom';

  @override
  String get champEmail => 'Adresse e-mail';

  @override
  String get champMotDePasse => 'Mot de passe';

  @override
  String get afficherMotDePasse => 'Afficher le mot de passe';

  @override
  String get masquerMotDePasse => 'Masquer le mot de passe';

  @override
  String get motDePasseOublie => 'Mot de passe oublié ?';

  @override
  String emailReinitialisationEnvoye(String email) {
    return 'Un e-mail pour choisir un nouveau mot de passe a été envoyé à $email.';
  }

  @override
  String get validationNomRequis => 'Indiquez votre nom.';

  @override
  String get validationEmail => 'Indiquez une adresse e-mail valide.';

  @override
  String get validationMotDePasse => 'Au moins 8 caractères.';

  @override
  String get consentementTexte =>
      'J\'accepte que mes réponses et échanges, qui peuvent concerner ma foi et ma vie de couple, soient conservés en Europe et vus uniquement par mon coach, pour m\'accompagner. Je peux retirer mon accord et supprimer mon compte à tout moment.';

  @override
  String get consentementRequis => 'Cochez la case pour créer votre compte.';

  @override
  String get chargement => 'Chargement…';

  @override
  String get erreurEmailInvalide => 'Cette adresse e-mail n\'est pas valide.';

  @override
  String get erreurMotDePasseFaible =>
      'Ce mot de passe est trop faible. Utilisez au moins 8 caractères.';

  @override
  String get erreurEmailDejaUtilise =>
      'Un compte existe déjà avec cette adresse. Connectez-vous plutôt.';

  @override
  String get erreurIdentifiantsIncorrects =>
      'Adresse e-mail ou mot de passe incorrect.';

  @override
  String get erreurTropDeTentatives =>
      'Trop de tentatives. Réessayez dans quelques minutes.';

  @override
  String get erreurReseau =>
      'Pas de connexion internet. Vérifiez votre réseau et réessayez.';

  @override
  String get erreurInconnue => 'Une erreur est survenue. Réessayez.';

  @override
  String get connexionRequiseTitre => 'Un espace rien qu\'à vous';

  @override
  String get connexionRequiseTexte =>
      'Connectez-vous pour échanger avec votre coach, suivre vos séances et gérer votre profil.';

  @override
  String bonjourNom(String nom) {
    return 'Bonjour $nom';
  }

  @override
  String get roleCoach => 'Coach';
}
