import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/accompagnement/presentation/demande_screen.dart';
import '../../features/accompagnement/presentation/rejoindre_screen.dart';
import '../../features/accueil/accueil_screen.dart';
import '../../features/coach/fiche_accompagnement_screen.dart';
import '../../features/auth/auth_providers.dart';
import '../../features/auth/presentation/bienvenue_screen.dart';
import '../../features/auth/presentation/connexion_email_screen.dart';
import '../../features/coach/coach_screen.dart';
import '../../features/contenus/contenus_screen.dart';
import '../../features/messages/messages_screen.dart';
import '../../features/profil/profil_screen.dart';
import '../../features/seances/seances_screen.dart';
import '../../l10n/app_localizations.dart';
import '../preferences/preferences.dart';
import 'routes.dart';

export 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Relance les redirections quand la connexion ou le rôle change.
  final rafraichir = ValueNotifier(0);
  ref.listen(estConnecteProvider, (_, _) => rafraichir.value++);
  ref.listen(estCoachProvider, (_, _) => rafraichir.value++);
  ref.listen(bienvenueVueProvider, (_, _) => rafraichir.value++);
  ref.onDispose(rafraichir.dispose);

  return GoRouter(
    initialLocation: Routes.accueil,
    refreshListenable: rafraichir,
    redirect: (context, state) {
      final lieu = state.matchedLocation;
      final connecte = ref.read(estConnecteProvider);
      final surBienvenue = lieu.startsWith(Routes.bienvenue);
      // Une fois connecté, on quitte les écrans de connexion.
      if (connecte && surBienvenue) return Routes.accueil;
      // Premier lancement : écran de bienvenue.
      if (!connecte && !surBienvenue && !ref.read(bienvenueVueProvider)) {
        return Routes.bienvenue;
      }
      // Onglet Coach réservé au coach.
      if (lieu.startsWith(Routes.coach) && !ref.read(estCoachProvider)) {
        return Routes.accueil;
      }
      return null;
    },
    onException: (context, state, router) => router.go(Routes.accueil),
    routes: [
      GoRoute(
        path: Routes.bienvenue,
        builder: (context, state) => const BienvenueScreen(),
        routes: [
          GoRoute(
            path: 'email',
            builder: (context, state) => const ConnexionEmailScreen(),
          ),
        ],
      ),
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
                GoRoute(
                  path: chemin,
                  builder: (context, state) => ecran,
                  routes: _sousRoutes[chemin] ?? const [],
                ),
              ],
            ),
        ],
      ),
    ],
  );
});

final _sousRoutes = <String, List<RouteBase>>{
  Routes.profil: [
    GoRoute(
      path: 'demande',
      builder: (context, state) => const DemandeScreen(),
    ),
    GoRoute(
      path: 'rejoindre',
      builder: (context, state) => const RejoindreScreen(),
    ),
  ],
  Routes.coach: [
    GoRoute(
      path: 'accompagnement/:id',
      builder: (context, state) =>
          FicheAccompagnementScreen(id: state.pathParameters['id']!),
    ),
  ],
};

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
