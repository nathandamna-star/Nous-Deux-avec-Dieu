import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/auth_providers.dart';
import 'features/notifications/notifications_providers.dart';
import 'l10n/app_localizations.dart';

class NousDeuxAvecDieuApp extends ConsumerStatefulWidget {
  const NousDeuxAvecDieuApp({super.key});

  @override
  ConsumerState<NousDeuxAvecDieuApp> createState() =>
      _NousDeuxAvecDieuAppState();
}

class _NousDeuxAvecDieuAppState extends ConsumerState<NousDeuxAvecDieuApp> {
  @override
  void initState() {
    super.initState();
    // Toucher une notification ouvre le message ou l'exercice concerné.
    ref.read(notificationsServiceProvider).notificationsTouchees.listen((d) {
      final router = ref.read(routerProvider);
      if (d['exerciceId'] is String) {
        router.go(Routes.exercice(d['exerciceId'] as String));
      } else if (d['accompagnementId'] is String) {
        router.go(
          ref.read(estCoachProvider)
              ? Routes.conversation(d['accompagnementId'] as String)
              : Routes.messages,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Notifications activées pour chaque personne qui se connecte.
    ref.listen(utilisateurFirebaseProvider.select((u) => u.value?.uid), (
      avant,
      uid,
    ) {
      if (uid != null && uid != avant) {
        ref.read(notificationsServiceProvider).activer(uid);
      }
    });

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.clair,
      darkTheme: AppTheme.sombre,
      routerConfig: ref.watch(routerProvider),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // Français par défaut si la langue du téléphone n'est pas prise en charge.
      localeResolutionCallback: (locale, supportees) {
        for (final l in supportees) {
          if (l.languageCode == locale?.languageCode) return l;
        }
        return const Locale('fr');
      },
    );
  }
}
