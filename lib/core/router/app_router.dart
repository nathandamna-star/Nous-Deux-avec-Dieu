import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/accueil/accueil_screen.dart';
import '../../features/auth/auth_providers.dart';
import '../../features/coach/coach_screen.dart';
import '../../features/contenus/contenus_screen.dart';
import '../../features/messages/messages_screen.dart';
import '../../features/profil/profil_screen.dart';
import '../../features/seances/seances_screen.dart';
import '../../l10n/app_localizations.dart';
import 'routes.dart';

export 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.accueil,
    // Onglet Coach réservé au coach.
    redirect: (context, state) =>
        state.matchedLocation.startsWith(Routes.coach) &&
            !ref.read(estCoachProvider)
        ? Routes.accueil
        : null,
    onException: (context, state, router) => router.go(Routes.accueil),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _Coquille(shell: shell),
        branches: [
          for (final (chemin, ecran) in [
            (Routes.accueil, const AccueilScreen()),
            (Routes.contenus, const ContenusScreen()),
            (Routes.messages, const MessagesScreen()),
            (Routes.seances, const SeancesScreen()),
            (Routes.profil, const ProfilScreen()),
            (Routes.coach, const CoachScreen()),
          ])
            StatefulShellBranch(
              routes: [
                GoRoute(path: chemin, builder: (context, state) => ecran),
              ],
            ),
        ],
      ),
    ],
  );
});

/// Barre de navigation du bas ; l'onglet Coach n'apparaît que pour le coach.
class _Coquille extends ConsumerWidget {
  const _Coquille({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final coach = ref.watch(estCoachProvider);
    final onglets = [
      (Icons.wb_sunny_outlined, Icons.wb_sunny, l10n.navAccueil),
      (Icons.auto_stories_outlined, Icons.auto_stories, l10n.navContenus),
      (Icons.chat_bubble_outline, Icons.chat_bubble, l10n.navMessages),
      (Icons.event_outlined, Icons.event, l10n.navSeances),
      (Icons.person_outline, Icons.person, l10n.navProfil),
      if (coach)
        (
          Icons.volunteer_activism_outlined,
          Icons.volunteer_activism,
          l10n.navCoach,
        ),
    ];
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex.clamp(0, onglets.length - 1),
        onDestinationSelected: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        destinations: [
          for (final (icone, iconeActive, libelle) in onglets)
            NavigationDestination(
              icon: Icon(icone),
              selectedIcon: Icon(iconeActive),
              label: libelle,
            ),
        ],
      ),
    );
  }
}
