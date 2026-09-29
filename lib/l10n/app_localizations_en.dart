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
  String get seancesAVenir =>
      'Here: your appointments, remaining sessions and packages.';

  @override
  String get profilAVenir =>
      'Here: your language, your spouse, donations and your data.';

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

  @override
  String get monAccompagnement => 'My coaching';

  @override
  String get demanderAccompagnement => 'Request coaching';

  @override
  String get demanderAccompagnementAide =>
      'Your coach will reply to arrange a first appointment.';

  @override
  String get jAiUnCode => 'I have a code from my spouse';

  @override
  String get typeCouple => 'As a couple';

  @override
  String get typeIndividuel => 'Alone';

  @override
  String get champNomAccompagnement => 'Display name';

  @override
  String get champNomAccompagnementAide => 'For example “Paul & Marie”';

  @override
  String get champMessage => 'Your message to the coach (optional)';

  @override
  String get champMessageAide =>
      'What you are going through, what you hope for…';

  @override
  String get envoyerDemande => 'Send my request';

  @override
  String get demandeEnvoyee => 'Request sent. Your coach will reply soon.';

  @override
  String get champObligatoire => 'This field is required.';

  @override
  String get rejoindreTitre => 'Join my spouse';

  @override
  String get rejoindreAide =>
      'Enter the 6-character code your spouse sees in their profile.';

  @override
  String get champCode => 'Invitation code';

  @override
  String get rejoindre => 'Join';

  @override
  String get codeInvalide =>
      'This code is not valid, or the couple is already complete.';

  @override
  String codePourConjoint(String code) {
    return 'Code for your spouse: $code';
  }

  @override
  String get codePourConjointAide =>
      'Your spouse creates an account, then chooses “I have a code from my spouse”.';

  @override
  String get copier => 'Copy';

  @override
  String get copie => 'Copied';

  @override
  String get statutDemande => 'Request pending';

  @override
  String get statutActif => 'Coaching in progress';

  @override
  String get statutEnPause => 'Paused';

  @override
  String get statutTermine => 'Completed';

  @override
  String seancesRestantes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessions left',
      one: '1 session left',
      zero: 'No sessions left',
    );
    return '$_temp0';
  }

  @override
  String get attendConjoint => 'Waiting for spouse';

  @override
  String get filtreDemandes => 'Requests';

  @override
  String get filtreActifs => 'Active';

  @override
  String get filtreTermines => 'Completed';

  @override
  String get aucunAccompagnement => 'No coaching here yet.';

  @override
  String get membres => 'Members';

  @override
  String get messageDemande => 'Request message';

  @override
  String get accepter => 'Accept';

  @override
  String get mettreEnPause => 'Pause';

  @override
  String get reprendre => 'Resume';

  @override
  String get terminer => 'Complete';

  @override
  String get seances => 'Sessions';

  @override
  String get retirerSeance => 'Remove a session';

  @override
  String get ajouterSeance => 'Add a session';

  @override
  String get notesPrivees => 'Private notes';

  @override
  String get notesPriveesAide => 'Visible only to you.';

  @override
  String get nouvelleNote => 'New note';

  @override
  String get ajouter => 'Add';

  @override
  String get supprimer => 'Delete';

  @override
  String get aucuneNote => 'No notes yet.';

  @override
  String get activerCoachTitre => 'Activate the coach space?';

  @override
  String get activerCoachTexte =>
      'Reserved for the coach: only the account set up at launch can activate it.';

  @override
  String get coachActive => 'Coach space activated.';

  @override
  String get coachRefuse => 'This account cannot become the coach.';

  @override
  String get annuler => 'Cancel';

  @override
  String get valider => 'Confirm';

  @override
  String get typeMeditation => 'Meditation';

  @override
  String get typeQuestion => 'Question for two';

  @override
  String get typeExercice => 'Exercise';

  @override
  String get typeArticle => 'Article';

  @override
  String get tous => 'All';

  @override
  String get themeCommunication => 'Communication';

  @override
  String get themePardon => 'Forgiveness';

  @override
  String get themeFinances => 'Finances';

  @override
  String get themeIntimite => 'Intimacy';

  @override
  String get themePriere => 'Prayer';

  @override
  String get themeEnfants => 'Children';

  @override
  String get themeFiancailles => 'Engagement';

  @override
  String get themeGratitude => 'Gratitude';

  @override
  String get meditationDuJour => 'Today\'s meditation';

  @override
  String get lire => 'Read';

  @override
  String get decouvrirContenus => 'Explore all content';

  @override
  String get aucunContenu => 'No content yet. Come back soon!';

  @override
  String get autreLangue => 'Not yet translated into your language.';

  @override
  String get accueilBienvenue => 'May the peace of God guard your hearts.';

  @override
  String get mesContenus => 'My content';

  @override
  String get nouveauContenu => 'New content';

  @override
  String get modifierContenu => 'Edit content';

  @override
  String get brouillon => 'Draft';

  @override
  String get publie => 'Published';

  @override
  String get champType => 'Type';

  @override
  String get champTheme => 'Theme';

  @override
  String get champTitre => 'Title';

  @override
  String get champTexte => 'Text';

  @override
  String get champReference => 'Bible reference (optional)';

  @override
  String get champReferenceAide => 'e.g. Ephesians 4:2';

  @override
  String get langueVersion => 'Version';

  @override
  String get titreFrancaisRequis => 'The French title is required.';

  @override
  String get visiblePourTous => 'Visible without an account';

  @override
  String get visiblePourTousAide => 'Otherwise, only for signed-in users.';

  @override
  String get publier => 'Publish';

  @override
  String get publierAide => 'Off: draft, visible only to you.';

  @override
  String get champOrdre => 'Display order';

  @override
  String get champOrdreAide =>
      'Daily meditations follow this order (1, 2, 3…).';

  @override
  String get enregistrer => 'Save';

  @override
  String get enregistre => 'Saved';

  @override
  String get supprimerContenuTitre => 'Delete this content?';

  @override
  String get supprimerContenuTexte =>
      'It will disappear for everyone. This cannot be undone.';

  @override
  String get typeAudio => 'Audio';

  @override
  String get typeVideo => 'Video';

  @override
  String get lecture => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get reculer15 => 'Back 15 seconds';

  @override
  String get avancer15 => 'Forward 15 seconds';

  @override
  String get vitesse => 'Playback speed';

  @override
  String get pleinEcran => 'Full screen';

  @override
  String get erreurLecture =>
      'This file can\'t be played. Check your connection.';

  @override
  String fichierMedia(String langue) {
    return 'File ($langue)';
  }

  @override
  String get choisirFichier => 'Choose the file';

  @override
  String get remplacerFichier => 'Replace';

  @override
  String get fichierAjoute => 'File added';

  @override
  String get aucunFichier => 'No file in this language.';

  @override
  String envoiEnCours(int pourcent) {
    return 'Uploading… $pourcent%';
  }

  @override
  String get fichierRequis => 'Add at least one file.';

  @override
  String get envoiEchoue => 'The upload failed. Please try again.';

  @override
  String get champDescription => 'Description';

  @override
  String get changerPhoto => 'Change profile photo';

  @override
  String get prendrePhoto => 'Take a photo';

  @override
  String get choisirGalerie => 'Choose from gallery';

  @override
  String get supprimerPhoto => 'Remove photo';

  @override
  String get photoEnvoiEchoue =>
      'The photo could not be saved. Please try again.';

  @override
  String get mesExercices => 'My exercises';

  @override
  String exercicesAFaire(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n exercises to do',
      one: '1 exercise to do',
      zero: 'No exercises to do',
    );
    return '$_temp0';
  }

  @override
  String get aucunExercice => 'Your coach hasn\'t sent you any exercises yet.';

  @override
  String get exerciceFait => 'Done';

  @override
  String get exerciceAFaire => 'To do';

  @override
  String get modeSeul => 'Each on your own';

  @override
  String get modeADeux => 'To do together';

  @override
  String get modeSeulAide => 'Your answer is seen only by you and your coach.';

  @override
  String get modeADeuxAide =>
      'One shared answer, written together, visible to both of you and your coach.';

  @override
  String aFaireAvant(String date) {
    return 'To do before $date';
  }

  @override
  String get lireAvant => 'Read first';

  @override
  String get maReponse => 'My answer';

  @override
  String get notreReponse => 'Our answer';

  @override
  String get enregistrerReponse => 'Save my answer';

  @override
  String get reponseEnregistree =>
      'Answer saved. Your coach will be able to read it.';

  @override
  String get exercices => 'Exercises';

  @override
  String get envoyerExercice => 'Send an exercise';

  @override
  String get apartirContenu => 'From a content item (optional)';

  @override
  String get aucunContenuLie => 'None';

  @override
  String get champConsignes => 'Instructions';

  @override
  String get echeance => 'Deadline (optional)';

  @override
  String get choisirDate => 'Choose a date';

  @override
  String get envoyer => 'Send';

  @override
  String get exerciceEnvoye => 'Exercise sent.';

  @override
  String reponses(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n answers',
      one: '1 answer',
      zero: 'No answers',
    );
    return '$_temp0';
  }

  @override
  String get pasEncoreRepondu => 'Not answered yet.';

  @override
  String get reponseCommune => 'Shared answer';

  @override
  String get supprimerExerciceTitre => 'Delete this exercise?';

  @override
  String get parcours => 'Programmes';

  @override
  String get aucunParcours => 'No programmes yet.';

  @override
  String etapesFaites(int faits, int total) {
    return '$faits / $total steps';
  }

  @override
  String etapeNumero(int n) {
    return 'Step $n';
  }

  @override
  String get continuerParcours => 'Continue';

  @override
  String get commencerParcours => 'Start';

  @override
  String get parcoursTermine => 'Programme completed. Well done!';

  @override
  String get marquerFait => 'Mark as done';

  @override
  String get etapeFaite => 'Step done';

  @override
  String get connexionPourSuivre => 'Sign in to track your progress.';

  @override
  String get mesParcours => 'My programmes';

  @override
  String get nouveauParcours => 'New programme';

  @override
  String get modifierParcours => 'Edit programme';

  @override
  String get etapes => 'Steps';

  @override
  String get ajouterEtape => 'Add a step';

  @override
  String get retirerEtape => 'Remove step';

  @override
  String get etapesRequises => 'Add at least one step.';

  @override
  String get choisirContenuEtape => 'Choose a content item';

  @override
  String get supprimerParcoursTitre => 'Delete this programme?';

  @override
  String nbEtapes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n steps',
      one: '1 step',
    );
    return '$_temp0';
  }

  @override
  String get votreCoach => 'Your coach';

  @override
  String get messagesSansAccompagnement =>
      'To write to your coach, first request coaching from your profile.';

  @override
  String get aucunMessage => 'No messages yet. Write the first one!';

  @override
  String get aucuneConversation => 'No conversations yet.';

  @override
  String get ecrireMessage => 'Write a message';

  @override
  String get envoyerMessage => 'Send';

  @override
  String get envoyerPhoto => 'Send a photo';

  @override
  String get messageVocal => 'Voice message';

  @override
  String enregistrementEnCours(String duree) {
    return 'Recording… $duree';
  }

  @override
  String get arreterEtEnvoyer => 'Stop and send';

  @override
  String get microRefuse =>
      'Microphone access is denied. Allow it in your phone\'s Settings.';

  @override
  String get envoiMessageEchoue =>
      'The message could not be sent. Please try again.';

  @override
  String nonLus(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n unread messages',
      one: '1 unread message',
    );
    return '$_temp0';
  }

  @override
  String get rendezVous => 'Appointments';

  @override
  String get prochainRendezVous => 'Next appointment';

  @override
  String get aucunRendezVous =>
      'No appointment scheduled yet. Your coach will suggest a date.';

  @override
  String get seancesSansAccompagnement =>
      'Your appointments will appear here once your coaching has started.';

  @override
  String get planifierRendezVous => 'Schedule an appointment';

  @override
  String get modifierRendezVous => 'Edit appointment';

  @override
  String get champDate => 'Date';

  @override
  String get champHeure => 'Time';

  @override
  String get champDuree => 'Duration';

  @override
  String dureeMinutes(int n) {
    return '$n min';
  }

  @override
  String get champLienZoom => 'Zoom link';

  @override
  String get champLienZoomAide => 'Paste the Zoom meeting link (https://…)';

  @override
  String get lienZoomInvalide => 'Invalid link: it must start with https://';

  @override
  String get rejoindreZoom => 'Join on Zoom';

  @override
  String get lienZoomAVenir => 'Your coach will add the Zoom link.';

  @override
  String get lienImpossible => 'Unable to open the link.';

  @override
  String get rdvEnCours => 'In progress';

  @override
  String get rdvAnnule => 'Cancelled';

  @override
  String get rdvFait => 'Done';

  @override
  String get rdvPasse => 'Past';

  @override
  String get annulerRendezVous => 'Cancel appointment';

  @override
  String get confirmerAnnulationRdv =>
      'Cancel this appointment? The people you coach will be notified.';

  @override
  String get marquerSeanceFaite => 'Session done (−1 session)';

  @override
  String get historique => 'History';

  @override
  String get aVenir => 'Upcoming';

  @override
  String get agenda => 'Calendar';

  @override
  String get agendaVide => 'No upcoming appointments.';

  @override
  String get rappelsAutomatiques =>
      'Automatic reminder the day before and 1 hour before.';

  @override
  String get rendezVousEnregistre => 'Appointment saved';

  @override
  String get dateDansLePasse => 'Choose a future date.';

  @override
  String get nonMerci => 'No';

  @override
  String get forfaits => 'Session packages';

  @override
  String get forfaitsAide =>
      'Pay by bank transfer: sessions are added as soon as your coach has received the payment.';

  @override
  String nbSeancesForfait(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessions',
      one: '1 session',
    );
    return '$_temp0';
  }

  @override
  String get choisir => 'Choose';

  @override
  String get mesPaiements => 'My payments';

  @override
  String get paiementEnAttente => 'Pending';

  @override
  String get paiementRecu => 'Received';

  @override
  String get paiementAnnule => 'Cancelled';

  @override
  String get virementTitre => 'Bank transfer';

  @override
  String get virementAide =>
      'Scan the QR code with your banking app, or copy the details below. Don\'t forget the reference: it identifies your payment.';

  @override
  String get montant => 'Amount';

  @override
  String get beneficiaire => 'Beneficiary';

  @override
  String get iban => 'IBAN';

  @override
  String get bic => 'BIC';

  @override
  String get communicationStructuree => 'Structured reference';

  @override
  String get coordonneesIndisponibles =>
      'Bank details are not available yet. Write to your coach or try again later.';

  @override
  String get paiementRecuMerci => 'Payment received. Thank you!';

  @override
  String get paiementAttenteAide =>
      'Your coach will confirm receipt of the transfer (usually 1 to 2 working days).';

  @override
  String get renoncerPaiement => 'Cancel this payment';

  @override
  String get faireUnDon => 'Make a gift';

  @override
  String get donAide =>
      'Your gift is free and supports this ministry. It does not unlock anything: all content stays free for everyone.';

  @override
  String get autreMontant => 'Other amount (€)';

  @override
  String get montantInvalide => 'Between €1 and €10,000';

  @override
  String get continuer => 'Continue';

  @override
  String get don => 'Gift';

  @override
  String get paiementsCoach => 'Payments and gifts';

  @override
  String get aucunPaiement => 'No payments.';

  @override
  String get confirmerReception => 'Payment received';

  @override
  String confirmerReceptionTexte(String montant, String communication) {
    return 'Do you confirm you received $montant with reference $communication? The package sessions will be added automatically.';
  }

  @override
  String totalRecuMois(String montant) {
    return 'Received this month: $montant';
  }

  @override
  String get nouveauForfait => 'New package';

  @override
  String get modifierForfait => 'Edit package';

  @override
  String get aucunForfait =>
      'No packages. Create one so your clients can pay for their sessions.';

  @override
  String get champNomForfait => 'Name';

  @override
  String get champNbSeances => 'Number of sessions';

  @override
  String get champPrix => 'Price (€)';

  @override
  String get forfaitActif => 'Offered to clients';

  @override
  String get nombreInvalide => 'Invalid number';

  @override
  String get parametresCoach => 'Coach settings';

  @override
  String get parametresCoachAide =>
      'These details are shown to people who pay for a package or make a gift.';

  @override
  String get champNomAffiche => 'Display name';

  @override
  String get champTitulaire => 'Account holder';

  @override
  String get champBicAide => 'Optional';

  @override
  String get ibanInvalide => 'Invalid IBAN: check the digits';

  @override
  String get bicInvalide => 'Invalid BIC (8 or 11 characters)';

  @override
  String get champMessageDon => 'Thank-you message for gifts';

  @override
  String get plus => 'More';

  @override
  String get mesLivres => 'My books';

  @override
  String get mesLivresAide => 'Your coach\'s books';

  @override
  String get aucunLivre => 'No books yet.';

  @override
  String get formatPapier => 'Paperback';

  @override
  String get formatNumerique => 'E-book';

  @override
  String get formatAudio => 'Audiobook';

  @override
  String disponibleEn(String langues) {
    return 'Available in: $langues';
  }

  @override
  String acheterSur(String boutique) {
    return 'Buy on $boutique';
  }

  @override
  String get lireExtrait => 'Read an excerpt';

  @override
  String get commanderAuCoach => 'Order from the coach';

  @override
  String get commanderAuCoachAide =>
      'Paperback sent by post, paid by bank transfer.';

  @override
  String get quantite => 'Quantity';

  @override
  String get fraisEnvoi => 'Shipping';

  @override
  String get total => 'Total';

  @override
  String get adresseLivraison => 'Delivery address';

  @override
  String get champRue => 'Street and number';

  @override
  String get champCodePostal => 'Postcode';

  @override
  String get champVille => 'City';

  @override
  String get champPays => 'Country';

  @override
  String get commander => 'Order';

  @override
  String get commandeLivre => 'Book order';

  @override
  String get mesCommandes => 'My orders';

  @override
  String get commandeEnAttente => 'Awaiting payment';

  @override
  String get commandePayee => 'Paid';

  @override
  String get commandeEnvoyee => 'Sent';

  @override
  String get commandeAnnulee => 'Cancelled';

  @override
  String get commandePayeeAide =>
      'Payment received: your book will be sent very soon.';

  @override
  String get commandeEnvoyeeAide => 'Your book is on its way. Enjoy reading!';

  @override
  String get numeroSuivi => 'Tracking number';

  @override
  String get renoncerCommande => 'Cancel the order';

  @override
  String get livresCoach => 'Books';

  @override
  String get commandesLivres => 'Orders';

  @override
  String get aucuneCommande => 'No orders.';

  @override
  String get nouveauLivre => 'New book';

  @override
  String get modifierLivre => 'Edit book';

  @override
  String get couverture => 'Cover';

  @override
  String get choisirCouverture => 'Choose an image';

  @override
  String get champSousTitre => 'Subtitle';

  @override
  String get languesDuLivre => 'Book languages';

  @override
  String get formatsEtPrix => 'Formats and prices (€)';

  @override
  String get liensAchat => 'Purchase links';

  @override
  String get nomBoutique => 'Shop (e.g. Amazon)';

  @override
  String get adresseLien => 'Address (https://…)';

  @override
  String get ajouterLien => 'Add a link';

  @override
  String get lienInvalide => 'Invalid address: it must start with https://';

  @override
  String get commandeDirecteOption => 'Direct order of the paperback';

  @override
  String get commandeDirecteAide =>
      'Readers order the book from you and pay by transfer; you send it by post.';

  @override
  String get champExtrait => 'Link to an excerpt (optional)';

  @override
  String get publierLivre => 'Published';

  @override
  String get prixPapierRequis => 'Enter the paperback price';

  @override
  String get marquerPayee => 'Payment received';

  @override
  String get marquerEnvoyee => 'Mark as sent';

  @override
  String get aTraiter => 'To do';

  @override
  String get cgu => 'Terms of use';

  @override
  String get confidentialite => 'Privacy';

  @override
  String get aideContact => 'Help and contact';

  @override
  String get legalEnFrancais =>
      'This page is currently available in French only.';

  @override
  String get langueApp => 'App language';

  @override
  String get langueTelephone => 'Phone language';

  @override
  String get mesDonnees => 'My data';

  @override
  String get telechargerMesDonnees => 'Download my data';

  @override
  String get exportEchoue =>
      'Export failed. Check your connection and try again.';

  @override
  String get supprimerMonCompte => 'Delete my account';

  @override
  String get supprimerCompteTexte =>
      'Your account, messages, answers and progress will be permanently deleted. If you are coached as a couple, your spouse keeps the coaching. Payments are kept without your name for accounting. This cannot be undone.';

  @override
  String get supprimerDefinitivement => 'Delete permanently';

  @override
  String get compteSupprime => 'Your account has been deleted.';

  @override
  String get erreurCommandeEnCours =>
      'A paid book has not been sent yet: try again once you have received it.';

  @override
  String get erreurCompteCoach =>
      'The coach account cannot be deleted from the app.';

  @override
  String get presentationCoach => 'My introduction';

  @override
  String get presentationCoachAide =>
      'Visible to everyone on the home screen, with your display name and profile photo.';

  @override
  String get champBio => 'Introduction';

  @override
  String get informationsLegales => 'Information';

  @override
  String get contenusDepart => 'Starter content';

  @override
  String get contenusDepartAide =>
      'Adds 30 meditations, 60 questions to discuss as a couple and 4 paths, in all 5 languages, already published. You can edit, unpublish or delete everything. Your existing content is never replaced.';

  @override
  String get charger => 'Load';

  @override
  String contenusDepartAjoutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n items added.',
      one: '1 item added.',
      zero: 'Everything was already there: nothing to add.',
    );
    return '$_temp0';
  }

  @override
  String get boutique => 'Shop';

  @override
  String get ajouterArticle => 'Add an item';

  @override
  String get nouvelArticle => 'New item';

  @override
  String get categorieLivre => 'Book';

  @override
  String get categorieAutre => 'Other item';

  @override
  String get categorieLivres => 'Books';

  @override
  String get categorieAutres => 'Other items';

  @override
  String get articleAutreAide =>
      'Physical item (CD, planner, card, clothing…). A digital item can only be sold through a link to an outside shop.';

  @override
  String get ajouterAudioVideo => 'Add audio or video';
}
