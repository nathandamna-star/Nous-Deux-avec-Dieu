// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Nous deux avec Dieu';

  @override
  String get slogan => 'Samen groeien, met God in het midden.';

  @override
  String get navAccueil => 'Start';

  @override
  String get navContenus => 'Inhoud';

  @override
  String get navMessages => 'Berichten';

  @override
  String get navSeances => 'Sessies';

  @override
  String get navProfil => 'Profiel';

  @override
  String get navCoach => 'Coach';

  @override
  String get bientot => 'Binnenkort beschikbaar';

  @override
  String get accueilAVenir =>
      'Hier: de overdenking van de dag, je volgende afspraak en je oefeningen.';

  @override
  String get contenusAVenir =>
      'Hier: overdenkingen, vragen voor jullie twee, trajecten, audio en video\'s.';

  @override
  String get messagesAVenir => 'Hier: je gesprek met je coach.';

  @override
  String get seancesAVenir =>
      'Hier: je afspraken, resterende sessies en pakketten.';

  @override
  String get profilAVenir =>
      'Hier: je taal, je partner, giften en je gegevens.';

  @override
  String get coachAVenir =>
      'Hier: je begeleidingen, je agenda, je inhoud en de betalingen.';

  @override
  String get bienvenueQuestion => 'Wat brengt je hier?';

  @override
  String get parcoursCouple => 'We komen als koppel';

  @override
  String get parcoursCoupleAide => 'Getrouwd, verloofd of samen';

  @override
  String get parcoursSeul => 'Ik kom alleen';

  @override
  String get parcoursSeulAide =>
      'Om persoonlijk te groeien of de toekomst voor te bereiden';

  @override
  String get parcoursDecouverte => 'Ik kijk even rond';

  @override
  String get parcoursDecouverteAide =>
      'Overdenkingen, vragen voor twee, audio en video\'s';

  @override
  String get continuerEmail => 'Doorgaan met e-mail';

  @override
  String get explorerSansCompte => 'Verkennen zonder account';

  @override
  String get seConnecter => 'Inloggen';

  @override
  String get creerCompte => 'Account aanmaken';

  @override
  String get seDeconnecter => 'Uitloggen';

  @override
  String get champNom => 'Voor- en achternaam';

  @override
  String get champEmail => 'E-mailadres';

  @override
  String get champMotDePasse => 'Wachtwoord';

  @override
  String get afficherMotDePasse => 'Wachtwoord tonen';

  @override
  String get masquerMotDePasse => 'Wachtwoord verbergen';

  @override
  String get motDePasseOublie => 'Wachtwoord vergeten?';

  @override
  String emailReinitialisationEnvoye(String email) {
    return 'Er is een e-mail naar $email gestuurd om een nieuw wachtwoord te kiezen.';
  }

  @override
  String get validationNomRequis => 'Vul je naam in.';

  @override
  String get validationEmail => 'Vul een geldig e-mailadres in.';

  @override
  String get validationMotDePasse => 'Minstens 8 tekens.';

  @override
  String get consentementTexte =>
      'Ik ga ermee akkoord dat mijn antwoorden en berichten, die over mijn geloof en mijn relatie kunnen gaan, in Europa worden bewaard en alleen door mijn coach worden gezien, om mij te begeleiden. Ik kan mijn toestemming altijd intrekken en mijn account verwijderen.';

  @override
  String get consentementRequis =>
      'Vink het vakje aan om je account aan te maken.';

  @override
  String get chargement => 'Laden…';

  @override
  String get erreurEmailInvalide => 'Dit e-mailadres is ongeldig.';

  @override
  String get erreurMotDePasseFaible =>
      'Dit wachtwoord is te zwak. Gebruik minstens 8 tekens.';

  @override
  String get erreurEmailDejaUtilise =>
      'Er bestaat al een account met dit adres. Log in.';

  @override
  String get erreurIdentifiantsIncorrects =>
      'Onjuist e-mailadres of wachtwoord.';

  @override
  String get erreurTropDeTentatives =>
      'Te veel pogingen. Probeer het over enkele minuten opnieuw.';

  @override
  String get erreurReseau =>
      'Geen internetverbinding. Controleer je netwerk en probeer opnieuw.';

  @override
  String get erreurInconnue => 'Er ging iets mis. Probeer het opnieuw.';

  @override
  String get connexionRequiseTitre => 'Een plek alleen voor jou';

  @override
  String get connexionRequiseTexte =>
      'Log in om met je coach te praten, je sessies te volgen en je profiel te beheren.';

  @override
  String bonjourNom(String nom) {
    return 'Hallo $nom';
  }

  @override
  String get roleCoach => 'Coach';
}
