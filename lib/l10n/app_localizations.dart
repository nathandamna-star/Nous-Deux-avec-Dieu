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

  /// No description provided for @messagesAVenir.
  ///
  /// In fr, this message translates to:
  /// **'Ici : votre conversation avec votre coach.'**
  String get messagesAVenir;

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
