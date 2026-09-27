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
}
