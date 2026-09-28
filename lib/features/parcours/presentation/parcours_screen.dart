import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/auth_providers.dart';
import '../../contenus/contenus_providers.dart';
import '../../contenus/presentation/libelles.dart';
import '../parcours_providers.dart';

/// Un parcours : ses étapes dans l'ordre, cochées une fois faites.
class ParcoursScreen extends ConsumerWidget {
  const ParcoursScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final p = ref.watch(parcoursProvider(id)).value;
    if (p == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final progression = ref.watch(progressionProvider(id)).value;
    final faits = progression?.nbFaits(p) ?? 0;
    final prochaine = progression?.prochaine(p);
    final connecte = ref.watch(estConnecteProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.parcours)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(p.titre(langue), style: theme.textTheme.headlineMedium),
          if (p.description(langue).isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(p.description(langue), style: theme.textTheme.bodyLarge),
          ],
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: p.etapes.isEmpty ? 0 : faits / p.etapes.length,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.etapesFaites(faits, p.etapes.length),
            style: theme.textTheme.bodySmall,
          ),
          if (!connecte)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                l10n.connexionPourSuivre,
                style: theme.textTheme.bodySmall,
              ),
            ),
          const SizedBox(height: 12),
          if (p.etapes.isNotEmpty)
            prochaine == null
                ? Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.emoji_events_outlined,
                        color: theme.colorScheme.secondary,
                      ),
                      title: Text(l10n.parcoursTermine),
                    ),
                  )
                : FilledButton.icon(
                    onPressed: () =>
                        context.push(Routes.etapeParcours(p.id, prochaine)),
                    icon: const Icon(Icons.play_arrow),
                    label: Text(
                      faits == 0
                          ? l10n.commencerParcours
                          : l10n.continuerParcours,
                    ),
                  ),
          const SizedBox(height: 16),
          for (final (i, contenuId) in p.etapes.indexed)
            Builder(
              builder: (context) {
                final c = ref.watch(contenuProvider(contenuId)).value;
                if (c == null) return const SizedBox.shrink();
                final fait = progression?.faits.contains(contenuId) ?? false;
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: fait
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary.withValues(alpha: 0.12),
                      foregroundColor: fait
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.primary,
                      child: fait ? const Icon(Icons.check) : Text('${i + 1}'),
                    ),
                    title: Text(c.titre(langue)),
                    subtitle: Text(
                      '${l10n.etapeNumero(i + 1)} · ${l10n.typeContenu(c.type)}',
                    ),
                    onTap: () =>
                        context.push(Routes.etapeParcours(p.id, contenuId)),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
