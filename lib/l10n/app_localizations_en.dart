// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nous deux avec Dieu';

  @override
  String get slogan => 'Growing together, with God at the centre.';

  @override
  String get navAccueil => 'Home';

  @override
  String get navContenus => 'Content';

  @override
  String get navMessages => 'Messages';

  @override
  String get navSeances => 'Sessions';

  @override
  String get navProfil => 'Profile';

  @override
  String get navCoach => 'Coach';

  @override
  String get bientot => 'Coming soon';

  @override
  String get accueilAVenir =>
      'Here: today\'s meditation, your next appointment and your exercises.';

  @override
  String get contenusAVenir =>
      'Here: meditations, questions for two, programmes, audio and videos.';

  @override
  String get messagesAVenir => 'Here: your conversation with your coach.';

  @override
  String get seancesAVenir =>
      'Here: your appointments, remaining sessions and packages.';

  @override
  String get profilAVenir =>
      'Here: your language, your spouse, donations and your data.';

  @override
  String get coachAVenir =>
      'Here: the couples you accompany, your calendar, your content and payments.';

  @override
  String get bienvenueQuestion => 'What brings you here?';

  @override
  String get parcoursCouple => 'We are coming as a couple';

  @override
  String get parcoursCoupleAide => 'Married, engaged or in a relationship';

  @override
  String get parcoursSeul => 'I am coming alone';

  @override
  String get parcoursSeulAide => 'To grow personally or prepare for the future';

  @override
  String get parcoursDecouverte => 'Just exploring';

  @override
  String get parcoursDecouverteAide =>
      'Meditations, questions for two, audio and videos';

  @override
  String get continuerEmail => 'Continue with email';

  @override
  String get explorerSansCompte => 'Explore without an account';

  @override
  String get seConnecter => 'Sign in';

  @override
  String get creerCompte => 'Create an account';

  @override
  String get seDeconnecter => 'Sign out';

  @override
  String get champNom => 'First and last name';

  @override
  String get champEmail => 'Email address';

  @override
  String get champMotDePasse => 'Password';

  @override
  String get afficherMotDePasse => 'Show password';

  @override
  String get masquerMotDePasse => 'Hide password';

  @override
  String get motDePasseOublie => 'Forgot your password?';

  @override
  String emailReinitialisationEnvoye(String email) {
    return 'An email to choose a new password has been sent to $email.';
  }

  @override
  String get validationNomRequis => 'Please enter your name.';

  @override
  String get validationEmail => 'Please enter a valid email address.';

  @override
  String get validationMotDePasse => 'At least 8 characters.';

  @override
  String get consentementTexte =>
      'I agree that my answers and messages, which may concern my faith and my relationship, are stored in Europe and seen only by my coach, in order to support me. I can withdraw my consent and delete my account at any time.';

  @override
  String get consentementRequis =>
      'Please tick the box to create your account.';

  @override
  String get chargement => 'Loading…';

  @override
  String get erreurEmailInvalide => 'This email address is not valid.';

  @override
  String get erreurMotDePasseFaible =>
      'This password is too weak. Use at least 8 characters.';

  @override
  String get erreurEmailDejaUtilise =>
      'An account already exists with this address. Please sign in instead.';

  @override
  String get erreurIdentifiantsIncorrects =>
      'Incorrect email address or password.';

  @override
  String get erreurTropDeTentatives =>
      'Too many attempts. Try again in a few minutes.';

  @override
  String get erreurReseau =>
      'No internet connection. Check your network and try again.';

  @override
  String get erreurInconnue => 'Something went wrong. Please try again.';

  @override
  String get connexionRequiseTitre => 'A space just for you';

  @override
  String get connexionRequiseTexte =>
      'Sign in to talk with your coach, follow your sessions and manage your profile.';

  @override
  String bonjourNom(String nom) {
    return 'Hello $nom';
  }

  @override
  String get roleCoach => 'Coach';
}
