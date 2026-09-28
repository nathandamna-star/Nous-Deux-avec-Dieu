import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../paiements/presentation/instructions_virement.dart';
import '../../paiements/presentation/libelles_paiement.dart';
import '../domain/livre.dart';
import '../livres_providers.dart';
import 'libelles_livres.dart';

/// Suivi d'une commande de livre : virement à faire, payée, envoyée.
class CommandeLivreScreen extends ConsumerWidget {
  const CommandeLivreScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final c = ref.watch(commandeLivreProvider(id)).value;
    if (c == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.commandeLivre)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.commandeLivre)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${c.quantite} × ${c.livreTitre}',
            style: theme.textTheme.titleLarge,
          ),
          Text(euros(context, c.montant)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(iconeCommande(c.statut), color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(l10n.statutCommande(c.statut)),
            ],
          ),
          const SizedBox(height: 16),
          switch (c.statut) {
            StatutCommande.enAttente => InstructionsVirement(
              montant: c.montant,
              communication: c.id,
            ),
            StatutCommande.payee => Text(l10n.commandePayeeAide),
            StatutCommande.envoyee => Text(l10n.commandeEnvoyeeAide),
            StatutCommande.annulee => const SizedBox.shrink(),
          },
          if (c.numeroSuivi.isNotEmpty) ...[
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.numeroSuivi, style: theme.textTheme.bodySmall),
              subtitle: SelectableText(
                c.numeroSuivi,
                style: theme.textTheme.titleMedium,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Text(l10n.adresseLivraison, style: theme.textTheme.titleMedium),
          for (final ligne in c.adresse.lignes) Text(ligne),
          if (c.statut == StatutCommande.enAttente) ...[
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => ref
                  .read(livresRepositoryProvider)
                  .changerStatut(c.id, StatutCommande.annulee),
              child: Text(l10n.renoncerCommande),
            ),
          ],
        ],
      ),
    );
  }
}
