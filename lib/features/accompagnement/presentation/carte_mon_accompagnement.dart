import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../accompagnement_providers.dart';
import 'libelles.dart';

/// Profil : l'accompagnement en cours, ou les boutons pour en demander un.
class CarteMonAccompagnement extends ConsumerWidget {
  const CarteMonAccompagnement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final asynchrone = ref.watch(monAccompagnementProvider);
    final a = asynchrone.value;
    if (asynchrone.isLoading && a == null) return const SizedBox.shrink();

    if (a == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.monAccompagnement, style: theme.textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(l10n.demanderAccompagnementAide),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => context.push(Routes.demande),
                icon: const Icon(Icons.favorite_outline),
                label: Text(l10n.demanderAccompagnement),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => context.push(Routes.rejoindre),
                icon: const Icon(Icons.key_outlined),
                label: Text(l10n.jAiUnCode),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.monAccompagnement, style: theme.textTheme.labelLarge),
            const SizedBox(height: 4),
            Text(a.nom, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text(l10n.statutAccompagnement(a.statut))),
                Chip(label: Text(l10n.seancesRestantes(a.seancesRestantes))),
              ],
            ),
            if (a.attendConjoint && a.codeInvitation != null) ...[
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.codePourConjoint(a.codeInvitation!),
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.copier,
                    icon: const Icon(Icons.copy),
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(text: a.codeInvitation!),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(l10n.copie)));
                      }
                    },
                  ),
                ],
              ),
              Text(l10n.codePourConjointAide, style: theme.textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
