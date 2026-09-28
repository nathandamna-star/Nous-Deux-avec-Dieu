import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import '../accompagnement/accompagnement_providers.dart';
import '../auth/auth_providers.dart';
import '../coach/presentation_coach_screen.dart';
import '../contenus/contenus_providers.dart';
import '../contenus/domain/contenu.dart';
import '../exercices/exercices_providers.dart';
import '../livres/livres_providers.dart';
import '../rendezvous/presentation/carte_rendez_vous.dart';
import '../rendezvous/rendez_vous_providers.dart';

/// Accueil : salutation et méditation du jour.
class AccueilScreen extends ConsumerWidget {
  const AccueilScreen({super.key, this.aujourdhui});

  /// Date du jour (remplaçable dans les tests).
  final DateTime? aujourdhui;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final nom = ref.watch(profilProvider).value?.nom;
    final contenus = ref.watch(contenusPubliesProvider).value ?? const [];
    final meditation = meditationDuJour(contenus, aujourdhui ?? DateTime.now());

    final acc = ref.watch(monAccompagnementProvider).value;
    final aFaire = acc == null
        ? 0
        : (ref.watch(exercicesProvider(acc.id)).value ?? const [])
              .where((e) => !e.fait)
              .length;
    final maintenant = ref.watch(horlogeProvider)();
    final prochain = acc == null
        ? null
        : (ref.watch(rendezVousProvider(acc.id)).value ?? const [])
              .where((r) => r.aVenir(maintenant))
              .firstOrNull;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (nom != null && nom.isNotEmpty)
            Text(l10n.bonjourNom(nom), style: theme.textTheme.headlineSmall),
          Text(
            l10n.accueilBienvenue,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          const CarteCoach(),
          if (prochain != null) ...[
            Text(l10n.prochainRendezVous, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            CarteRendezVous(
              rdv: prochain,
              onTap: () => context.go(Routes.seances),
            ),
            const SizedBox(height: 12),
          ],
          if (acc != null) ...[
            Card(
              child: ListTile(
                leading: Badge(
                  isLabelVisible: aFaire > 0,
                  label: Text('$aFaire'),
                  child: const Icon(Icons.edit_note),
                ),
                title: Text(l10n.mesExercices),
                subtitle: Text(l10n.exercicesAFaire(aFaire)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(Routes.exercices),
              ),
            ),
            const SizedBox(height: 12),
          ],
          if ((ref.watch(livresPubliesProvider).value ?? const [])
              .isNotEmpty) ...[
            Card(
              child: ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: Text(l10n.mesLivres),
                subtitle: Text(l10n.mesLivresAide),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(Routes.livresAccueil),
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (meditation != null)
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => context.push(Routes.contenuAccueil(meditation.id)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            color: theme.colorScheme.secondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.meditationDuJour,
                            style: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        meditation.titre(langue),
                        style: theme.textTheme.headlineSmall,
                      ),
                      if (meditation.reference.isNotEmpty)
                        Text(
                          meditation.reference,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        meditation.texte(langue),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          l10n.lire,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.go(Routes.contenus),
            icon: const Icon(Icons.auto_stories_outlined),
            label: Text(l10n.decouvrirContenus),
          ),
        ],
      ),
    );
  }
}
