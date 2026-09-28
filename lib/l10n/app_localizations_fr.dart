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
  String get messagesAVenir => 'Ici : votre conversation avec votre coach.';

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
}
