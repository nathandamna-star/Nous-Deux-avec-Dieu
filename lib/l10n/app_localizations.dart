import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('nl'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nous deux avec Dieu'**
  String get appTitle;

  /// No description provided for @slogan.
  ///
  /// In fr, this message translates to:
  /// **'Grandir à deux, avec Dieu au centre.'**
  String get slogan;

  /// No description provided for @navAccueil.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get navAccueil;

  /// No description provided for @navContenus.
  ///
  /// In fr, this message translates to:
  /// **'Contenus'**
  String get navContenus;

  /// No description provided for @navMessages.
  ///
  /// In fr, this message translates to:
  /// **'Messages'**
  String get navMessages;

  /// No description provided for @navSeances.
  ///
  /// In fr, this message translates to:
  /// **'Séances'**
  String get navSeances;

  /// No description provided for @navProfil.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get navProfil;

  /// No description provided for @navCoach.
  ///
  /// In fr, this message translates to:
  /// **'Coach'**
  String get navCoach;

  /// No description provided for @bientot.
  ///
  /// In fr, this message translates to:
  /// **'Bientôt disponible'**
  String get bientot;

  /// No description provided for @seancesAVenir.
  ///
  /// In fr, this message translates to:
  /// **'Ici : vos rendez-vous, vos séances restantes et les forfaits.'**
  String get seancesAVenir;

  /// No description provided for @profilAVenir.
  ///
  /// In fr, this message translates to:
  /// **'Ici : votre langue, votre conjoint, les dons et vos données.'**
  String get profilAVenir;

  /// No description provided for @bienvenueQuestion.
  ///
  /// In fr, this message translates to:
  /// **'Qu\'est-ce qui vous amène ?'**
  String get bienvenueQuestion;

  /// No description provided for @parcoursCouple.
  ///
  /// In fr, this message translates to:
  /// **'Nous venons en couple'**
  String get parcoursCouple;

  /// No description provided for @parcoursCoupleAide.
  ///
  /// In fr, this message translates to:
  /// **'Mariés, fiancés ou en couple'**
  String get parcoursCoupleAide;

  /// No description provided for @parcoursSeul.
  ///
  /// In fr, this message translates to:
  /// **'Je viens seul(e)'**
  String get parcoursSeul;

  /// No description provided for @parcoursSeulAide.
  ///
  /// In fr, this message translates to:
  /// **'Pour avancer personnellement ou préparer l\'avenir'**
  String get parcoursSeulAide;

  /// No description provided for @parcoursDecouverte.
  ///
  /// In fr, this message translates to:
  /// **'Je découvre'**
  String get parcoursDecouverte;

  /// No description provided for @parcoursDecouverteAide.
  ///
  /// In fr, this message translates to:
  /// **'Méditations, questions à deux, audios et vidéos'**
  String get parcoursDecouverteAide;

  /// No description provided for @continuerEmail.
  ///
  /// In fr, this message translates to:
  /// **'Continuer avec l\'e-mail'**
  String get continuerEmail;

  /// No description provided for @explorerSansCompte.
  ///
  /// In fr, this message translates to:
  /// **'Découvrir sans compte'**
  String get explorerSansCompte;

  /// No description provided for @seConnecter.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get seConnecter;

  /// No description provided for @creerCompte.
  ///
  /// In fr, this message translates to:
  /// **'Créer un compte'**
  String get creerCompte;

  /// No description provided for @seDeconnecter.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get seDeconnecter;

  /// No description provided for @champNom.
  ///
  /// In fr, this message translates to:
  /// **'Prénom et nom'**
  String get champNom;

  /// No description provided for @champEmail.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail'**
  String get champEmail;

  /// No description provided for @champMotDePasse.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get champMotDePasse;

  /// No description provided for @afficherMotDePasse.
  ///
  /// In fr, this message translates to:
  /// **'Afficher le mot de passe'**
  String get afficherMotDePasse;

  /// No description provided for @masquerMotDePasse.
  ///
  /// In fr, this message translates to:
  /// **'Masquer le mot de passe'**
  String get masquerMotDePasse;

  /// No description provided for @motDePasseOublie.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get motDePasseOublie;

  /// No description provided for @emailReinitialisationEnvoye.
  ///
  /// In fr, this message translates to:
  /// **'Un e-mail pour choisir un nouveau mot de passe a été envoyé à {email}.'**
  String emailReinitialisationEnvoye(String email);

  /// No description provided for @validationNomRequis.
  ///
  /// In fr, this message translates to:
  /// **'Indiquez votre nom.'**
  String get validationNomRequis;

  /// No description provided for @validationEmail.
  ///
  /// In fr, this message translates to:
  /// **'Indiquez une adresse e-mail valide.'**
  String get validationEmail;

  /// No description provided for @validationMotDePasse.
  ///
  /// In fr, this message translates to:
  /// **'Au moins 8 caractères.'**
  String get validationMotDePasse;

  /// No description provided for @consentementTexte.
  ///
  /// In fr, this message translates to:
  /// **'J\'accepte que mes réponses et échanges, qui peuvent concerner ma foi et ma vie de couple, soient conservés en Europe et vus uniquement par mon coach, pour m\'accompagner. Je peux retirer mon accord et supprimer mon compte à tout moment.'**
  String get consentementTexte;

  /// No description provided for @consentementRequis.
  ///
  /// In fr, this message translates to:
  /// **'Cochez la case pour créer votre compte.'**
  String get consentementRequis;

  /// No description provided for @chargement.
  ///
  /// In fr, this message translates to:
  /// **'Chargement…'**
  String get chargement;

  /// No description provided for @erreurEmailInvalide.
  ///
  /// In fr, this message translates to:
  /// **'Cette adresse e-mail n\'est pas valide.'**
  String get erreurEmailInvalide;

  /// No description provided for @erreurMotDePasseFaible.
  ///
  /// In fr, this message translates to:
  /// **'Ce mot de passe est trop faible. Utilisez au moins 8 caractères.'**
  String get erreurMotDePasseFaible;

  /// No description provided for @erreurEmailDejaUtilise.
  ///
  /// In fr, this message translates to:
  /// **'Un compte existe déjà avec cette adresse. Connectez-vous plutôt.'**
  String get erreurEmailDejaUtilise;

  /// No description provided for @erreurIdentifiantsIncorrects.
  ///
  /// In fr, this message translates to:
  /// **'Adresse e-mail ou mot de passe incorrect.'**
  String get erreurIdentifiantsIncorrects;

  /// No description provided for @erreurTropDeTentatives.
  ///
  /// In fr, this message translates to:
  /// **'Trop de tentatives. Réessayez dans quelques minutes.'**
  String get erreurTropDeTentatives;

  /// No description provided for @erreurReseau.
  ///
  /// In fr, this message translates to:
  /// **'Pas de connexion internet. Vérifiez votre réseau et réessayez.'**
  String get erreurReseau;

  /// No description provided for @erreurInconnue.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue. Réessayez.'**
  String get erreurInconnue;

  /// No description provided for @connexionRequiseTitre.
  ///
  /// In fr, this message translates to:
  /// **'Un espace rien qu\'à vous'**
  String get connexionRequiseTitre;

  /// No description provided for @connexionRequiseTexte.
  ///
  /// In fr, this message translates to:
  /// **'Connectez-vous pour échanger avec votre coach, suivre vos séances et gérer votre profil.'**
  String get connexionRequiseTexte;

  /// No description provided for @bonjourNom.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour {nom}'**
  String bonjourNom(String nom);

  /// No description provided for @roleCoach.
  ///
  /// In fr, this message translates to:
  /// **'Coach'**
  String get roleCoach;

  /// No description provided for @monAccompagnement.
  ///
  /// In fr, this message translates to:
  /// **'Mon accompagnement'**
  String get monAccompagnement;

  /// No description provided for @demanderAccompagnement.
  ///
  /// In fr, this message translates to:
  /// **'Demander un accompagnement'**
  String get demanderAccompagnement;

  /// No description provided for @demanderAccompagnementAide.
  ///
  /// In fr, this message translates to:
  /// **'Votre coach vous répondra pour convenir d\'un premier rendez-vous.'**
  String get demanderAccompagnementAide;

  /// No description provided for @jAiUnCode.
  ///
  /// In fr, this message translates to:
  /// **'J\'ai un code de mon conjoint'**
  String get jAiUnCode;

  /// No description provided for @typeCouple.
  ///
  /// In fr, this message translates to:
  /// **'En couple'**
  String get typeCouple;

  /// No description provided for @typeIndividuel.
  ///
  /// In fr, this message translates to:
  /// **'Seul(e)'**
  String get typeIndividuel;

  /// No description provided for @champNomAccompagnement.
  ///
  /// In fr, this message translates to:
  /// **'Nom affiché'**
  String get champNomAccompagnement;

  /// No description provided for @champNomAccompagnementAide.
  ///
  /// In fr, this message translates to:
  /// **'Par exemple « Paul & Marie »'**
  String get champNomAccompagnementAide;

  /// No description provided for @champMessage.
  ///
  /// In fr, this message translates to:
  /// **'Votre message au coach (facultatif)'**
  String get champMessage;

  /// No description provided for @champMessageAide.
  ///
  /// In fr, this message translates to:
  /// **'Ce que vous vivez, ce que vous espérez…'**
  String get champMessageAide;

  /// No description provided for @envoyerDemande.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer ma demande'**
  String get envoyerDemande;

  /// No description provided for @demandeEnvoyee.
  ///
  /// In fr, this message translates to:
  /// **'Demande envoyée. Votre coach vous répondra bientôt.'**
  String get demandeEnvoyee;

  /// No description provided for @champObligatoire.
  ///
  /// In fr, this message translates to:
  /// **'Ce champ est obligatoire.'**
  String get champObligatoire;

  /// No description provided for @rejoindreTitre.
  ///
  /// In fr, this message translates to:
  /// **'Rejoindre mon conjoint'**
  String get rejoindreTitre;

  /// No description provided for @rejoindreAide.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez le code à 6 caractères que votre conjoint voit dans son profil.'**
  String get rejoindreAide;

  /// No description provided for @champCode.
  ///
  /// In fr, this message translates to:
  /// **'Code d\'invitation'**
  String get champCode;

  /// No description provided for @rejoindre.
  ///
  /// In fr, this message translates to:
  /// **'Rejoindre'**
  String get rejoindre;

  /// No description provided for @codeInvalide.
  ///
  /// In fr, this message translates to:
  /// **'Ce code n\'est pas valable, ou le couple est déjà complet.'**
  String get codeInvalide;

  /// No description provided for @codePourConjoint.
  ///
  /// In fr, this message translates to:
  /// **'Code pour votre conjoint : {code}'**
  String codePourConjoint(String code);

  /// No description provided for @codePourConjointAide.
  ///
  /// In fr, this message translates to:
  /// **'Votre conjoint crée son compte, puis choisit « J\'ai un code de mon conjoint ».'**
  String get codePourConjointAide;

  /// No description provided for @copier.
  ///
  /// In fr, this message translates to:
  /// **'Copier'**
  String get copier;

  /// No description provided for @copie.
  ///
  /// In fr, this message translates to:
  /// **'Copié'**
  String get copie;

  /// No description provided for @statutDemande.
  ///
  /// In fr, this message translates to:
  /// **'Demande en attente'**
  String get statutDemande;

  /// No description provided for @statutActif.
  ///
  /// In fr, this message translates to:
  /// **'Accompagnement en cours'**
  String get statutActif;

  /// No description provided for @statutEnPause.
  ///
  /// In fr, this message translates to:
  /// **'En pause'**
  String get statutEnPause;

  /// No description provided for @statutTermine.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get statutTermine;

  /// No description provided for @seancesRestantes.
  ///
  /// In fr, this message translates to:
  /// **'{n, plural, =0{Aucune séance restante} =1{1 séance restante} other{{n} séances restantes}}'**
  String seancesRestantes(int n);

  /// No description provided for @attendConjoint.
  ///
  /// In fr, this message translates to:
  /// **'En attente du conjoint'**
  String get attendConjoint;

  /// No description provided for @filtreDemandes.
  ///
  /// In fr, this message translates to:
  /// **'Demandes'**
  String get filtreDemandes;

  /// No description provided for @filtreActifs.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get filtreActifs;

  /// No description provided for @filtreTermines.
  ///
  /// In fr, this message translates to:
  /// **'Terminés'**
  String get filtreTermines;

  /// No description provided for @aucunAccompagnement.
  ///
  /// In fr, this message translates to:
  /// **'Aucun accompagnement ici pour l\'instant.'**
  String get aucunAccompagnement;

  /// No description provided for @membres.
  ///
  /// In fr, this message translates to:
  /// **'Membres'**
  String get membres;

  /// No description provided for @messageDemande.
  ///
  /// In fr, this message translates to:
  /// **'Message de la demande'**
  String get messageDemande;

  /// No description provided for @accepter.
  ///
  /// In fr, this message translates to:
  /// **'Accepter'**
  String get accepter;

  /// No description provided for @mettreEnPause.
  ///
  /// In fr, this message translates to:
  /// **'Mettre en pause'**
  String get mettreEnPause;

  /// No description provided for @reprendre.
  ///
  /// In fr, this message translates to:
  /// **'Reprendre'**
  String get reprendre;

  /// No description provided for @terminer.
  ///
  /// In fr, this message translates to:
  /// **'Terminer'**
  String get terminer;

  /// No description provided for @seances.
  ///
  /// In fr, this message translates to:
  /// **'Séances'**
  String get seances;

  /// No description provided for @retirerSeance.
  ///
  /// In fr, this message translates to:
  /// **'Retirer une séance'**
  String get retirerSeance;

  /// No description provided for @ajouterSeance.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une séance'**
  String get ajouterSeance;

  /// No description provided for @notesPrivees.
  ///
  /// In fr, this message translates to:
  /// **'Notes privées'**
  String get notesPrivees;

  /// No description provided for @notesPriveesAide.
  ///
  /// In fr, this message translates to:
  /// **'Visibles par vous seul.'**
  String get notesPriveesAide;

  /// No description provided for @nouvelleNote.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle note'**
  String get nouvelleNote;

  /// No description provided for @ajouter.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get ajouter;

  /// No description provided for @supprimer.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get supprimer;

  /// No description provided for @aucuneNote.
  ///
  /// In fr, this message translates to:
  /// **'Aucune note pour l\'instant.'**
  String get aucuneNote;

  /// No description provided for @activerCoachTitre.
  ///
  /// In fr, this message translates to:
  /// **'Activer l\'espace coach ?'**
  String get activerCoachTitre;

  /// No description provided for @activerCoachTexte.
  ///
  /// In fr, this message translates to:
  /// **'Réservé au coach : seul le compte désigné lors de la mise en service peut l\'activer.'**
  String get activerCoachTexte;

  /// No description provided for @coachActive.
  ///
  /// In fr, this message translates to:
  /// **'Espace coach activé.'**
  String get coachActive;

  /// No description provided for @coachRefuse.
  ///
  /// In fr, this message translates to:
  /// **'Ce compte ne peut pas devenir coach.'**
  String get coachRefuse;

  /// No description provided for @annuler.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get annuler;

  /// No description provided for @valider.
  ///
  /// In fr, this message translates to:
  /// **'Valider'**
  String get valider;

  /// No description provided for @typeMeditation.
  ///
  /// In fr, this message translates to:
  /// **'Méditation'**
  String get typeMeditation;

  /// No description provided for @typeQuestion.
  ///
  /// In fr, this message translates to:
  /// **'Question à deux'**
  String get typeQuestion;

  /// No description provided for @typeExercice.
  ///
  /// In fr, this message translates to:
  /// **'Exercice'**
  String get typeExercice;

  /// No description provided for @typeArticle.
  ///
  /// In fr, this message translates to:
  /// **'Article'**
  String get typeArticle;

  /// No description provided for @tous.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get tous;

  /// No description provided for @themeCommunication.
  ///
  /// In fr, this message translates to:
  /// **'Communication'**
  String get themeCommunication;

  /// No description provided for @themePardon.
  ///
  /// In fr, this message translates to:
  /// **'Pardon'**
  String get themePardon;

  /// No description provided for @themeFinances.
  ///
  /// In fr, this message translates to:
  /// **'Finances'**
  String get themeFinances;

  /// No description provided for @themeIntimite.
  ///
  /// In fr, this message translates to:
  /// **'Intimité'**
  String get themeIntimite;

  /// No description provided for @themePriere.
  ///
  /// In fr, this message translates to:
  /// **'Prière'**
  String get themePriere;

  /// No description provided for @themeEnfants.
  ///
  /// In fr, this message translates to:
  /// **'Enfants'**
  String get themeEnfants;

  /// No description provided for @themeFiancailles.
  ///
  /// In fr, this message translates to:
  /// **'Fiançailles'**
  String get themeFiancailles;

  /// No description provided for @themeGratitude.
  ///
  /// In fr, this message translates to:
  /// **'Gratitude'**
  String get themeGratitude;

  /// No description provided for @meditationDuJour.
  ///
  /// In fr, this message translates to:
  /// **'Méditation du jour'**
  String get meditationDuJour;

  /// No description provided for @lire.
  ///
  /// In fr, this message translates to:
  /// **'Lire'**
  String get lire;

  /// No description provided for @decouvrirContenus.
  ///
  /// In fr, this message translates to:
  /// **'Découvrir tous les contenus'**
  String get decouvrirContenus;

  /// No description provided for @aucunContenu.
  ///
  /// In fr, this message translates to:
  /// **'Aucun contenu pour l\'instant. Revenez bientôt !'**
  String get aucunContenu;

  /// No description provided for @autreLangue.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore traduit dans votre langue.'**
  String get autreLangue;

  /// No description provided for @accueilBienvenue.
  ///
  /// In fr, this message translates to:
  /// **'Que la paix de Dieu garde vos cœurs.'**
  String get accueilBienvenue;

  /// No description provided for @mesContenus.
  ///
  /// In fr, this message translates to:
  /// **'Mes contenus'**
  String get mesContenus;

  /// No description provided for @nouveauContenu.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau contenu'**
  String get nouveauContenu;

  /// No description provided for @modifierContenu.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le contenu'**
  String get modifierContenu;

  /// No description provided for @brouillon.
  ///
  /// In fr, this message translates to:
  /// **'Brouillon'**
  String get brouillon;

  /// No description provided for @publie.
  ///
  /// In fr, this message translates to:
  /// **'Publié'**
  String get publie;

  /// No description provided for @champType.
  ///
  /// In fr, this message translates to:
  /// **'Type'**
  String get champType;

  /// No description provided for @champTheme.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get champTheme;

  /// No description provided for @champTitre.
  ///
  /// In fr, this message translates to:
  /// **'Titre'**
  String get champTitre;

  /// No description provided for @champTexte.
  ///
  /// In fr, this message translates to:
  /// **'Texte'**
  String get champTexte;

  /// No description provided for @champReference.
  ///
  /// In fr, this message translates to:
  /// **'Référence biblique (facultatif)'**
  String get champReference;

  /// No description provided for @champReferenceAide.
  ///
  /// In fr, this message translates to:
  /// **'Ex. Éphésiens 4:2'**
  String get champReferenceAide;

  /// No description provided for @langueVersion.
  ///
  /// In fr, this message translates to:
  /// **'Version'**
  String get langueVersion;

  /// No description provided for @titreFrancaisRequis.
  ///
  /// In fr, this message translates to:
  /// **'Le titre en français est obligatoire.'**
  String get titreFrancaisRequis;

  /// No description provided for @visiblePourTous.
  ///
  /// In fr, this message translates to:
  /// **'Visible sans compte'**
  String get visiblePourTous;

  /// No description provided for @visiblePourTousAide.
  ///
  /// In fr, this message translates to:
  /// **'Sinon, seulement pour les personnes connectées.'**
  String get visiblePourTousAide;

  /// No description provided for @publier.
  ///
  /// In fr, this message translates to:
  /// **'Publier'**
  String get publier;

  /// No description provided for @publierAide.
  ///
  /// In fr, this message translates to:
  /// **'Désactivé : brouillon, visible par vous seul.'**
  String get publierAide;

  /// No description provided for @champOrdre.
  ///
  /// In fr, this message translates to:
  /// **'Ordre d\'affichage'**
  String get champOrdre;

  /// No description provided for @champOrdreAide.
  ///
  /// In fr, this message translates to:
  /// **'Les méditations du jour suivent cet ordre (1, 2, 3…).'**
  String get champOrdreAide;

  /// No description provided for @enregistrer.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get enregistrer;

  /// No description provided for @enregistre.
  ///
  /// In fr, this message translates to:
  /// **'Enregistré'**
  String get enregistre;

  /// No description provided for @supprimerContenuTitre.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer ce contenu ?'**
  String get supprimerContenuTitre;

  /// No description provided for @supprimerContenuTexte.
  ///
  /// In fr, this message translates to:
  /// **'Il disparaîtra pour tout le monde. C\'est définitif.'**
  String get supprimerContenuTexte;

  /// No description provided for @typeAudio.
  ///
  /// In fr, this message translates to:
  /// **'Audio'**
  String get typeAudio;

  /// No description provided for @typeVideo.
  ///
  /// In fr, this message translates to:
  /// **'Vidéo'**
  String get typeVideo;

  /// No description provided for @lecture.
  ///
  /// In fr, this message translates to:
  /// **'Lecture'**
  String get lecture;

  /// No description provided for @pause.
  ///
  /// In fr, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @reculer15.
  ///
  /// In fr, this message translates to:
  /// **'Reculer de 15 secondes'**
  String get reculer15;

  /// No description provided for @avancer15.
  ///
  /// In fr, this message translates to:
  /// **'Avancer de 15 secondes'**
  String get avancer15;

  /// No description provided for @vitesse.
  ///
  /// In fr, this message translates to:
  /// **'Vitesse de lecture'**
  String get vitesse;

  /// No description provided for @pleinEcran.
  ///
  /// In fr, this message translates to:
  /// **'Plein écran'**
  String get pleinEcran;

  /// No description provided for @erreurLecture.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de lire ce fichier. Vérifiez votre connexion.'**
  String get erreurLecture;

  /// No description provided for @fichierMedia.
  ///
  /// In fr, this message translates to:
  /// **'Fichier ({langue})'**
  String fichierMedia(String langue);

  /// No description provided for @choisirFichier.
  ///
  /// In fr, this message translates to:
  /// **'Choisir le fichier'**
  String get choisirFichier;

  /// No description provided for @remplacerFichier.
  ///
  /// In fr, this message translates to:
  /// **'Remplacer'**
  String get remplacerFichier;

  /// No description provided for @fichierAjoute.
  ///
  /// In fr, this message translates to:
  /// **'Fichier ajouté'**
  String get fichierAjoute;

  /// No description provided for @aucunFichier.
  ///
  /// In fr, this message translates to:
  /// **'Aucun fichier dans cette langue.'**
  String get aucunFichier;

  /// No description provided for @envoiEnCours.
  ///
  /// In fr, this message translates to:
  /// **'Envoi en cours… {pourcent} %'**
  String envoiEnCours(int pourcent);

  /// No description provided for @fichierRequis.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez au moins un fichier.'**
  String get fichierRequis;

  /// No description provided for @envoiEchoue.
  ///
  /// In fr, this message translates to:
  /// **'L\'envoi du fichier a échoué. Réessayez.'**
  String get envoiEchoue;

  /// No description provided for @champDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get champDescription;

  /// No description provided for @changerPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Changer la photo de profil'**
  String get changerPhoto;

  /// No description provided for @prendrePhoto.
  ///
  /// In fr, this message translates to:
  /// **'Prendre une photo'**
  String get prendrePhoto;

  /// No description provided for @choisirGalerie.
  ///
  /// In fr, this message translates to:
  /// **'Choisir dans la galerie'**
  String get choisirGalerie;

  /// No description provided for @supprimerPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la photo'**
  String get supprimerPhoto;

  /// No description provided for @photoEnvoiEchoue.
  ///
  /// In fr, this message translates to:
  /// **'La photo n\'a pas pu être enregistrée. Réessayez.'**
  String get photoEnvoiEchoue;

  /// No description provided for @mesExercices.
  ///
  /// In fr, this message translates to:
  /// **'Mes exercices'**
  String get mesExercices;

  /// No description provided for @exercicesAFaire.
  ///
  /// In fr, this message translates to:
  /// **'{n, plural, =0{Aucun exercice à faire} =1{1 exercice à faire} other{{n} exercices à faire}}'**
  String exercicesAFaire(int n);

  /// No description provided for @aucunExercice.
  ///
  /// In fr, this message translates to:
  /// **'Votre coach ne vous a pas encore envoyé d\'exercice.'**
  String get aucunExercice;

  /// No description provided for @exerciceFait.
  ///
  /// In fr, this message translates to:
  /// **'Fait'**
  String get exerciceFait;

  /// No description provided for @exerciceAFaire.
  ///
  /// In fr, this message translates to:
  /// **'À faire'**
  String get exerciceAFaire;

  /// No description provided for @modeSeul.
  ///
  /// In fr, this message translates to:
  /// **'Chacun de votre côté'**
  String get modeSeul;

  /// No description provided for @modeADeux.
  ///
  /// In fr, this message translates to:
  /// **'À faire à deux'**
  String get modeADeux;

  /// No description provided for @modeSeulAide.
  ///
  /// In fr, this message translates to:
  /// **'Votre réponse est vue seulement par vous et votre coach.'**
  String get modeSeulAide;

  /// No description provided for @modeADeuxAide.
  ///
  /// In fr, this message translates to:
  /// **'Une réponse commune, écrite ensemble, visible par vous deux et votre coach.'**
  String get modeADeuxAide;

  /// No description provided for @aFaireAvant.
  ///
  /// In fr, this message translates to:
  /// **'À faire avant le {date}'**
  String aFaireAvant(String date);

  /// No description provided for @lireAvant.
  ///
  /// In fr, this message translates to:
  /// **'À lire avant'**
  String get lireAvant;

  /// No description provided for @maReponse.
  ///
  /// In fr, this message translates to:
  /// **'Ma réponse'**
  String get maReponse;

  /// No description provided for @notreReponse.
  ///
  /// In fr, this message translates to:
  /// **'Notre réponse'**
  String get notreReponse;

  /// No description provided for @enregistrerReponse.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer ma réponse'**
  String get enregistrerReponse;

  /// No description provided for @reponseEnregistree.
  ///
  /// In fr, this message translates to:
  /// **'Réponse enregistrée. Votre coach pourra la lire.'**
  String get reponseEnregistree;

  /// No description provided for @exercices.
  ///
  /// In fr, this message translates to:
  /// **'Exercices'**
  String get exercices;

  /// No description provided for @envoyerExercice.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer un exercice'**
  String get envoyerExercice;

  /// No description provided for @apartirContenu.
  ///
  /// In fr, this message translates to:
  /// **'À partir d\'un contenu (facultatif)'**
  String get apartirContenu;

  /// No description provided for @aucunContenuLie.
  ///
  /// In fr, this message translates to:
  /// **'Aucun'**
  String get aucunContenuLie;

  /// No description provided for @champConsignes.
  ///
  /// In fr, this message translates to:
  /// **'Consignes'**
  String get champConsignes;

  /// No description provided for @echeance.
  ///
  /// In fr, this message translates to:
  /// **'Date limite (facultatif)'**
  String get echeance;

  /// No description provided for @choisirDate.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une date'**
  String get choisirDate;

  /// No description provided for @envoyer.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer'**
  String get envoyer;

  /// No description provided for @exerciceEnvoye.
  ///
  /// In fr, this message translates to:
  /// **'Exercice envoyé.'**
  String get exerciceEnvoye;

  /// No description provided for @reponses.
  ///
  /// In fr, this message translates to:
  /// **'{n, plural, =0{Aucune réponse} =1{1 réponse} other{{n} réponses}}'**
  String reponses(int n);

  /// No description provided for @pasEncoreRepondu.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore répondu.'**
  String get pasEncoreRepondu;

  /// No description provided for @reponseCommune.
  ///
  /// In fr, this message translates to:
  /// **'Réponse commune'**
  String get reponseCommune;

  /// No description provided for @supprimerExerciceTitre.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer cet exercice ?'**
  String get supprimerExerciceTitre;

  /// No description provided for @parcours.
  ///
  /// In fr, this message translates to:
  /// **'Parcours'**
  String get parcours;

  /// No description provided for @aucunParcours.
  ///
  /// In fr, this message translates to:
  /// **'Aucun parcours pour l\'instant.'**
  String get aucunParcours;

  /// No description provided for @etapesFaites.
  ///
  /// In fr, this message translates to:
  /// **'{faits} / {total} étapes'**
  String etapesFaites(int faits, int total);

  /// No description provided for @etapeNumero.
  ///
  /// In fr, this message translates to:
  /// **'Étape {n}'**
  String etapeNumero(int n);

  /// No description provided for @continuerParcours.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get continuerParcours;

  /// No description provided for @commencerParcours.
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get commencerParcours;

  /// No description provided for @parcoursTermine.
  ///
  /// In fr, this message translates to:
  /// **'Parcours terminé. Bravo à vous !'**
  String get parcoursTermine;

  /// No description provided for @marquerFait.
  ///
  /// In fr, this message translates to:
  /// **'Marquer comme fait'**
  String get marquerFait;

  /// No description provided for @etapeFaite.
  ///
  /// In fr, this message translates to:
  /// **'Étape faite'**
  String get etapeFaite;

  /// No description provided for @connexionPourSuivre.
  ///
  /// In fr, this message translates to:
  /// **'Connectez-vous pour suivre votre progression.'**
  String get connexionPourSuivre;

  /// No description provided for @mesParcours.
  ///
  /// In fr, this message translates to:
  /// **'Mes parcours'**
  String get mesParcours;

  /// No description provided for @nouveauParcours.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau parcours'**
  String get nouveauParcours;

  /// No description provided for @modifierParcours.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le parcours'**
  String get modifierParcours;

  /// No description provided for @etapes.
  ///
  /// In fr, this message translates to:
  /// **'Étapes'**
  String get etapes;

  /// No description provided for @ajouterEtape.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une étape'**
  String get ajouterEtape;

  /// No description provided for @retirerEtape.
  ///
  /// In fr, this message translates to:
  /// **'Retirer l\'étape'**
  String get retirerEtape;

  /// No description provided for @etapesRequises.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez au moins une étape.'**
  String get etapesRequises;

  /// No description provided for @choisirContenuEtape.
  ///
  /// In fr, this message translates to:
  /// **'Choisir un contenu'**
  String get choisirContenuEtape;

  /// No description provided for @supprimerParcoursTitre.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer ce parcours ?'**
  String get supprimerParcoursTitre;

  /// No description provided for @nbEtapes.
  ///
  /// In fr, this message translates to:
  /// **'{n, plural, =1{1 étape} other{{n} étapes}}'**
  String nbEtapes(int n);

  /// No description provided for @votreCoach.
  ///
  /// In fr, this message translates to:
  /// **'Votre coach'**
  String get votreCoach;

  /// No description provided for @messagesSansAccompagnement.
  ///
  /// In fr, this message translates to:
  /// **'Pour écrire à votre coach, demandez d\'abord un accompagnement depuis votre profil.'**
  String get messagesSansAccompagnement;

  /// No description provided for @aucunMessage.
  ///
  /// In fr, this message translates to:
  /// **'Aucun message pour l\'instant. Écrivez le premier !'**
  String get aucunMessage;

  /// No description provided for @aucuneConversation.
  ///
  /// In fr, this message translates to:
  /// **'Aucune conversation pour l\'instant.'**
  String get aucuneConversation;

  /// No description provided for @ecrireMessage.
  ///
  /// In fr, this message translates to:
  /// **'Écrire un message'**
  String get ecrireMessage;

  /// No description provided for @envoyerMessage.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer'**
  String get envoyerMessage;

  /// No description provided for @envoyerPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer une photo'**
  String get envoyerPhoto;

  /// No description provided for @messageVocal.
  ///
  /// In fr, this message translates to:
  /// **'Message vocal'**
  String get messageVocal;

  /// No description provided for @enregistrementEnCours.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrement… {duree}'**
  String enregistrementEnCours(String duree);

  /// No description provided for @arreterEtEnvoyer.
  ///
  /// In fr, this message translates to:
  /// **'Arrêter et envoyer'**
  String get arreterEtEnvoyer;

  /// No description provided for @microRefuse.
  ///
  /// In fr, this message translates to:
  /// **'L\'accès au micro est refusé. Autorisez-le dans les Réglages du téléphone.'**
  String get microRefuse;

  /// No description provided for @envoiMessageEchoue.
  ///
  /// In fr, this message translates to:
  /// **'Le message n\'a pas pu être envoyé. Réessayez.'**
  String get envoiMessageEchoue;

  /// No description provided for @nonLus.
  ///
  /// In fr, this message translates to:
  /// **'{n, plural, =1{1 message non lu} other{{n} messages non lus}}'**
  String nonLus(int n);

  /// No description provided for @rendezVous.
  ///
  /// In fr, this message translates to:
  /// **'Rendez-vous'**
  String get rendezVous;

  /// No description provided for @prochainRendezVous.
  ///
  /// In fr, this message translates to:
  /// **'Prochain rendez-vous'**
  String get prochainRendezVous;

  /// No description provided for @aucunRendezVous.
  ///
  /// In fr, this message translates to:
  /// **'Aucun rendez-vous prévu pour l\'instant. Votre coach vous proposera une date.'**
  String get aucunRendezVous;

  /// No description provided for @seancesSansAccompagnement.
  ///
  /// In fr, this message translates to:
  /// **'Vos rendez-vous apparaîtront ici une fois votre accompagnement commencé.'**
  String get seancesSansAccompagnement;

  /// No description provided for @planifierRendezVous.
  ///
  /// In fr, this message translates to:
  /// **'Planifier un rendez-vous'**
  String get planifierRendezVous;

  /// No description provided for @modifierRendezVous.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le rendez-vous'**
  String get modifierRendezVous;

  /// No description provided for @champDate.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get champDate;

  /// No description provided for @champHeure.
  ///
  /// In fr, this message translates to:
  /// **'Heure'**
  String get champHeure;

  /// No description provided for @champDuree.
  ///
  /// In fr, this message translates to:
  /// **'Durée'**
  String get champDuree;

  /// No description provided for @dureeMinutes.
  ///
  /// In fr, this message translates to:
  /// **'{n} min'**
  String dureeMinutes(int n);

  /// No description provided for @champLienZoom.
  ///
  /// In fr, this message translates to:
  /// **'Lien Zoom'**
  String get champLienZoom;

  /// No description provided for @champLienZoomAide.
  ///
  /// In fr, this message translates to:
  /// **'Collez le lien de la réunion Zoom (https://…)'**
  String get champLienZoomAide;

  /// No description provided for @lienZoomInvalide.
  ///
  /// In fr, this message translates to:
  /// **'Lien invalide : il doit commencer par https://'**
  String get lienZoomInvalide;

  /// No description provided for @rejoindreZoom.
  ///
  /// In fr, this message translates to:
  /// **'Rejoindre sur Zoom'**
  String get rejoindreZoom;

  /// No description provided for @lienZoomAVenir.
  ///
  /// In fr, this message translates to:
  /// **'Le lien Zoom sera ajouté par votre coach.'**
  String get lienZoomAVenir;

  /// No description provided for @lienImpossible.
  ///
  /// In fr, this message translates to:
  /// **'Impossible d\'ouvrir le lien.'**
  String get lienImpossible;

  /// No description provided for @rdvEnCours.
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get rdvEnCours;

  /// No description provided for @rdvAnnule.
  ///
  /// In fr, this message translates to:
  /// **'Annulé'**
  String get rdvAnnule;

  /// No description provided for @rdvFait.
  ///
  /// In fr, this message translates to:
  /// **'Fait'**
  String get rdvFait;

  /// No description provided for @rdvPasse.
  ///
  /// In fr, this message translates to:
  /// **'Passé'**
  String get rdvPasse;

  /// No description provided for @annulerRendezVous.
  ///
  /// In fr, this message translates to:
  /// **'Annuler le rendez-vous'**
  String get annulerRendezVous;

  /// No description provided for @confirmerAnnulationRdv.
  ///
  /// In fr, this message translates to:
  /// **'Annuler ce rendez-vous ? Les personnes accompagnées seront prévenues.'**
  String get confirmerAnnulationRdv;

  /// No description provided for @marquerSeanceFaite.
  ///
  /// In fr, this message translates to:
  /// **'Séance faite (−1 séance)'**
  String get marquerSeanceFaite;

  /// No description provided for @historique.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get historique;

  /// No description provided for @aVenir.
  ///
  /// In fr, this message translates to:
  /// **'À venir'**
  String get aVenir;

  /// No description provided for @agenda.
  ///
  /// In fr, this message translates to:
  /// **'Agenda'**
  String get agenda;

  /// No description provided for @agendaVide.
  ///
  /// In fr, this message translates to:
  /// **'Aucun rendez-vous à venir.'**
  String get agendaVide;

  /// No description provided for @rappelsAutomatiques.
  ///
  /// In fr, this message translates to:
  /// **'Rappel automatique la veille et 1 heure avant.'**
  String get rappelsAutomatiques;

  /// No description provided for @rendezVousEnregistre.
  ///
  /// In fr, this message translates to:
  /// **'Rendez-vous enregistré'**
  String get rendezVousEnregistre;

  /// No description provided for @dateDansLePasse.
  ///
  /// In fr, this message translates to:
  /// **'Choisissez une date à venir.'**
  String get dateDansLePasse;

  /// No description provided for @nonMerci.
  ///
  /// In fr, this message translates to:
  /// **'Non'**
  String get nonMerci;

  /// No description provided for @forfaits.
  ///
  /// In fr, this message translates to:
  /// **'Forfaits de séances'**
  String get forfaits;

  /// No description provided for @forfaitsAide.
  ///
  /// In fr, this message translates to:
  /// **'Payez par virement bancaire : les séances sont ajoutées dès que votre coach a reçu le paiement.'**
  String get forfaitsAide;

  /// No description provided for @nbSeancesForfait.
  ///
  /// In fr, this message translates to:
  /// **'{n, plural, =1{1 séance} other{{n} séances}}'**
  String nbSeancesForfait(int n);

  /// No description provided for @choisir.
  ///
  /// In fr, this message translates to:
  /// **'Choisir'**
  String get choisir;

  /// No description provided for @mesPaiements.
  ///
  /// In fr, this message translates to:
  /// **'Mes paiements'**
  String get mesPaiements;

  /// No description provided for @paiementEnAttente.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get paiementEnAttente;

  /// No description provided for @paiementRecu.
  ///
  /// In fr, this message translates to:
  /// **'Reçu'**
  String get paiementRecu;

  /// No description provided for @paiementAnnule.
  ///
  /// In fr, this message translates to:
  /// **'Annulé'**
  String get paiementAnnule;

  /// No description provided for @virementTitre.
  ///
  /// In fr, this message translates to:
  /// **'Paiement par virement'**
  String get virementTitre;

  /// No description provided for @virementAide.
  ///
  /// In fr, this message translates to:
  /// **'Scannez le QR code avec votre application bancaire, ou recopiez les informations ci-dessous. N\'oubliez pas la communication : elle permet d\'identifier votre paiement.'**
  String get virementAide;

  /// No description provided for @montant.
  ///
  /// In fr, this message translates to:
  /// **'Montant'**
  String get montant;

  /// No description provided for @beneficiaire.
  ///
  /// In fr, this message translates to:
  /// **'Bénéficiaire'**
  String get beneficiaire;

  /// No description provided for @iban.
  ///
  /// In fr, this message translates to:
  /// **'IBAN'**
  String get iban;

  /// No description provided for @bic.
  ///
  /// In fr, this message translates to:
  /// **'BIC'**
  String get bic;

  /// No description provided for @communicationStructuree.
  ///
  /// In fr, this message translates to:
  /// **'Communication structurée'**
  String get communicationStructuree;

  /// No description provided for @coordonneesIndisponibles.
  ///
  /// In fr, this message translates to:
  /// **'Les coordonnées bancaires ne sont pas encore disponibles. Écrivez à votre coach ou réessayez plus tard.'**
  String get coordonneesIndisponibles;

  /// No description provided for @paiementRecuMerci.
  ///
  /// In fr, this message translates to:
  /// **'Paiement reçu. Merci !'**
  String get paiementRecuMerci;

  /// No description provided for @paiementAttenteAide.
  ///
  /// In fr, this message translates to:
  /// **'Votre coach confirmera la réception du virement (en général 1 à 2 jours ouvrables).'**
  String get paiementAttenteAide;

  /// No description provided for @renoncerPaiement.
  ///
  /// In fr, this message translates to:
  /// **'Je ne paie pas finalement'**
  String get renoncerPaiement;

  /// No description provided for @faireUnDon.
  ///
  /// In fr, this message translates to:
  /// **'Faire un don'**
  String get faireUnDon;

  /// No description provided for @donAide.
  ///
  /// In fr, this message translates to:
  /// **'Votre don est libre et soutient ce ministère. Il ne donne accès à rien de plus : tous les contenus restent gratuits pour tous.'**
  String get donAide;

  /// No description provided for @autreMontant.
  ///
  /// In fr, this message translates to:
  /// **'Autre montant (€)'**
  String get autreMontant;

  /// No description provided for @montantInvalide.
  ///
  /// In fr, this message translates to:
  /// **'Entre 1 et 10 000 €'**
  String get montantInvalide;

  /// No description provided for @continuer.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get continuer;

  /// No description provided for @don.
  ///
  /// In fr, this message translates to:
  /// **'Don'**
  String get don;

  /// No description provided for @paiementsCoach.
  ///
  /// In fr, this message translates to:
  /// **'Paiements et dons'**
  String get paiementsCoach;

  /// No description provided for @aucunPaiement.
  ///
  /// In fr, this message translates to:
  /// **'Aucun paiement.'**
  String get aucunPaiement;

  /// No description provided for @confirmerReception.
  ///
  /// In fr, this message translates to:
  /// **'Paiement reçu'**
  String get confirmerReception;

  /// No description provided for @confirmerReceptionTexte.
  ///
  /// In fr, this message translates to:
  /// **'Confirmez-vous avoir reçu {montant} avec la communication {communication} ? Les séances du forfait seront ajoutées automatiquement.'**
  String confirmerReceptionTexte(String montant, String communication);

  /// No description provided for @totalRecuMois.
  ///
  /// In fr, this message translates to:
  /// **'Reçu ce mois-ci : {montant}'**
  String totalRecuMois(String montant);

  /// No description provided for @nouveauForfait.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau forfait'**
  String get nouveauForfait;

  /// No description provided for @modifierForfait.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le forfait'**
  String get modifierForfait;

  /// No description provided for @aucunForfait.
  ///
  /// In fr, this message translates to:
  /// **'Aucun forfait. Créez-en un pour que vos clients puissent payer leurs séances.'**
  String get aucunForfait;

  /// No description provided for @champNomForfait.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get champNomForfait;

  /// No description provided for @champNbSeances.
  ///
  /// In fr, this message translates to:
  /// **'Nombre de séances'**
  String get champNbSeances;

  /// No description provided for @champPrix.
  ///
  /// In fr, this message translates to:
  /// **'Prix (€)'**
  String get champPrix;

  /// No description provided for @forfaitActif.
  ///
  /// In fr, this message translates to:
  /// **'Proposé aux clients'**
  String get forfaitActif;

  /// No description provided for @nombreInvalide.
  ///
  /// In fr, this message translates to:
  /// **'Nombre invalide'**
  String get nombreInvalide;

  /// No description provided for @parametresCoach.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres du coach'**
  String get parametresCoach;

  /// No description provided for @parametresCoachAide.
  ///
  /// In fr, this message translates to:
  /// **'Ces coordonnées sont affichées aux personnes qui paient un forfait ou font un don.'**
  String get parametresCoachAide;

  /// No description provided for @champNomAffiche.
  ///
  /// In fr, this message translates to:
  /// **'Nom affiché'**
  String get champNomAffiche;

  /// No description provided for @champTitulaire.
  ///
  /// In fr, this message translates to:
  /// **'Titulaire du compte'**
  String get champTitulaire;

  /// No description provided for @champBicAide.
  ///
  /// In fr, this message translates to:
  /// **'Facultatif'**
  String get champBicAide;

  /// No description provided for @ibanInvalide.
  ///
  /// In fr, this message translates to:
  /// **'IBAN invalide : vérifiez les chiffres'**
  String get ibanInvalide;

  /// No description provided for @bicInvalide.
  ///
  /// In fr, this message translates to:
  /// **'BIC invalide (8 ou 11 caractères)'**
  String get bicInvalide;

  /// No description provided for @champMessageDon.
  ///
  /// In fr, this message translates to:
  /// **'Message de remerciement des dons'**
  String get champMessageDon;

  /// No description provided for @plus.
  ///
  /// In fr, this message translates to:
  /// **'Plus'**
  String get plus;

  /// No description provided for @mesLivres.
  ///
  /// In fr, this message translates to:
  /// **'Mes livres'**
  String get mesLivres;

  /// No description provided for @mesLivresAide.
  ///
  /// In fr, this message translates to:
  /// **'Les livres de votre coach'**
  String get mesLivresAide;

  /// No description provided for @aucunLivre.
  ///
  /// In fr, this message translates to:
  /// **'Aucun livre pour le moment.'**
  String get aucunLivre;

  /// No description provided for @formatPapier.
  ///
  /// In fr, this message translates to:
  /// **'Papier'**
  String get formatPapier;

  /// No description provided for @formatNumerique.
  ///
  /// In fr, this message translates to:
  /// **'Numérique'**
  String get formatNumerique;

  /// No description provided for @formatAudio.
  ///
  /// In fr, this message translates to:
  /// **'Livre audio'**
  String get formatAudio;

  /// No description provided for @disponibleEn.
  ///
  /// In fr, this message translates to:
  /// **'Disponible en : {langues}'**
  String disponibleEn(String langues);

  /// No description provided for @acheterSur.
  ///
  /// In fr, this message translates to:
  /// **'Acheter sur {boutique}'**
  String acheterSur(String boutique);

  /// No description provided for @lireExtrait.
  ///
  /// In fr, this message translates to:
  /// **'Lire un extrait'**
  String get lireExtrait;

  /// No description provided for @commanderAuCoach.
  ///
  /// In fr, this message translates to:
  /// **'Commander au coach'**
  String get commanderAuCoach;

  /// No description provided for @commanderAuCoachAide.
  ///
  /// In fr, this message translates to:
  /// **'Livre papier envoyé par la poste, payé par virement.'**
  String get commanderAuCoachAide;

  /// No description provided for @quantite.
  ///
  /// In fr, this message translates to:
  /// **'Quantité'**
  String get quantite;

  /// No description provided for @fraisEnvoi.
  ///
  /// In fr, this message translates to:
  /// **'Frais d\'envoi'**
  String get fraisEnvoi;

  /// No description provided for @total.
  ///
  /// In fr, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @adresseLivraison.
  ///
  /// In fr, this message translates to:
  /// **'Adresse de livraison'**
  String get adresseLivraison;

  /// No description provided for @champRue.
  ///
  /// In fr, this message translates to:
  /// **'Rue et numéro'**
  String get champRue;

  /// No description provided for @champCodePostal.
  ///
  /// In fr, this message translates to:
  /// **'Code postal'**
  String get champCodePostal;

  /// No description provided for @champVille.
  ///
  /// In fr, this message translates to:
  /// **'Ville'**
  String get champVille;

  /// No description provided for @champPays.
  ///
  /// In fr, this message translates to:
  /// **'Pays'**
  String get champPays;

  /// No description provided for @commander.
  ///
  /// In fr, this message translates to:
  /// **'Commander'**
  String get commander;

  /// No description provided for @commandeLivre.
  ///
  /// In fr, this message translates to:
  /// **'Commande de livre'**
  String get commandeLivre;

  /// No description provided for @mesCommandes.
  ///
  /// In fr, this message translates to:
  /// **'Mes commandes'**
  String get mesCommandes;

  /// No description provided for @commandeEnAttente.
  ///
  /// In fr, this message translates to:
  /// **'Paiement attendu'**
  String get commandeEnAttente;

  /// No description provided for @commandePayee.
  ///
  /// In fr, this message translates to:
  /// **'Payée'**
  String get commandePayee;

  /// No description provided for @commandeEnvoyee.
  ///
  /// In fr, this message translates to:
  /// **'Envoyée'**
  String get commandeEnvoyee;

  /// No description provided for @commandeAnnulee.
  ///
  /// In fr, this message translates to:
  /// **'Annulée'**
  String get commandeAnnulee;

  /// No description provided for @commandePayeeAide.
  ///
  /// In fr, this message translates to:
  /// **'Paiement reçu : votre livre sera envoyé très bientôt.'**
  String get commandePayeeAide;

  /// No description provided for @commandeEnvoyeeAide.
  ///
  /// In fr, this message translates to:
  /// **'Votre livre est en route. Bonne lecture !'**
  String get commandeEnvoyeeAide;

  /// No description provided for @numeroSuivi.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de suivi'**
  String get numeroSuivi;

  /// No description provided for @renoncerCommande.
  ///
  /// In fr, this message translates to:
  /// **'Annuler la commande'**
  String get renoncerCommande;

  /// No description provided for @livresCoach.
  ///
  /// In fr, this message translates to:
  /// **'Livres'**
  String get livresCoach;

  /// No description provided for @commandesLivres.
  ///
  /// In fr, this message translates to:
  /// **'Commandes'**
  String get commandesLivres;

  /// No description provided for @aucuneCommande.
  ///
  /// In fr, this message translates to:
  /// **'Aucune commande.'**
  String get aucuneCommande;

  /// No description provided for @nouveauLivre.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau livre'**
  String get nouveauLivre;

  /// No description provided for @modifierLivre.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le livre'**
  String get modifierLivre;

  /// No description provided for @couverture.
  ///
  /// In fr, this message translates to:
  /// **'Couverture'**
  String get couverture;

  /// No description provided for @choisirCouverture.
  ///
  /// In fr, this message translates to:
  /// **'Choisir une image'**
  String get choisirCouverture;

  /// No description provided for @champSousTitre.
  ///
  /// In fr, this message translates to:
  /// **'Sous-titre'**
  String get champSousTitre;

  /// No description provided for @languesDuLivre.
  ///
  /// In fr, this message translates to:
  /// **'Langues du livre'**
  String get languesDuLivre;

  /// No description provided for @formatsEtPrix.
  ///
  /// In fr, this message translates to:
  /// **'Formats et prix (€)'**
  String get formatsEtPrix;

  /// No description provided for @liensAchat.
  ///
  /// In fr, this message translates to:
  /// **'Liens d\'achat'**
  String get liensAchat;

  /// No description provided for @nomBoutique.
  ///
  /// In fr, this message translates to:
  /// **'Boutique (ex. Amazon)'**
  String get nomBoutique;

  /// No description provided for @adresseLien.
  ///
  /// In fr, this message translates to:
  /// **'Adresse (https://…)'**
  String get adresseLien;

  /// No description provided for @ajouterLien.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un lien'**
  String get ajouterLien;

  /// No description provided for @lienInvalide.
  ///
  /// In fr, this message translates to:
  /// **'Adresse invalide : elle doit commencer par https://'**
  String get lienInvalide;

  /// No description provided for @commandeDirecteOption.
  ///
  /// In fr, this message translates to:
  /// **'Commande directe du livre papier'**
  String get commandeDirecteOption;

  /// No description provided for @commandeDirecteAide.
  ///
  /// In fr, this message translates to:
  /// **'Les lecteurs vous commandent le livre et paient par virement ; vous l\'envoyez par la poste.'**
  String get commandeDirecteAide;

  /// No description provided for @champExtrait.
  ///
  /// In fr, this message translates to:
  /// **'Lien vers un extrait (facultatif)'**
  String get champExtrait;

  /// No description provided for @publierLivre.
  ///
  /// In fr, this message translates to:
  /// **'Publié'**
  String get publierLivre;

  /// No description provided for @prixPapierRequis.
  ///
  /// In fr, this message translates to:
  /// **'Indiquez le prix du livre papier'**
  String get prixPapierRequis;

  /// No description provided for @marquerPayee.
  ///
  /// In fr, this message translates to:
  /// **'Paiement reçu'**
  String get marquerPayee;

  /// No description provided for @marquerEnvoyee.
  ///
  /// In fr, this message translates to:
  /// **'Marquer envoyée'**
  String get marquerEnvoyee;

  /// No description provided for @aTraiter.
  ///
  /// In fr, this message translates to:
  /// **'À traiter'**
  String get aTraiter;

  /// No description provided for @cgu.
  ///
  /// In fr, this message translates to:
  /// **'Conditions d\'utilisation'**
  String get cgu;

  /// No description provided for @confidentialite.
  ///
  /// In fr, this message translates to:
  /// **'Confidentialité'**
  String get confidentialite;

  /// No description provided for @aideContact.
  ///
  /// In fr, this message translates to:
  /// **'Aide et contact'**
  String get aideContact;

  /// No description provided for @legalEnFrancais.
  ///
  /// In fr, this message translates to:
  /// **''**
  String get legalEnFrancais;

  /// No description provided for @langueApp.
  ///
  /// In fr, this message translates to:
  /// **'Langue de l\'application'**
  String get langueApp;

  /// No description provided for @langueTelephone.
  ///
  /// In fr, this message translates to:
  /// **'Langue du téléphone'**
  String get langueTelephone;

  /// No description provided for @mesDonnees.
  ///
  /// In fr, this message translates to:
  /// **'Mes données'**
  String get mesDonnees;

  /// No description provided for @telechargerMesDonnees.
  ///
  /// In fr, this message translates to:
  /// **'Télécharger mes données'**
  String get telechargerMesDonnees;

  /// No description provided for @exportEchoue.
  ///
  /// In fr, this message translates to:
  /// **'L\'export a échoué. Vérifiez votre connexion et réessayez.'**
  String get exportEchoue;

  /// No description provided for @supprimerMonCompte.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer mon compte'**
  String get supprimerMonCompte;

  /// No description provided for @supprimerCompteTexte.
  ///
  /// In fr, this message translates to:
  /// **'Votre compte, vos messages, vos réponses et votre progression seront définitivement supprimés. Si vous êtes accompagné en couple, votre conjoint garde l\'accompagnement. Les paiements sont conservés sans votre nom pour la comptabilité. Cette action est irréversible.'**
  String get supprimerCompteTexte;

  /// No description provided for @supprimerDefinitivement.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer définitivement'**
  String get supprimerDefinitivement;

  /// No description provided for @compteSupprime.
  ///
  /// In fr, this message translates to:
  /// **'Votre compte a été supprimé.'**
  String get compteSupprime;

  /// No description provided for @erreurCommandeEnCours.
  ///
  /// In fr, this message translates to:
  /// **'Un livre payé n\'a pas encore été envoyé : réessayez après sa réception.'**
  String get erreurCommandeEnCours;

  /// No description provided for @erreurCompteCoach.
  ///
  /// In fr, this message translates to:
  /// **'Le compte du coach ne peut pas être supprimé depuis l\'application.'**
  String get erreurCompteCoach;

  /// No description provided for @presentationCoach.
  ///
  /// In fr, this message translates to:
  /// **'Ma présentation'**
  String get presentationCoach;

  /// No description provided for @presentationCoachAide.
  ///
  /// In fr, this message translates to:
  /// **'Visible par tous sur l\'accueil, avec votre nom affiché et la photo de votre profil.'**
  String get presentationCoachAide;

  /// No description provided for @champBio.
  ///
  /// In fr, this message translates to:
  /// **'Présentation'**
  String get champBio;

  /// No description provided for @informationsLegales.
  ///
  /// In fr, this message translates to:
  /// **'Informations'**
  String get informationsLegales;

  /// No description provided for @contenusDepart.
  ///
  /// In fr, this message translates to:
  /// **'Contenus de départ'**
  String get contenusDepart;

  /// No description provided for @contenusDepartAide.
  ///
  /// In fr, this message translates to:
  /// **'Ajoute 30 méditations, 60 questions pour discuter à deux et 4 parcours, dans les 5 langues, déjà publiés. Vous pourrez tout modifier, dépublier ou supprimer. Vos contenus existants ne sont jamais remplacés.'**
  String get contenusDepartAide;

  /// No description provided for @charger.
  ///
  /// In fr, this message translates to:
  /// **'Charger'**
  String get charger;

  /// No description provided for @contenusDepartAjoutes.
  ///
  /// In fr, this message translates to:
  /// **'{n, plural, =0{Tout était déjà là : rien à ajouter.} =1{1 contenu ajouté.} other{{n} contenus ajoutés.}}'**
  String contenusDepartAjoutes(int n);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'nl', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'nl':
      return AppLocalizationsNl();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
