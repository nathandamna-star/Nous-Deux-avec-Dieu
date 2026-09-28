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
  String get messagesAVenir => 'Hier: je gesprek met je coach.';

  @override
  String get seancesAVenir =>
      'Hier: je afspraken, resterende sessies en pakketten.';

  @override
  String get profilAVenir =>
      'Hier: je taal, je partner, giften en je gegevens.';

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

  @override
  String get monAccompagnement => 'Mijn begeleiding';

  @override
  String get demanderAccompagnement => 'Begeleiding aanvragen';

  @override
  String get demanderAccompagnementAide =>
      'Je coach antwoordt om een eerste afspraak te maken.';

  @override
  String get jAiUnCode => 'Ik heb een code van mijn partner';

  @override
  String get typeCouple => 'Als koppel';

  @override
  String get typeIndividuel => 'Alleen';

  @override
  String get champNomAccompagnement => 'Weergavenaam';

  @override
  String get champNomAccompagnementAide => 'Bijvoorbeeld „Paul & Marie”';

  @override
  String get champMessage => 'Je bericht aan de coach (optioneel)';

  @override
  String get champMessageAide => 'Wat jullie meemaken, waar jullie op hopen…';

  @override
  String get envoyerDemande => 'Aanvraag versturen';

  @override
  String get demandeEnvoyee => 'Aanvraag verzonden. Je coach antwoordt snel.';

  @override
  String get champObligatoire => 'Dit veld is verplicht.';

  @override
  String get rejoindreTitre => 'Mijn partner vervoegen';

  @override
  String get rejoindreAide =>
      'Voer de code van 6 tekens in die je partner in het profiel ziet.';

  @override
  String get champCode => 'Uitnodigingscode';

  @override
  String get rejoindre => 'Vervoegen';

  @override
  String get codeInvalide =>
      'Deze code is ongeldig of het koppel is al volledig.';

  @override
  String codePourConjoint(String code) {
    return 'Code voor je partner: $code';
  }

  @override
  String get codePourConjointAide =>
      'Je partner maakt een account aan en kiest „Ik heb een code van mijn partner”.';

  @override
  String get copier => 'Kopiëren';

  @override
  String get copie => 'Gekopieerd';

  @override
  String get statutDemande => 'Aanvraag in behandeling';

  @override
  String get statutActif => 'Begeleiding lopend';

  @override
  String get statutEnPause => 'Gepauzeerd';

  @override
  String get statutTermine => 'Afgerond';

  @override
  String seancesRestantes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Nog $n sessies',
      one: 'Nog 1 sessie',
      zero: 'Geen sessies meer',
    );
    return '$_temp0';
  }

  @override
  String get attendConjoint => 'Wacht op partner';

  @override
  String get filtreDemandes => 'Aanvragen';

  @override
  String get filtreActifs => 'Lopend';

  @override
  String get filtreTermines => 'Afgerond';

  @override
  String get aucunAccompagnement => 'Hier nog geen begeleidingen.';

  @override
  String get membres => 'Leden';

  @override
  String get messageDemande => 'Bericht bij de aanvraag';

  @override
  String get accepter => 'Aanvaarden';

  @override
  String get mettreEnPause => 'Pauzeren';

  @override
  String get reprendre => 'Hervatten';

  @override
  String get terminer => 'Afronden';

  @override
  String get seances => 'Sessies';

  @override
  String get retirerSeance => 'Sessie verwijderen';

  @override
  String get ajouterSeance => 'Sessie toevoegen';

  @override
  String get notesPrivees => 'Privénotities';

  @override
  String get notesPriveesAide => 'Alleen zichtbaar voor jou.';

  @override
  String get nouvelleNote => 'Nieuwe notitie';

  @override
  String get ajouter => 'Toevoegen';

  @override
  String get supprimer => 'Verwijderen';

  @override
  String get aucuneNote => 'Nog geen notities.';

  @override
  String get activerCoachTitre => 'Coachruimte activeren?';

  @override
  String get activerCoachTexte =>
      'Voorbehouden aan de coach: alleen het account dat bij de installatie is ingesteld, kan dit activeren.';

  @override
  String get coachActive => 'Coachruimte geactiveerd.';

  @override
  String get coachRefuse => 'Dit account kan geen coach worden.';

  @override
  String get annuler => 'Annuleren';

  @override
  String get valider => 'Bevestigen';

  @override
  String get typeMeditation => 'Overdenking';

  @override
  String get typeQuestion => 'Vraag voor twee';

  @override
  String get typeExercice => 'Oefening';

  @override
  String get typeArticle => 'Artikel';

  @override
  String get tous => 'Alle';

  @override
  String get themeCommunication => 'Communicatie';

  @override
  String get themePardon => 'Vergeving';

  @override
  String get themeFinances => 'Financiën';

  @override
  String get themeIntimite => 'Intimiteit';

  @override
  String get themePriere => 'Gebed';

  @override
  String get themeEnfants => 'Kinderen';

  @override
  String get themeFiancailles => 'Verloving';

  @override
  String get themeGratitude => 'Dankbaarheid';

  @override
  String get meditationDuJour => 'Overdenking van de dag';

  @override
  String get lire => 'Lezen';

  @override
  String get decouvrirContenus => 'Alle inhoud ontdekken';

  @override
  String get aucunContenu => 'Nog geen inhoud. Kom snel terug!';

  @override
  String get autreLangue => 'Nog niet vertaald in jouw taal.';

  @override
  String get accueilBienvenue => 'Moge de vrede van God jullie harten bewaren.';

  @override
  String get mesContenus => 'Mijn inhoud';

  @override
  String get nouveauContenu => 'Nieuwe inhoud';

  @override
  String get modifierContenu => 'Inhoud bewerken';

  @override
  String get brouillon => 'Concept';

  @override
  String get publie => 'Gepubliceerd';

  @override
  String get champType => 'Type';

  @override
  String get champTheme => 'Thema';

  @override
  String get champTitre => 'Titel';

  @override
  String get champTexte => 'Tekst';

  @override
  String get champReference => 'Bijbelverwijzing (optioneel)';

  @override
  String get champReferenceAide => 'Bv. Efeziërs 4:2';

  @override
  String get langueVersion => 'Versie';

  @override
  String get titreFrancaisRequis => 'De Franse titel is verplicht.';

  @override
  String get visiblePourTous => 'Zichtbaar zonder account';

  @override
  String get visiblePourTousAide => 'Anders alleen voor ingelogde gebruikers.';

  @override
  String get publier => 'Publiceren';

  @override
  String get publierAide => 'Uit: concept, alleen voor jou zichtbaar.';

  @override
  String get champOrdre => 'Volgorde';

  @override
  String get champOrdreAide =>
      'De dagelijkse overdenkingen volgen deze volgorde (1, 2, 3…).';

  @override
  String get enregistrer => 'Opslaan';

  @override
  String get enregistre => 'Opgeslagen';

  @override
  String get supprimerContenuTitre => 'Deze inhoud verwijderen?';

  @override
  String get supprimerContenuTexte =>
      'Het verdwijnt voor iedereen. Dit is definitief.';

  @override
  String get typeAudio => 'Audio';

  @override
  String get typeVideo => 'Video';

  @override
  String get lecture => 'Afspelen';

  @override
  String get pause => 'Pauze';

  @override
  String get reculer15 => '15 seconden terug';

  @override
  String get avancer15 => '15 seconden vooruit';

  @override
  String get vitesse => 'Afspeelsnelheid';

  @override
  String get pleinEcran => 'Volledig scherm';

  @override
  String get erreurLecture =>
      'Dit bestand kan niet worden afgespeeld. Controleer je verbinding.';

  @override
  String fichierMedia(String langue) {
    return 'Bestand ($langue)';
  }

  @override
  String get choisirFichier => 'Bestand kiezen';

  @override
  String get remplacerFichier => 'Vervangen';

  @override
  String get fichierAjoute => 'Bestand toegevoegd';

  @override
  String get aucunFichier => 'Geen bestand in deze taal.';

  @override
  String envoiEnCours(int pourcent) {
    return 'Uploaden… $pourcent%';
  }

  @override
  String get fichierRequis => 'Voeg minstens één bestand toe.';

  @override
  String get envoiEchoue => 'Uploaden mislukt. Probeer opnieuw.';

  @override
  String get champDescription => 'Beschrijving';

  @override
  String get changerPhoto => 'Profielfoto wijzigen';

  @override
  String get prendrePhoto => 'Foto maken';

  @override
  String get choisirGalerie => 'Kiezen uit galerij';

  @override
  String get supprimerPhoto => 'Foto verwijderen';

  @override
  String get photoEnvoiEchoue =>
      'De foto kon niet worden opgeslagen. Probeer opnieuw.';

  @override
  String get mesExercices => 'Mijn oefeningen';

  @override
  String exercicesAFaire(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n oefeningen te doen',
      one: '1 oefening te doen',
      zero: 'Geen oefeningen te doen',
    );
    return '$_temp0';
  }

  @override
  String get aucunExercice => 'Je coach heeft je nog geen oefeningen gestuurd.';

  @override
  String get exerciceFait => 'Klaar';

  @override
  String get exerciceAFaire => 'Te doen';

  @override
  String get modeSeul => 'Ieder apart';

  @override
  String get modeADeux => 'Samen te doen';

  @override
  String get modeSeulAide =>
      'Je antwoord is alleen zichtbaar voor jou en je coach.';

  @override
  String get modeADeuxAide =>
      'Eén gezamenlijk antwoord, samen geschreven, zichtbaar voor jullie beiden en je coach.';

  @override
  String aFaireAvant(String date) {
    return 'Te doen vóór $date';
  }

  @override
  String get lireAvant => 'Eerst lezen';

  @override
  String get maReponse => 'Mijn antwoord';

  @override
  String get notreReponse => 'Ons antwoord';

  @override
  String get enregistrerReponse => 'Mijn antwoord opslaan';

  @override
  String get reponseEnregistree =>
      'Antwoord opgeslagen. Je coach kan het lezen.';

  @override
  String get exercices => 'Oefeningen';

  @override
  String get envoyerExercice => 'Oefening sturen';

  @override
  String get apartirContenu => 'Vanuit een inhoud (optioneel)';

  @override
  String get aucunContenuLie => 'Geen';

  @override
  String get champConsignes => 'Instructies';

  @override
  String get echeance => 'Deadline (optioneel)';

  @override
  String get choisirDate => 'Datum kiezen';

  @override
  String get envoyer => 'Versturen';

  @override
  String get exerciceEnvoye => 'Oefening verstuurd.';

  @override
  String reponses(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n antwoorden',
      one: '1 antwoord',
      zero: 'Geen antwoorden',
    );
    return '$_temp0';
  }

  @override
  String get pasEncoreRepondu => 'Nog niet geantwoord.';

  @override
  String get reponseCommune => 'Gezamenlijk antwoord';

  @override
  String get supprimerExerciceTitre => 'Deze oefening verwijderen?';
}
