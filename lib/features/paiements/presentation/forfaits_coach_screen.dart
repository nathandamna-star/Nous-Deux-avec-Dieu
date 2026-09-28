import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../paiements_providers.dart';
import 'libelles_paiement.dart';

/// Coach : liste des forfaits de séances.
class ForfaitsCoachScreen extends ConsumerWidget {
  const ForfaitsCoachScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final forfaits = ref.watch(tousForfaitsProvider).value ?? const [];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.forfaits)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.nouveauForfait),
        icon: const Icon(Icons.add),
        label: Text(l10n.nouveauForfait),
      ),
      body: forfaits.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.aucunForfait, textAlign: TextAlign.center),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              children: [
                for (final f in forfaits)
                  Card(
                    child: ListTile(
                      leading: Icon(
                        f.actif ? Icons.sell_outlined : Icons.visibility_off,
                      ),
                      title: Text(f.nom(langue)),
                      subtitle: Text(
                        '${l10n.nbSeancesForfait(f.nbSeances)} · ${euros(context, f.prix)}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(Routes.modifierForfait(f.id)),
                    ),
                  ),
              ],
            ),
    );
  }
}
