import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/paiement.dart';
import '../paiements_providers.dart';
import 'instructions_virement.dart';
import 'libelles_paiement.dart';

/// Instructions de virement d'un paiement : QR code EPC, IBAN,
/// communication structurée, et état du paiement.
class VirementScreen extends ConsumerWidget {
  const VirementScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final p = ref.watch(paiementProvider(id)).value;
    if (p == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.virementTitre)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final enAttente = p.statut == StatutPaiement.enAttente;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.virementTitre)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.objetPaiement(p), style: theme.textTheme.titleLarge),
          if (p.type == TypePaiement.forfait)
            Text(l10n.nbSeancesForfait(p.nbSeances)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(iconeStatut(p.statut), color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(l10n.statutPaiement(p.statut)),
            ],
          ),
          const SizedBox(height: 16),
          if (p.statut == StatutPaiement.recu)
            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: Text(l10n.paiementRecuMerci),
              ),
            ),
          if (enAttente)
            InstructionsVirement(
              montant: p.montant,
              communication: p.communication,
            ),
          if (enAttente) ...[
            const SizedBox(height: 24),
            TextButton(
              onPressed: () =>
                  ref.read(paiementsRepositoryProvider).annuler(p.id),
              child: Text(l10n.renoncerPaiement),
            ),
          ],
        ],
      ),
    );
  }
}
