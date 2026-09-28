import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/virement.dart';
import '../paiements_providers.dart';
import 'libelles_paiement.dart';

/// QR code de virement, IBAN, montant et communication structurée, avec
/// boutons pour copier. Utilisé pour les forfaits, les dons et les livres.
class InstructionsVirement extends ConsumerWidget {
  const InstructionsVirement({
    super.key,
    required this.montant,
    required this.communication,
  });

  final double montant;
  final String communication;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final param = ref.watch(parametresCoachProvider).value;
    if (param == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!param.virementPossible) return Text(l10n.coordonneesIndisponibles);

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                montant: montant,
                communication: communication,
              ),
              size: 220,
              semanticsLabel: l10n.virementTitre,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ligne(l10n.montant, euros(context, montant)),
        ligne(l10n.beneficiaire, param.titulaire),
        ligne(l10n.iban, formaterIban(param.iban), copier: true),
        if (param.bic.isNotEmpty) ligne(l10n.bic, param.bic),
        ligne(
          l10n.communicationStructuree,
          formaterCommunication(communication),
          copier: true,
        ),
        const SizedBox(height: 8),
        Text(l10n.paiementAttenteAide, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
