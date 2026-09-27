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
}
