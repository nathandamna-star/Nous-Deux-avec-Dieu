import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../accompagnement/accompagnement_providers.dart';
import '../accompagnement/domain/accompagnement.dart';
import '../accompagnement/presentation/libelles.dart';

/// Fiche d'un accompagnement (coach) : membres, statut, séances, notes privées.
class FicheAccompagnementScreen extends ConsumerStatefulWidget {
  const FicheAccompagnementScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<FicheAccompagnementScreen> createState() =>
      _FicheAccompagnementScreenState();
}

class _FicheAccompagnementScreenState
    extends ConsumerState<FicheAccompagnementScreen> {
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _ajouterNote() async {
    final texte = _note.text.trim();
    if (texte.isEmpty) return;
    _note.clear();
    await ref
        .read(accompagnementRepositoryProvider)
        .ajouterNote(widget.id, texte);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final repo = ref.read(accompagnementRepositoryProvider);
    final a = ref.watch(accompagnementProvider(widget.id)).value;
    if (a == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final notes = ref.watch(notesProvider(widget.id)).value ?? const [];
    final format = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).add_Hm();

    Widget action(StatutAccompagnement cible, String libelle, IconData icone) =>
        OutlinedButton.icon(
          onPressed: () => repo.changerStatut(a.id, cible),
          icon: Icon(icone),
          label: Text(libelle),
        );

    return Scaffold(
      appBar: AppBar(title: Text(a.nom)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Chip(label: Text(l10n.statutAccompagnement(a.statut))),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: switch (a.statut) {
              StatutAccompagnement.demande => [
                FilledButton.icon(
                  onPressed: () =>
                      repo.changerStatut(a.id, StatutAccompagnement.actif),
                  icon: const Icon(Icons.check),
                  label: Text(l10n.accepter),
                ),
              ],
              StatutAccompagnement.actif => [
                action(
                  StatutAccompagnement.enPause,
                  l10n.mettreEnPause,
                  Icons.pause,
                ),
                action(
                  StatutAccompagnement.termine,
                  l10n.terminer,
                  Icons.flag_outlined,
                ),
              ],
              StatutAccompagnement.enPause || StatutAccompagnement.termine => [
                action(
                  StatutAccompagnement.actif,
                  l10n.reprendre,
                  Icons.play_arrow,
                ),
              ],
            },
          ),
          const Divider(height: 32),
          Text(l10n.membres, style: theme.textTheme.titleMedium),
          for (final uid in a.membres)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person_outline),
              title: Text(a.noms[uid] ?? ''),
            ),
          if (a.attendConjoint)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.hourglass_empty),
              title: Text(l10n.attendConjoint),
            ),
          if (a.message.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(l10n.messageDemande, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(a.message),
          ],
          const Divider(height: 32),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.seancesRestantes(a.seancesRestantes),
                  style: theme.textTheme.titleMedium,
                ),
              ),
              IconButton.outlined(
                tooltip: l10n.retirerSeance,
                icon: const Icon(Icons.remove),
                onPressed: a.seancesRestantes == 0
                    ? null
                    : () => repo.definirSeances(a.id, a.seancesRestantes - 1),
              ),
              const SizedBox(width: 8),
              IconButton.outlined(
                tooltip: l10n.ajouterSeance,
                icon: const Icon(Icons.add),
                onPressed: () =>
                    repo.definirSeances(a.id, a.seancesRestantes + 1),
              ),
            ],
          ),
          const Divider(height: 32),
          Text(l10n.notesPrivees, style: theme.textTheme.titleMedium),
          Text(l10n.notesPriveesAide, style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          TextField(
            controller: _note,
            decoration: InputDecoration(
              labelText: l10n.nouvelleNote,
              suffixIcon: IconButton(
                tooltip: l10n.ajouter,
                icon: const Icon(Icons.send),
                onPressed: _ajouterNote,
              ),
            ),
            minLines: 1,
            maxLines: 6,
          ),
          const SizedBox(height: 8),
          if (notes.isEmpty)
            Text(
              l10n.aucuneNote,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          for (final n in notes)
            Card(
              child: ListTile(
                title: Text(n.texte),
                subtitle: n.createdAt == null
                    ? null
                    : Text(format.format(n.createdAt!)),
                trailing: IconButton(
                  tooltip: l10n.supprimer,
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => repo.supprimerNote(a.id, n.id),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
