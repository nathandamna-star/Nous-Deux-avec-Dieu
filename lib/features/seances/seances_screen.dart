import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/widgets/connexion_requise.dart';
import '../accompagnement/accompagnement_providers.dart';
import '../auth/auth_providers.dart';
import '../paiements/presentation/section_forfaits.dart';
import '../rendezvous/presentation/carte_rendez_vous.dart';
import '../rendezvous/rendez_vous_providers.dart';

/// Onglet Séances : rendez-vous à venir (avec Zoom), séances restantes et
/// historique.
class SeancesScreen extends ConsumerWidget {
  const SeancesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    if (!ref.watch(estConnecteProvider)) {
      return ConnexionRequise(titre: l10n.navSeances);
    }
    final acc = ref.watch(monAccompagnementProvider).value;
    Widget vide(String texte) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        texte,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );

    if (acc == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.navSeances)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: vide(l10n.seancesSansAccompagnement),
        ),
      );
    }
    final maintenant = ref.watch(horlogeProvider)();
    final tous = ref.watch(rendezVousProvider(acc.id)).value ?? const [];
    final aVenir = tous.where((r) => r.aVenir(maintenant)).toList();
    final passes = tous.where((r) => !r.aVenir(maintenant)).toList().reversed;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSeances)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.confirmation_number_outlined),
              title: Text(l10n.seancesRestantes(acc.seancesRestantes)),
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.aVenir, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          if (aVenir.isEmpty) vide(l10n.aucunRendezVous),
          for (final r in aVenir) CarteRendezVous(rdv: r),
          if (aVenir.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n.rappelsAutomatiques,
                style: theme.textTheme.bodySmall,
              ),
            ),
          if (passes.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(l10n.historique, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final r in passes) CarteRendezVous(rdv: r),
          ],
          ...sectionForfaits(context, ref, acc),
        ],
      ),
    );
  }
}
