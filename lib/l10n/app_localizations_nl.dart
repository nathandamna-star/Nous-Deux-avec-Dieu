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

  @override
  String get parcours => 'Trajecten';

  @override
  String get aucunParcours => 'Nog geen trajecten.';

  @override
  String etapesFaites(int faits, int total) {
    return '$faits / $total stappen';
  }

  @override
  String etapeNumero(int n) {
    return 'Stap $n';
  }

  @override
  String get continuerParcours => 'Verdergaan';

  @override
  String get commencerParcours => 'Beginnen';

  @override
  String get parcoursTermine => 'Traject afgerond. Proficiat!';

  @override
  String get marquerFait => 'Markeren als klaar';

  @override
  String get etapeFaite => 'Stap klaar';

  @override
  String get connexionPourSuivre => 'Log in om je voortgang te volgen.';

  @override
  String get mesParcours => 'Mijn trajecten';

  @override
  String get nouveauParcours => 'Nieuw traject';

  @override
  String get modifierParcours => 'Traject bewerken';

  @override
  String get etapes => 'Stappen';

  @override
  String get ajouterEtape => 'Stap toevoegen';

  @override
  String get retirerEtape => 'Stap verwijderen';

  @override
  String get etapesRequises => 'Voeg minstens één stap toe.';

  @override
  String get choisirContenuEtape => 'Inhoud kiezen';

  @override
  String get supprimerParcoursTitre => 'Dit traject verwijderen?';

  @override
  String nbEtapes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n stappen',
      one: '1 stap',
    );
    return '$_temp0';
  }

  @override
  String get votreCoach => 'Je coach';

  @override
  String get messagesSansAccompagnement =>
      'Vraag eerst begeleiding aan via je profiel om je coach te schrijven.';

  @override
  String get aucunMessage => 'Nog geen berichten. Schrijf het eerste!';

  @override
  String get aucuneConversation => 'Nog geen gesprekken.';

  @override
  String get ecrireMessage => 'Bericht schrijven';

  @override
  String get envoyerMessage => 'Versturen';

  @override
  String get envoyerPhoto => 'Foto versturen';

  @override
  String get messageVocal => 'Spraakbericht';

  @override
  String enregistrementEnCours(String duree) {
    return 'Opnemen… $duree';
  }

  @override
  String get arreterEtEnvoyer => 'Stoppen en versturen';

  @override
  String get microRefuse =>
      'Toegang tot de microfoon is geweigerd. Sta dit toe in de instellingen van je telefoon.';

  @override
  String get envoiMessageEchoue =>
      'Het bericht kon niet worden verzonden. Probeer opnieuw.';

  @override
  String nonLus(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ongelezen berichten',
      one: '1 ongelezen bericht',
    );
    return '$_temp0';
  }

  @override
  String get rendezVous => 'Afspraken';

  @override
  String get prochainRendezVous => 'Volgende afspraak';

  @override
  String get aucunRendezVous =>
      'Nog geen afspraak gepland. Je coach stelt een datum voor.';

  @override
  String get seancesSansAccompagnement =>
      'Je afspraken verschijnen hier zodra je begeleiding is gestart.';

  @override
  String get planifierRendezVous => 'Afspraak plannen';

  @override
  String get modifierRendezVous => 'Afspraak wijzigen';

  @override
  String get champDate => 'Datum';

  @override
  String get champHeure => 'Tijd';

  @override
  String get champDuree => 'Duur';

  @override
  String dureeMinutes(int n) {
    return '$n min';
  }

  @override
  String get champLienZoom => 'Zoom-link';

  @override
  String get champLienZoomAide =>
      'Plak de link van de Zoom-vergadering (https://…)';

  @override
  String get lienZoomInvalide => 'Ongeldige link: moet beginnen met https://';

  @override
  String get rejoindreZoom => 'Deelnemen via Zoom';

  @override
  String get lienZoomAVenir => 'Je coach voegt de Zoom-link toe.';

  @override
  String get lienImpossible => 'Kan de link niet openen.';

  @override
  String get rdvEnCours => 'Bezig';

  @override
  String get rdvAnnule => 'Geannuleerd';

  @override
  String get rdvFait => 'Gedaan';

  @override
  String get rdvPasse => 'Voorbij';

  @override
  String get annulerRendezVous => 'Afspraak annuleren';

  @override
  String get confirmerAnnulationRdv =>
      'Deze afspraak annuleren? De begeleide personen worden verwittigd.';

  @override
  String get marquerSeanceFaite => 'Sessie gedaan (−1 sessie)';

  @override
  String get historique => 'Geschiedenis';

  @override
  String get aVenir => 'Gepland';

  @override
  String get agenda => 'Agenda';

  @override
  String get agendaVide => 'Geen geplande afspraken.';

  @override
  String get rappelsAutomatiques =>
      'Automatische herinnering de dag ervoor en 1 uur ervoor.';

  @override
  String get rendezVousEnregistre => 'Afspraak opgeslagen';

  @override
  String get dateDansLePasse => 'Kies een datum in de toekomst.';

  @override
  String get nonMerci => 'Nee';

  @override
  String get forfaits => 'Sessiepakketten';

  @override
  String get forfaitsAide =>
      'Betaal via overschrijving: de sessies worden toegevoegd zodra je coach de betaling heeft ontvangen.';

  @override
  String nbSeancesForfait(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessies',
      one: '1 sessie',
    );
    return '$_temp0';
  }

  @override
  String get choisir => 'Kiezen';

  @override
  String get mesPaiements => 'Mijn betalingen';

  @override
  String get paiementEnAttente => 'In afwachting';

  @override
  String get paiementRecu => 'Ontvangen';

  @override
  String get paiementAnnule => 'Geannuleerd';

  @override
  String get virementTitre => 'Betaling via overschrijving';

  @override
  String get virementAide =>
      'Scan de QR-code met je bankapp of neem de gegevens hieronder over. Vergeet de mededeling niet: daarmee wordt je betaling herkend.';

  @override
  String get montant => 'Bedrag';

  @override
  String get beneficiaire => 'Begunstigde';

  @override
  String get iban => 'IBAN';

  @override
  String get bic => 'BIC';

  @override
  String get communicationStructuree => 'Gestructureerde mededeling';

  @override
  String get coordonneesIndisponibles =>
      'De bankgegevens zijn nog niet beschikbaar. Schrijf je coach of probeer het later opnieuw.';

  @override
  String get paiementRecuMerci => 'Betaling ontvangen. Bedankt!';

  @override
  String get paiementAttenteAide =>
      'Je coach bevestigt de ontvangst van de overschrijving (meestal 1 à 2 werkdagen).';

  @override
  String get renoncerPaiement => 'Toch niet betalen';

  @override
  String get faireUnDon => 'Een gift doen';

  @override
  String get donAide =>
      'Je gift is vrij en steunt deze bediening. Er wordt niets mee ontgrendeld: alle inhoud blijft gratis voor iedereen.';

  @override
  String get autreMontant => 'Ander bedrag (€)';

  @override
  String get montantInvalide => 'Tussen 1 en 10 000 €';

  @override
  String get continuer => 'Doorgaan';

  @override
  String get don => 'Gift';

  @override
  String get paiementsCoach => 'Betalingen en giften';

  @override
  String get aucunPaiement => 'Geen betalingen.';

  @override
  String get confirmerReception => 'Betaling ontvangen';

  @override
  String confirmerReceptionTexte(String montant, String communication) {
    return 'Bevestig je dat je $montant hebt ontvangen met mededeling $communication? De sessies van het pakket worden automatisch toegevoegd.';
  }

  @override
  String totalRecuMois(String montant) {
    return 'Ontvangen deze maand: $montant';
  }

  @override
  String get nouveauForfait => 'Nieuw pakket';

  @override
  String get modifierForfait => 'Pakket wijzigen';

  @override
  String get aucunForfait =>
      'Geen pakketten. Maak er een aan zodat je cliënten hun sessies kunnen betalen.';

  @override
  String get champNomForfait => 'Naam';

  @override
  String get champNbSeances => 'Aantal sessies';

  @override
  String get champPrix => 'Prijs (€)';

  @override
  String get forfaitActif => 'Aangeboden aan cliënten';

  @override
  String get nombreInvalide => 'Ongeldig getal';

  @override
  String get parametresCoach => 'Coachinstellingen';

  @override
  String get parametresCoachAide =>
      'Deze gegevens worden getoond aan wie een pakket betaalt of een gift doet.';

  @override
  String get champNomAffiche => 'Weergavenaam';

  @override
  String get champTitulaire => 'Rekeninghouder';

  @override
  String get champBicAide => 'Optioneel';

  @override
  String get ibanInvalide => 'Ongeldig IBAN: controleer de cijfers';

  @override
  String get bicInvalide => 'Ongeldige BIC (8 of 11 tekens)';

  @override
  String get champMessageDon => 'Bedankbericht voor giften';

  @override
  String get plus => 'Meer';

  @override
  String get mesLivres => 'Mijn boeken';

  @override
  String get mesLivresAide => 'De boeken van je coach';

  @override
  String get aucunLivre => 'Nog geen boeken.';

  @override
  String get formatPapier => 'Papier';

  @override
  String get formatNumerique => 'E-book';

  @override
  String get formatAudio => 'Luisterboek';

  @override
  String disponibleEn(String langues) {
    return 'Beschikbaar in: $langues';
  }

  @override
  String acheterSur(String boutique) {
    return 'Kopen bij $boutique';
  }

  @override
  String get lireExtrait => 'Fragment lezen';

  @override
  String get commanderAuCoach => 'Bestellen bij de coach';

  @override
  String get commanderAuCoachAide =>
      'Papieren boek per post verzonden, betaald via overschrijving.';

  @override
  String get quantite => 'Aantal';

  @override
  String get fraisEnvoi => 'Verzendkosten';

  @override
  String get total => 'Totaal';

  @override
  String get adresseLivraison => 'Leveringsadres';

  @override
  String get champRue => 'Straat en nummer';

  @override
  String get champCodePostal => 'Postcode';

  @override
  String get champVille => 'Stad';

  @override
  String get champPays => 'Land';

  @override
  String get commander => 'Bestellen';

  @override
  String get commandeLivre => 'Boekbestelling';

  @override
  String get mesCommandes => 'Mijn bestellingen';

  @override
  String get commandeEnAttente => 'Wacht op betaling';

  @override
  String get commandePayee => 'Betaald';

  @override
  String get commandeEnvoyee => 'Verzonden';

  @override
  String get commandeAnnulee => 'Geannuleerd';

  @override
  String get commandePayeeAide =>
      'Betaling ontvangen: je boek wordt zeer binnenkort verzonden.';

  @override
  String get commandeEnvoyeeAide => 'Je boek is onderweg. Veel leesplezier!';

  @override
  String get numeroSuivi => 'Trackingnummer';

  @override
  String get renoncerCommande => 'Bestelling annuleren';

  @override
  String get livresCoach => 'Boeken';

  @override
  String get commandesLivres => 'Bestellingen';

  @override
  String get aucuneCommande => 'Geen bestellingen.';

  @override
  String get nouveauLivre => 'Nieuw boek';

  @override
  String get modifierLivre => 'Boek wijzigen';

  @override
  String get couverture => 'Omslag';

  @override
  String get choisirCouverture => 'Afbeelding kiezen';

  @override
  String get champSousTitre => 'Ondertitel';

  @override
  String get languesDuLivre => 'Talen van het boek';

  @override
  String get formatsEtPrix => 'Formaten en prijzen (€)';

  @override
  String get liensAchat => 'Aankooplinks';

  @override
  String get nomBoutique => 'Winkel (bv. Amazon)';

  @override
  String get adresseLien => 'Adres (https://…)';

  @override
  String get ajouterLien => 'Link toevoegen';

  @override
  String get lienInvalide => 'Ongeldig adres: moet beginnen met https://';

  @override
  String get commandeDirecteOption =>
      'Rechtstreekse bestelling van het papieren boek';

  @override
  String get commandeDirecteAide =>
      'Lezers bestellen het boek bij jou en betalen via overschrijving; jij verstuurt het per post.';

  @override
  String get champExtrait => 'Link naar een fragment (optioneel)';

  @override
  String get publierLivre => 'Gepubliceerd';

  @override
  String get prixPapierRequis => 'Geef de prijs van het papieren boek op';

  @override
  String get marquerPayee => 'Betaling ontvangen';

  @override
  String get marquerEnvoyee => 'Markeren als verzonden';

  @override
  String get aTraiter => 'Te verwerken';
}
