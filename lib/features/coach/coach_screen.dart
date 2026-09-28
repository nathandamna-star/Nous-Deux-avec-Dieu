import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import '../accompagnement/accompagnement_providers.dart';
import '../accompagnement/domain/accompagnement.dart';
import '../accompagnement/presentation/libelles.dart';

enum _Filtre { demandes, actifs, termines }

/// Onglet Coach : tous les accompagnements, par état.
class CoachScreen extends ConsumerStatefulWidget {
  const CoachScreen({super.key});

  @override
  ConsumerState<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends ConsumerState<CoachScreen> {
  var _filtre = _Filtre.demandes;

  bool _garde(Accompagnement a) => switch (_filtre) {
    _Filtre.demandes => a.statut == StatutAccompagnement.demande,
    _Filtre.actifs =>
      a.statut == StatutAccompagnement.actif ||
          a.statut == StatutAccompagnement.enPause,
    _Filtre.termines => a.statut == StatutAccompagnement.termine,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final tous = ref.watch(tousAccompagnementsProvider);
    final liste = (tous.value ?? const []).where(_garde).toList();
    final nbDemandes = (tous.value ?? const [])
        .where((a) => a.statut == StatutAccompagnement.demande)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navCoach),
        actions: [
          IconButton(
            tooltip: l10n.agenda,
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () => context.push(Routes.agenda),
          ),
          TextButton.icon(
            onPressed: () => context.push(Routes.contenusCoach),
            icon: const Icon(Icons.edit_note),
            label: Text(l10n.mesContenus),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SegmentedButton<_Filtre>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: _Filtre.demandes,
                  label: Badge(
                    isLabelVisible: nbDemandes > 0,
                    label: Text('$nbDemandes'),
                    offset: const Offset(14, -6),
                    child: Text(l10n.filtreDemandes),
                  ),
                ),
                ButtonSegment(
                  value: _Filtre.actifs,
                  label: Text(l10n.filtreActifs),
                ),
                ButtonSegment(
                  value: _Filtre.termines,
                  label: Text(l10n.filtreTermines),
                ),
              ],
              selected: {_filtre},
              onSelectionChanged: (s) => setState(() => _filtre = s.first),
            ),
          ),
          Expanded(
            child: tous.isLoading && tous.value == null
                ? const Center(child: CircularProgressIndicator())
                : liste.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        l10n.aucunAccompagnement,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: liste.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final a = liste[i];
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            a.type == TypeAccompagnement.couple
                                ? Icons.favorite_outline
                                : Icons.person_outline,
                            color: theme.colorScheme.primary,
                          ),
                          title: Text(a.nom),
                          subtitle: Text(
                            [
                              l10n.statutAccompagnement(a.statut),
                              if (a.attendConjoint) l10n.attendConjoint,
                              l10n.seancesRestantes(a.seancesRestantes),
                            ].join(' · '),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () =>
                              context.push(Routes.ficheAccompagnement(a.id)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
