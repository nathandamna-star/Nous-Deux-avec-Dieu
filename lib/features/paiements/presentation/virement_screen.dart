import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/paiement.dart';
import '../domain/virement.dart';
import '../paiements_providers.dart';
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
    final param = ref.watch(parametresCoachProvider).value;
    if (p == null || param == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.virementTitre)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    Widget ligne(String titre, String valeur, {bool copier = false}) =>
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(titre, style: theme.textTheme.bodySmall),
          subtitle: SelectableText(valeur, style: theme.textTheme.titleMedium),
          trailing: copier
              ? IconButton(
                  tooltip: l10n.copier,
                  icon: const Icon(Icons.copy),
                  onPressed: () async {
                    final messager = ScaffoldMessenger.of(context);
                    await Clipboard.setData(ClipboardData(text: valeur));
                    messager.showSnackBar(SnackBar(content: Text(l10n.copie)));
                  },
                )
              : null,
        );

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
          if (enAttente && !param.virementPossible)
            Text(l10n.coordonneesIndisponibles),
          if (enAttente && param.virementPossible) ...[
            Text(l10n.virementAide),
            const SizedBox(height: 16),
            Center(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: QrImageView(
                  data: codeEpc(
                    titulaire: param.titulaire,
                    iban: param.iban,
                    bic: param.bic,
                    montant: p.montant,
                    communication: p.communication,
                  ),
                  size: 220,
                  semanticsLabel: l10n.virementTitre,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ligne(l10n.montant, euros(context, p.montant)),
            ligne(l10n.beneficiaire, param.titulaire),
            ligne(l10n.iban, formaterIban(param.iban), copier: true),
            if (param.bic.isNotEmpty) ligne(l10n.bic, param.bic),
            ligne(
              l10n.communicationStructuree,
              formaterCommunication(p.communication),
              copier: true,
            ),
            const SizedBox(height: 8),
            Text(l10n.paiementAttenteAide, style: theme.textTheme.bodySmall),
          ],
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
