import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/accompagnement/presentation/demande_screen.dart';
import '../../features/accompagnement/presentation/rejoindre_screen.dart';
import '../../features/accueil/accueil_screen.dart';
import '../../features/coach/contenus_coach_screen.dart';
import '../../features/coach/editeur_parcours_screen.dart';
import '../../features/coach/parcours_coach_screen.dart';
import '../../features/parcours/presentation/parcours_screen.dart';
import '../../features/coach/envoi_exercice_screen.dart';
import '../../features/coach/exercice_coach_screen.dart';
import '../../features/exercices/presentation/exercice_screen.dart';
import '../../features/messages/messagerie_providers.dart';
import '../../features/messages/presentation/conversation_screen.dart';
import '../../features/exercices/presentation/exercices_screen.dart';
import '../../features/coach/editeur_contenu_screen.dart';
import '../../features/coach/fiche_accompagnement_screen.dart';
import '../../features/contenus/presentation/contenu_screen.dart';
import '../../features/auth/auth_providers.dart';
import '../../features/auth/presentation/bienvenue_screen.dart';
import '../../features/auth/presentation/connexion_email_screen.dart';
import '../../features/coach/coach_screen.dart';
import '../../features/contenus/contenus_screen.dart';
import '../../features/messages/messages_screen.dart';
import '../../features/profil/profil_screen.dart';
import '../../features/paiements/presentation/don_screen.dart';
import '../../features/paiements/presentation/editeur_forfait_screen.dart';
import '../../features/paiements/presentation/forfaits_coach_screen.dart';
import '../../features/paiements/presentation/paiements_coach_screen.dart';
import '../../features/paiements/presentation/parametres_coach_screen.dart';
import '../../features/paiements/presentation/virement_screen.dart';
import '../../features/rendezvous/presentation/agenda_screen.dart';
import '../../features/rendezvous/presentation/editeur_rendez_vous_screen.dart';
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
  Routes.messages: [
    GoRoute(
      path: ':id',
      builder: (context, state) =>
          ConversationScreen(accId: state.pathParameters['id']!),
    ),
  ],
  Routes.accueil: [
    GoRoute(
      path: 'exercices',
      builder: (context, state) => const ExercicesScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) =>
              ExerciceScreen(id: state.pathParameters['id']!),
        ),
      ],
    ),
    GoRoute(
      path: 'contenu/:id',
      builder: (context, state) =>
          ContenuScreen(id: state.pathParameters['id']!),
    ),
  ],
  Routes.contenus: [
    GoRoute(
      path: 'parcours/:pid',
      builder: (context, state) =>
          ParcoursScreen(id: state.pathParameters['pid']!),
      routes: [
        GoRoute(
          path: 'etape/:id',
          builder: (context, state) => ContenuScreen(
            id: state.pathParameters['id']!,
            parcoursId: state.pathParameters['pid'],
          ),
        ),
      ],
    ),
    GoRoute(
      path: ':id',
      builder: (context, state) =>
          ContenuScreen(id: state.pathParameters['id']!),
    ),
  ],
  Routes.seances: [
    GoRoute(
      path: 'paiement/:id',
      builder: (context, state) =>
          VirementScreen(id: state.pathParameters['id']!),
    ),
  ],
  Routes.profil: [
    GoRoute(path: 'don', builder: (context, state) => const DonScreen()),
    GoRoute(
      path: 'paiement/:id',
      builder: (context, state) =>
          VirementScreen(id: state.pathParameters['id']!),
    ),
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
      path: 'parcours',
      builder: (context, state) => const ParcoursCoachScreen(),
      routes: [
        GoRoute(
          path: 'nouveau',
          builder: (context, state) => const EditeurParcoursScreen(),
        ),
        GoRoute(
          path: ':id',
          builder: (context, state) =>
              EditeurParcoursScreen(id: state.pathParameters['id']),
        ),
      ],
    ),
    GoRoute(
      path: 'contenus',
      builder: (context, state) => const ContenusCoachScreen(),
      routes: [
        GoRoute(
          path: 'nouveau',
          builder: (context, state) => const EditeurContenuScreen(),
        ),
        GoRoute(
          path: ':id',
          builder: (context, state) =>
              EditeurContenuScreen(id: state.pathParameters['id']),
        ),
      ],
    ),
    GoRoute(
      path: 'accompagnement/:id',
      builder: (context, state) =>
          FicheAccompagnementScreen(id: state.pathParameters['id']!),
      routes: [
        GoRoute(
          path: 'exercice',
          builder: (context, state) =>
              EnvoiExerciceScreen(accId: state.pathParameters['id']!),
          routes: [
            GoRoute(
              path: ':exId',
              builder: (context, state) => ExerciceCoachScreen(
                accId: state.pathParameters['id']!,
                id: state.pathParameters['exId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'rendezvous',
          builder: (context, state) => EditeurRendezVousScreen(
            accompagnementId: state.pathParameters['id']!,
          ),
          routes: [
            GoRoute(
              path: ':rdvId',
              builder: (context, state) => EditeurRendezVousScreen(
                accompagnementId: state.pathParameters['id']!,
                rendezVousId: state.pathParameters['rdvId'],
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: 'agenda', builder: (context, state) => const AgendaScreen()),
    GoRoute(
      path: 'paiements',
      builder: (context, state) => const PaiementsCoachScreen(),
    ),
    GoRoute(
      path: 'forfaits',
      builder: (context, state) => const ForfaitsCoachScreen(),
      routes: [
        GoRoute(
          path: 'nouveau',
          builder: (context, state) => const EditeurForfaitScreen(),
        ),
        GoRoute(
          path: ':id',
          builder: (context, state) =>
              EditeurForfaitScreen(id: state.pathParameters['id']),
        ),
      ],
    ),
    GoRoute(
      path: 'parametres',
      builder: (context, state) => const ParametresCoachScreen(),
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
    final nonLus = ref.watch(nbNonLusProvider);
    final onglets = [
      (
        const Icon(Icons.wb_sunny_outlined),
        const Icon(Icons.wb_sunny),
        l10n.navAccueil,
      ),
      (
        const Icon(Icons.auto_stories_outlined),
        const Icon(Icons.auto_stories),
        l10n.navContenus,
      ),
      (
        Badge(
          isLabelVisible: nonLus > 0,
          label: Text('$nonLus'),
          child: const Icon(Icons.chat_bubble_outline),
        ),
        const Icon(Icons.chat_bubble),
        l10n.navMessages,
      ),
      (
        const Icon(Icons.event_outlined),
        const Icon(Icons.event),
        l10n.navSeances,
      ),
      (
        const Icon(Icons.person_outline),
        const Icon(Icons.person),
        l10n.navProfil,
      ),
      if (coach)
        (
          const Icon(Icons.volunteer_activism_outlined),
          const Icon(Icons.volunteer_activism),
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
              icon: icone,
              selectedIcon: iconeActive,
              label: libelle,
            ),
        ],
      ),
    );
  }
}
