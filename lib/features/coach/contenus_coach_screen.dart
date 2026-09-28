import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import '../accompagnement/accompagnement_providers.dart';
import '../contenus/contenus_providers.dart';
import '../contenus/presentation/libelles.dart';

/// Charge les contenus de départ (après confirmation).
Future<void> _chargerDepart(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final messager = ScaffoldMessenger.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.contenusDepart),
      content: Text(l10n.contenusDepartAide),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.annuler),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.charger),
        ),
      ],
    ),
  );
  if (ok != true) return;
  try {
    final n = await ref.read(fonctionsCoachProvider).chargerContenusDeDepart();
    messager.showSnackBar(
      SnackBar(content: Text(l10n.contenusDepartAjoutes(n))),
    );
  } catch (_) {
    messager.showSnackBar(SnackBar(content: Text(l10n.erreurInconnue)));
  }
}

/// Coach : tous ses contenus, brouillons compris.
class ContenusCoachScreen extends ConsumerWidget {
  const ContenusCoachScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final contenus = ref.watch(tousContenusProvider).value ?? const [];
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.mesContenus),
        actions: [
          TextButton.icon(
            onPressed: () => context.push(Routes.parcoursCoach),
            icon: const Icon(Icons.route_outlined),
            label: Text(l10n.mesParcours),
          ),
          PopupMenuButton<void>(
            tooltip: l10n.plus,
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => _chargerDepart(context, ref),
                child: Text(l10n.contenusDepart),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.nouveauContenu),
        icon: const Icon(Icons.add),
        label: Text(l10n.nouveauContenu),
      ),
      body: contenus.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.aucunContenu, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () => _chargerDepart(context, ref),
                      icon: const Icon(Icons.auto_awesome),
                      label: Text(l10n.contenusDepart),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: contenus.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final c = contenus[i];
                return Card(
                  child: ListTile(
                    title: Text(c.titre('fr')),
                    subtitle: Text(
                      '${l10n.typeContenu(c.type)} · '
                      '${l10n.themeContenu(c.theme)}',
                    ),
                    trailing: Chip(
                      label: Text(c.publie ? l10n.publie : l10n.brouillon),
                      backgroundColor: c.publie
                          ? null
                          : theme.colorScheme.surfaceContainerHighest,
                    ),
                    onTap: () => context.push(Routes.modifierContenu(c.id)),
                  ),
                );
              },
            ),
    );
  }
}
