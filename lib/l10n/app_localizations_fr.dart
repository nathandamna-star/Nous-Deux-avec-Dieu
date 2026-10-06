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
  String get seancesAVenir =>
      'Ici : vos rendez-vous, vos séances restantes et les forfaits.';

  @override
  String get profilAVenir =>
      'Ici : votre langue, votre conjoint, les dons et vos données.';

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

  @override
  String get monAccompagnement => 'Mon accompagnement';

  @override
  String get demanderAccompagnement => 'Demander un accompagnement';

  @override
  String get demanderAccompagnementAide =>
      'Votre coach vous répondra pour convenir d\'un premier rendez-vous.';

  @override
  String get jAiUnCode => 'J\'ai un code de mon conjoint';

  @override
  String get typeCouple => 'En couple';

  @override
  String get typeIndividuel => 'Seul(e)';

  @override
  String get champNomAccompagnement => 'Nom affiché';

  @override
  String get champNomAccompagnementAide => 'Par exemple « Paul & Marie »';

  @override
  String get champMessage => 'Votre message au coach (facultatif)';

  @override
  String get champMessageAide => 'Ce que vous vivez, ce que vous espérez…';

  @override
  String get envoyerDemande => 'Envoyer ma demande';

  @override
  String get demandeEnvoyee =>
      'Demande envoyée. Votre coach vous répondra bientôt.';

  @override
  String get champObligatoire => 'Ce champ est obligatoire.';

  @override
  String get rejoindreTitre => 'Rejoindre mon conjoint';

  @override
  String get rejoindreAide =>
      'Saisissez le code à 6 caractères que votre conjoint voit dans son profil.';

  @override
  String get champCode => 'Code d\'invitation';

  @override
  String get rejoindre => 'Rejoindre';

  @override
  String get codeInvalide =>
      'Ce code n\'est pas valable, ou le couple est déjà complet.';

  @override
  String codePourConjoint(String code) {
    return 'Code pour votre conjoint : $code';
  }

  @override
  String get codePourConjointAide =>
      'Votre conjoint crée son compte, puis choisit « J\'ai un code de mon conjoint ».';

  @override
  String get copier => 'Copier';

  @override
  String get copie => 'Copié';

  @override
  String get statutDemande => 'Demande en attente';

  @override
  String get statutActif => 'Accompagnement en cours';

  @override
  String get statutEnPause => 'En pause';

  @override
  String get statutTermine => 'Terminé';

  @override
  String seancesRestantes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n séances restantes',
      one: '1 séance restante',
      zero: 'Aucune séance restante',
    );
    return '$_temp0';
  }

  @override
  String get attendConjoint => 'En attente du conjoint';

  @override
  String get filtreDemandes => 'Demandes';

  @override
  String get filtreActifs => 'En cours';

  @override
  String get filtreTermines => 'Terminés';

  @override
  String get aucunAccompagnement => 'Aucun accompagnement ici pour l\'instant.';

  @override
  String get membres => 'Membres';

  @override
  String get messageDemande => 'Message de la demande';

  @override
  String get accepter => 'Accepter';

  @override
  String get mettreEnPause => 'Mettre en pause';

  @override
  String get reprendre => 'Reprendre';

  @override
  String get terminer => 'Terminer';

  @override
  String get seances => 'Séances';

  @override
  String get retirerSeance => 'Retirer une séance';

  @override
  String get ajouterSeance => 'Ajouter une séance';

  @override
  String get notesPrivees => 'Notes privées';

  @override
  String get notesPriveesAide => 'Visibles par vous seul.';

  @override
  String get nouvelleNote => 'Nouvelle note';

  @override
  String get ajouter => 'Ajouter';

  @override
  String get supprimer => 'Supprimer';

  @override
  String get aucuneNote => 'Aucune note pour l\'instant.';

  @override
  String get activerCoachTitre => 'Activer l\'espace coach ?';

  @override
  String get activerCoachTexte =>
      'Réservé au coach : seul le compte désigné lors de la mise en service peut l\'activer.';

  @override
  String get coachActive => 'Espace coach activé.';

  @override
  String get coachRefuse => 'Ce compte ne peut pas devenir coach.';

  @override
  String get annuler => 'Annuler';

  @override
  String get valider => 'Valider';

  @override
  String get typeMeditation => 'Méditation';

  @override
  String get typeQuestion => 'Question à deux';

  @override
  String get typeExercice => 'Exercice';

  @override
  String get typeArticle => 'Article';

  @override
  String get tous => 'Tous';

  @override
  String get themeCommunication => 'Communication';

  @override
  String get themePardon => 'Pardon';

  @override
  String get themeFinances => 'Finances';

  @override
  String get themeIntimite => 'Intimité';

  @override
  String get themePriere => 'Prière';

  @override
  String get themeEnfants => 'Enfants';

  @override
  String get themeFiancailles => 'Fiançailles';

  @override
  String get themeGratitude => 'Gratitude';

  @override
  String get meditationDuJour => 'Méditation du jour';

  @override
  String get lire => 'Lire';

  @override
  String get decouvrirContenus => 'Découvrir tous les contenus';

  @override
  String get aucunContenu => 'Aucun contenu pour l\'instant. Revenez bientôt !';

  @override
  String get autreLangue => 'Pas encore traduit dans votre langue.';

  @override
  String get accueilBienvenue => 'Que la paix de Dieu garde vos cœurs.';

  @override
  String get mesContenus => 'Mes contenus';

  @override
  String get nouveauContenu => 'Nouveau contenu';

  @override
  String get modifierContenu => 'Modifier le contenu';

  @override
  String get brouillon => 'Brouillon';

  @override
  String get publie => 'Publié';

  @override
  String get champType => 'Type';

  @override
  String get champTheme => 'Thème';

  @override
  String get champTitre => 'Titre';

  @override
  String get champTexte => 'Texte';

  @override
  String get champReference => 'Référence biblique (facultatif)';

  @override
  String get champReferenceAide => 'Ex. Éphésiens 4:2';

  @override
  String get langueVersion => 'Version';

  @override
  String get titreFrancaisRequis => 'Le titre en français est obligatoire.';

  @override
  String get visiblePourTous => 'Visible sans compte';

  @override
  String get visiblePourTousAide =>
      'Sinon, seulement pour les personnes connectées.';

  @override
  String get publier => 'Publier';

  @override
  String get publierAide => 'Désactivé : brouillon, visible par vous seul.';

  @override
  String get champOrdre => 'Ordre d\'affichage';

  @override
  String get champOrdreAide =>
      'Les méditations du jour suivent cet ordre (1, 2, 3…).';

  @override
  String get enregistrer => 'Enregistrer';

  @override
  String get enregistre => 'Enregistré';

  @override
  String get supprimerContenuTitre => 'Supprimer ce contenu ?';

  @override
  String get supprimerContenuTexte =>
      'Il disparaîtra pour tout le monde. C\'est définitif.';

  @override
  String get typeAudio => 'Audio';

  @override
  String get typeVideo => 'Vidéo';

  @override
  String get lecture => 'Lecture';

  @override
  String get pause => 'Pause';

  @override
  String get reculer15 => 'Reculer de 15 secondes';

  @override
  String get avancer15 => 'Avancer de 15 secondes';

  @override
  String get vitesse => 'Vitesse de lecture';

  @override
  String get pleinEcran => 'Plein écran';

  @override
  String get erreurLecture =>
      'Impossible de lire ce fichier. Vérifiez votre connexion.';

  @override
  String fichierMedia(String langue) {
    return 'Fichier ($langue)';
  }

  @override
  String get choisirFichier => 'Choisir le fichier';

  @override
  String get remplacerFichier => 'Remplacer';

  @override
  String get fichierAjoute => 'Fichier ajouté';

  @override
  String get aucunFichier => 'Aucun fichier dans cette langue.';

  @override
  String envoiEnCours(int pourcent) {
    return 'Envoi en cours… $pourcent %';
  }

  @override
  String get fichierRequis => 'Ajoutez au moins un fichier.';

  @override
  String get envoiEchoue => 'L\'envoi du fichier a échoué. Réessayez.';

  @override
  String get champDescription => 'Description';

  @override
  String get changerPhoto => 'Changer la photo de profil';

  @override
  String get prendrePhoto => 'Prendre une photo';

  @override
  String get choisirGalerie => 'Choisir dans la galerie';

  @override
  String get supprimerPhoto => 'Supprimer la photo';

  @override
  String get photoEnvoiEchoue =>
      'La photo n\'a pas pu être enregistrée. Réessayez.';

  @override
  String get mesExercices => 'Mes exercices';

  @override
  String exercicesAFaire(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n exercices à faire',
      one: '1 exercice à faire',
      zero: 'Aucun exercice à faire',
    );
    return '$_temp0';
  }

  @override
  String get aucunExercice =>
      'Votre coach ne vous a pas encore envoyé d\'exercice.';

  @override
  String get exerciceFait => 'Fait';

  @override
  String get exerciceAFaire => 'À faire';

  @override
  String get modeSeul => 'Chacun de votre côté';

  @override
  String get modeADeux => 'À faire à deux';

  @override
  String get modeSeulAide =>
      'Votre réponse est vue seulement par vous et votre coach.';

  @override
  String get modeADeuxAide =>
      'Une réponse commune, écrite ensemble, visible par vous deux et votre coach.';

  @override
  String aFaireAvant(String date) {
    return 'À faire avant le $date';
  }

  @override
  String get lireAvant => 'À lire avant';

  @override
  String get maReponse => 'Ma réponse';

  @override
  String get notreReponse => 'Notre réponse';

  @override
  String get enregistrerReponse => 'Enregistrer ma réponse';

  @override
  String get reponseEnregistree =>
      'Réponse enregistrée. Votre coach pourra la lire.';

  @override
  String get exercices => 'Exercices';

  @override
  String get envoyerExercice => 'Envoyer un exercice';

  @override
  String get apartirContenu => 'À partir d\'un contenu (facultatif)';

  @override
  String get aucunContenuLie => 'Aucun';

  @override
  String get champConsignes => 'Consignes';

  @override
  String get echeance => 'Date limite (facultatif)';

  @override
  String get choisirDate => 'Choisir une date';

  @override
  String get envoyer => 'Envoyer';

  @override
  String get exerciceEnvoye => 'Exercice envoyé.';

  @override
  String reponses(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n réponses',
      one: '1 réponse',
      zero: 'Aucune réponse',
    );
    return '$_temp0';
  }

  @override
  String get pasEncoreRepondu => 'Pas encore répondu.';

  @override
  String get reponseCommune => 'Réponse commune';

  @override
  String get supprimerExerciceTitre => 'Supprimer cet exercice ?';

  @override
  String get parcours => 'Parcours';

  @override
  String get aucunParcours => 'Aucun parcours pour l\'instant.';

  @override
  String etapesFaites(int faits, int total) {
    return '$faits / $total étapes';
  }

  @override
  String etapeNumero(int n) {
    return 'Étape $n';
  }

  @override
  String get continuerParcours => 'Continuer';

  @override
  String get commencerParcours => 'Commencer';

  @override
  String get parcoursTermine => 'Parcours terminé. Bravo à vous !';

  @override
  String get marquerFait => 'Marquer comme fait';

  @override
  String get etapeFaite => 'Étape faite';

  @override
  String get connexionPourSuivre =>
      'Connectez-vous pour suivre votre progression.';

  @override
  String get mesParcours => 'Mes parcours';

  @override
  String get nouveauParcours => 'Nouveau parcours';

  @override
  String get modifierParcours => 'Modifier le parcours';

  @override
  String get etapes => 'Étapes';

  @override
  String get ajouterEtape => 'Ajouter une étape';

  @override
  String get retirerEtape => 'Retirer l\'étape';

  @override
  String get etapesRequises => 'Ajoutez au moins une étape.';

  @override
  String get choisirContenuEtape => 'Choisir un contenu';

  @override
  String get supprimerParcoursTitre => 'Supprimer ce parcours ?';

  @override
  String nbEtapes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n étapes',
      one: '1 étape',
    );
    return '$_temp0';
  }

  @override
  String get votreCoach => 'Votre coach';

  @override
  String get messagesSansAccompagnement =>
      'Pour écrire à votre coach, demandez d\'abord un accompagnement depuis votre profil.';

  @override
  String get aucunMessage =>
      'Aucun message pour l\'instant. Écrivez le premier !';

  @override
  String get aucuneConversation => 'Aucune conversation pour l\'instant.';

  @override
  String get ecrireMessage => 'Écrire un message';

  @override
  String get envoyerMessage => 'Envoyer';

  @override
  String get envoyerPhoto => 'Envoyer une photo';

  @override
  String get messageVocal => 'Message vocal';

  @override
  String enregistrementEnCours(String duree) {
    return 'Enregistrement… $duree';
  }

  @override
  String get arreterEtEnvoyer => 'Arrêter et envoyer';

  @override
  String get microRefuse =>
      'L\'accès au micro est refusé. Autorisez-le dans les Réglages du téléphone.';

  @override
  String get envoiMessageEchoue =>
      'Le message n\'a pas pu être envoyé. Réessayez.';

  @override
  String nonLus(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n messages non lus',
      one: '1 message non lu',
    );
    return '$_temp0';
  }

  @override
  String get rendezVous => 'Rendez-vous';

  @override
  String get prochainRendezVous => 'Prochain rendez-vous';

  @override
  String get aucunRendezVous =>
      'Aucun rendez-vous prévu pour l\'instant. Votre coach vous proposera une date.';

  @override
  String get seancesSansAccompagnement =>
      'Vos rendez-vous apparaîtront ici une fois votre accompagnement commencé.';

  @override
  String get planifierRendezVous => 'Planifier un rendez-vous';

  @override
  String get modifierRendezVous => 'Modifier le rendez-vous';

  @override
  String get champDate => 'Date';

  @override
  String get champHeure => 'Heure';

  @override
  String get champDuree => 'Durée';

  @override
  String dureeMinutes(int n) {
    return '$n min';
  }

  @override
  String get champLienZoom => 'Lien Zoom';

  @override
  String get champLienZoomAide =>
      'Collez le lien de la réunion Zoom (https://…)';

  @override
  String get lienZoomInvalide =>
      'Lien invalide : il doit commencer par https://';

  @override
  String get rejoindreZoom => 'Rejoindre sur Zoom';

  @override
  String get lienZoomAVenir => 'Le lien Zoom sera ajouté par votre coach.';

  @override
  String get lienImpossible => 'Impossible d\'ouvrir le lien.';

  @override
  String get rdvEnCours => 'En cours';

  @override
  String get rdvAnnule => 'Annulé';

  @override
  String get rdvFait => 'Fait';

  @override
  String get rdvPasse => 'Passé';

  @override
  String get annulerRendezVous => 'Annuler le rendez-vous';

  @override
  String get confirmerAnnulationRdv =>
      'Annuler ce rendez-vous ? Les personnes accompagnées seront prévenues.';

  @override
  String get marquerSeanceFaite => 'Séance faite (−1 séance)';

  @override
  String get historique => 'Historique';

  @override
  String get aVenir => 'À venir';

  @override
  String get agenda => 'Agenda';

  @override
  String get agendaVide => 'Aucun rendez-vous à venir.';

  @override
  String get rappelsAutomatiques =>
      'Rappel automatique la veille et 1 heure avant.';

  @override
  String get rendezVousEnregistre => 'Rendez-vous enregistré';

  @override
  String get dateDansLePasse => 'Choisissez une date à venir.';

  @override
  String get nonMerci => 'Non';

  @override
  String get forfaits => 'Forfaits de séances';

  @override
  String get forfaitsAide =>
      'Payez par virement bancaire : les séances sont ajoutées dès que votre coach a reçu le paiement.';

  @override
  String nbSeancesForfait(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n séances',
      one: '1 séance',
    );
    return '$_temp0';
  }

  @override
  String get choisir => 'Choisir';

  @override
  String get mesPaiements => 'Mes paiements';

  @override
  String get paiementEnAttente => 'En attente';

  @override
  String get paiementRecu => 'Reçu';

  @override
  String get paiementAnnule => 'Annulé';

  @override
  String get virementTitre => 'Paiement par virement';

  @override
  String get virementAide =>
      'Scannez le QR code avec votre application bancaire, ou recopiez les informations ci-dessous. N\'oubliez pas la communication : elle permet d\'identifier votre paiement.';

  @override
  String get montant => 'Montant';

  @override
  String get beneficiaire => 'Bénéficiaire';

  @override
  String get iban => 'IBAN';

  @override
  String get bic => 'BIC';

  @override
  String get communicationStructuree => 'Communication structurée';

  @override
  String get coordonneesIndisponibles =>
      'Les coordonnées bancaires ne sont pas encore disponibles. Écrivez à votre coach ou réessayez plus tard.';

  @override
  String get paiementRecuMerci => 'Paiement reçu. Merci !';

  @override
  String get paiementAttenteAide =>
      'Votre coach confirmera la réception du virement (en général 1 à 2 jours ouvrables).';

  @override
  String get renoncerPaiement => 'Je ne paie pas finalement';

  @override
  String get faireUnDon => 'Faire un don';

  @override
  String get donAilleurs =>
      'Vous souhaitez soutenir ce ministère ? Parlez-en à votre coach.';

  @override
  String get donAide =>
      'Votre don est libre et soutient ce ministère. Il ne donne accès à rien de plus : tous les contenus restent gratuits pour tous.';

  @override
  String get autreMontant => 'Autre montant (€)';

  @override
  String get montantInvalide => 'Entre 1 et 10 000 €';

  @override
  String get continuer => 'Continuer';

  @override
  String get don => 'Don';

  @override
  String get paiementsCoach => 'Paiements et dons';

  @override
  String get aucunPaiement => 'Aucun paiement.';

  @override
  String get confirmerReception => 'Paiement reçu';

  @override
  String confirmerReceptionTexte(String montant, String communication) {
    return 'Confirmez-vous avoir reçu $montant avec la communication $communication ? Les séances du forfait seront ajoutées automatiquement.';
  }

  @override
  String totalRecuMois(String montant) {
    return 'Reçu ce mois-ci : $montant';
  }

  @override
  String get nouveauForfait => 'Nouveau forfait';

  @override
  String get modifierForfait => 'Modifier le forfait';

  @override
  String get aucunForfait =>
      'Aucun forfait. Créez-en un pour que vos clients puissent payer leurs séances.';

  @override
  String get champNomForfait => 'Nom';

  @override
  String get champNbSeances => 'Nombre de séances';

  @override
  String get champPrix => 'Prix (€)';

  @override
  String get forfaitActif => 'Proposé aux clients';

  @override
  String get nombreInvalide => 'Nombre invalide';

  @override
  String get parametresCoach => 'Paramètres du coach';

  @override
  String get parametresCoachAide =>
      'Ces coordonnées sont affichées aux personnes qui paient un forfait ou font un don.';

  @override
  String get champNomAffiche => 'Nom affiché';

  @override
  String get champTitulaire => 'Titulaire du compte';

  @override
  String get champBicAide => 'Facultatif';

  @override
  String get ibanInvalide => 'IBAN invalide : vérifiez les chiffres';

  @override
  String get bicInvalide => 'BIC invalide (8 ou 11 caractères)';

  @override
  String get champMessageDon => 'Message de remerciement des dons';

  @override
  String get plus => 'Plus';

  @override
  String get mesLivres => 'Mes livres';

  @override
  String get mesLivresAide => 'Les livres de votre coach';

  @override
  String get aucunLivre => 'Aucun livre pour le moment.';

  @override
  String get formatPapier => 'Papier';

  @override
  String get formatNumerique => 'Numérique';

  @override
  String get formatAudio => 'Livre audio';

  @override
  String disponibleEn(String langues) {
    return 'Disponible en : $langues';
  }

  @override
  String acheterSur(String boutique) {
    return 'Acheter sur $boutique';
  }

  @override
  String get lireExtrait => 'Lire un extrait';

  @override
  String get commanderAuCoach => 'Commander au coach';

  @override
  String get commanderAuCoachAide =>
      'Livre papier envoyé par la poste, payé par virement.';

  @override
  String get quantite => 'Quantité';

  @override
  String get fraisEnvoi => 'Frais d\'envoi';

  @override
  String get total => 'Total';

  @override
  String get adresseLivraison => 'Adresse de livraison';

  @override
  String get champRue => 'Rue et numéro';

  @override
  String get champCodePostal => 'Code postal';

  @override
  String get champVille => 'Ville';

  @override
  String get champPays => 'Pays';

  @override
  String get commander => 'Commander';

  @override
  String get commandeLivre => 'Commande de livre';

  @override
  String get mesCommandes => 'Mes commandes';

  @override
  String get commandeEnAttente => 'Paiement attendu';

  @override
  String get commandePayee => 'Payée';

  @override
  String get commandeEnvoyee => 'Envoyée';

  @override
  String get commandeAnnulee => 'Annulée';

  @override
  String get commandePayeeAide =>
      'Paiement reçu : votre livre sera envoyé très bientôt.';

  @override
  String get commandeEnvoyeeAide => 'Votre livre est en route. Bonne lecture !';

  @override
  String get numeroSuivi => 'Numéro de suivi';

  @override
  String get renoncerCommande => 'Annuler la commande';

  @override
  String get livresCoach => 'Livres';

  @override
  String get commandesLivres => 'Commandes';

  @override
  String get aucuneCommande => 'Aucune commande.';

  @override
  String get nouveauLivre => 'Nouveau livre';

  @override
  String get modifierLivre => 'Modifier le livre';

  @override
  String get couverture => 'Couverture';

  @override
  String get choisirCouverture => 'Choisir une image';

  @override
  String get champSousTitre => 'Sous-titre';

  @override
  String get languesDuLivre => 'Langues du livre';

  @override
  String get formatsEtPrix => 'Formats et prix (€)';

  @override
  String get liensAchat => 'Liens d\'achat';

  @override
  String get nomBoutique => 'Boutique (ex. Amazon)';

  @override
  String get adresseLien => 'Adresse (https://…)';

  @override
  String get ajouterLien => 'Ajouter un lien';

  @override
  String get lienInvalide =>
      'Adresse invalide : elle doit commencer par https://';

  @override
  String get commandeDirecteOption => 'Commande directe du livre papier';

  @override
  String get commandeDirecteAide =>
      'Les lecteurs vous commandent le livre et paient par virement ; vous l\'envoyez par la poste.';

  @override
  String get champExtrait => 'Lien vers un extrait (facultatif)';

  @override
  String get publierLivre => 'Publié';

  @override
  String get prixPapierRequis => 'Indiquez le prix du livre papier';

  @override
  String get marquerPayee => 'Paiement reçu';

  @override
  String get marquerEnvoyee => 'Marquer envoyée';

  @override
  String get aTraiter => 'À traiter';

  @override
  String get cgu => 'Conditions d\'utilisation';

  @override
  String get confidentialite => 'Confidentialité';

  @override
  String get aideContact => 'Aide et contact';

  @override
  String get legalEnFrancais => '';

  @override
  String get langueApp => 'Langue de l\'application';

  @override
  String get langueTelephone => 'Langue du téléphone';

  @override
  String get mesDonnees => 'Mes données';

  @override
  String get telechargerMesDonnees => 'Télécharger mes données';

  @override
  String get exportEchoue =>
      'L\'export a échoué. Vérifiez votre connexion et réessayez.';

  @override
  String get supprimerMonCompte => 'Supprimer mon compte';

  @override
  String get supprimerCompteTexte =>
      'Votre compte, vos messages, vos réponses et votre progression seront définitivement supprimés. Si vous êtes accompagné en couple, votre conjoint garde l\'accompagnement. Les paiements sont conservés sans votre nom pour la comptabilité. Cette action est irréversible.';

  @override
  String get supprimerDefinitivement => 'Supprimer définitivement';

  @override
  String get compteSupprime => 'Votre compte a été supprimé.';

  @override
  String get erreurCommandeEnCours =>
      'Un livre payé n\'a pas encore été envoyé : réessayez après sa réception.';

  @override
  String get erreurCompteCoach =>
      'Le compte du coach ne peut pas être supprimé depuis l\'application.';

  @override
  String get presentationCoach => 'Ma présentation';

  @override
  String get presentationCoachAide =>
      'Visible par tous sur l\'accueil, avec votre nom affiché et la photo de votre profil.';

  @override
  String get champBio => 'Présentation';

  @override
  String get informationsLegales => 'Informations';

  @override
  String get contenusDepart => 'Contenus de départ';

  @override
  String get contenusDepartAide =>
      'Ajoute 30 méditations, 60 questions pour discuter à deux et 4 parcours, dans les 5 langues, déjà publiés. Vous pourrez tout modifier, dépublier ou supprimer. Vos contenus existants ne sont jamais remplacés.';

  @override
  String get charger => 'Charger';

  @override
  String contenusDepartAjoutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n contenus ajoutés.',
      one: '1 contenu ajouté.',
      zero: 'Tout était déjà là : rien à ajouter.',
    );
    return '$_temp0';
  }

  @override
  String get boutique => 'Boutique';

  @override
  String get ajouterArticle => 'Ajouter un article';

  @override
  String get nouvelArticle => 'Nouvel article';

  @override
  String get categorieLivre => 'Livre';

  @override
  String get categorieAutre => 'Autre article';

  @override
  String get categorieLivres => 'Livres';

  @override
  String get categorieAutres => 'Autres articles';

  @override
  String get articleAutreAide =>
      'Objet physique (CD, agenda, carte, vêtement…). Un article numérique se vend uniquement par un lien vers une boutique extérieure.';

  @override
  String get ajouterAudioVideo => 'Ajouter un audio ou une vidéo';
}
