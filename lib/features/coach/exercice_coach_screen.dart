import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../accompagnement/accompagnement_providers.dart';
import '../exercices/domain/exercice.dart';
import '../exercices/exercices_providers.dart';

/// Coach : consignes d'un exercice et réponses des membres.
class ExerciceCoachScreen extends ConsumerWidget {
  const ExerciceCoachScreen({super.key, required this.accId, required this.id});

  final String accId;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final acc = ref.watch(accompagnementProvider(accId)).value;
    final e = ref.watch(exerciceProvider((acc: accId, id: id))).value;
    if (acc == null || e == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final cles = e.mode == ModeExercice.aDeux ? ['couple'] : acc.membres;

    Future<void> supprimer() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.supprimerExerciceTitre),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.annuler),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.supprimer),
            ),
          ],
        ),
      );
      if (ok != true) return;
      await ref.read(exercicesRepositoryProvider).supprimer(accId, id);
      if (context.mounted) context.pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(e.titre),
        actions: [
          IconButton(
            tooltip: l10n.supprimer,
            icon: const Icon(Icons.delete_outline),
            onPressed: supprimer,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Chip(
            label: Text(
              e.mode == ModeExercice.aDeux ? l10n.modeADeux : l10n.modeSeul,
            ),
          ),
          const SizedBox(height: 8),
          Text(e.consignes, style: theme.textTheme.bodyLarge),
          const Divider(height: 32),
          for (final cle in cles) ...[
            Text(
              cle == 'couple' ? l10n.reponseCommune : acc.noms[cle] ?? '',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SelectableText(
                  ref
                          .watch(
                            reponseProvider((acc: accId, id: id, cle: cle)),
                          )
                          .value
                          ?.texte ??
                      l10n.pasEncoreRepondu,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
