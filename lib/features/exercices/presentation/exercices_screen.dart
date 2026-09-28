import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../accompagnement/accompagnement_providers.dart';
import '../exercices_providers.dart';

/// Client : les exercices envoyés par le coach, à faire d'abord.
class ExercicesScreen extends ConsumerWidget {
  const ExercicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final acc = ref.watch(monAccompagnementProvider).value;
    final exercices =
        acc == null
              ? const []
              : [...?ref.watch(exercicesProvider(acc.id)).value]
          ..sort((a, b) => a.fait == b.fait ? 0 : (a.fait ? 1 : -1));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mesExercices)),
      body: exercices.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  l10n.aucunExercice,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: exercices.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final e = exercices[i];
                return Card(
                  child: ListTile(
                    leading: Icon(
                      e.fait ? Icons.check_circle : Icons.edit_note,
                      color: e.fait
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                    ),
                    title: Text(e.titre),
                    subtitle: Text(
                      e.fait ? l10n.exerciceFait : l10n.exerciceAFaire,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(Routes.exercice(e.id)),
                  ),
                );
              },
            ),
    );
  }
}
