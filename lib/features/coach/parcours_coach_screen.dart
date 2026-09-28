import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import '../parcours/parcours_providers.dart';

/// Coach : tous ses parcours, brouillons compris.
class ParcoursCoachScreen extends ConsumerWidget {
  const ParcoursCoachScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final liste = ref.watch(tousParcoursProvider).value ?? const [];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.mesParcours)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.nouveauParcours),
        icon: const Icon(Icons.add),
        label: Text(l10n.nouveauParcours),
      ),
      body: liste.isEmpty
          ? Center(child: Text(l10n.aucunParcours))
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              itemCount: liste.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final p = liste[i];
                return Card(
                  child: ListTile(
                    title: Text(p.titre('fr')),
                    subtitle: Text(l10n.nbEtapes(p.etapes.length)),
                    trailing: Chip(
                      label: Text(p.publie ? l10n.publie : l10n.brouillon),
                    ),
                    onTap: () => context.push(Routes.modifierParcours(p.id)),
                  ),
                );
              },
            ),
    );
  }
}
