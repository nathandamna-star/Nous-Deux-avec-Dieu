import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../rendezvous/rendez_vous_providers.dart';
import '../domain/paiement.dart';
import '../domain/virement.dart';
import '../paiements_providers.dart';
import 'libelles_paiement.dart';

/// Coach : paiements annoncés à confirmer, reçus, annulés ; total du mois.
class PaiementsCoachScreen extends ConsumerStatefulWidget {
  const PaiementsCoachScreen({super.key});

  @override
  ConsumerState<PaiementsCoachScreen> createState() =>
      _PaiementsCoachScreenState();
}

class _PaiementsCoachScreenState extends ConsumerState<PaiementsCoachScreen> {
  var _filtre = StatutPaiement.enAttente;

  Future<void> _confirmer(Paiement p) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmerReception),
        content: Text(
          l10n.confirmerReceptionTexte(
            euros(context, p.montant),
            formaterCommunication(p.communication),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.annuler),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.valider),
          ),
        ],
      ),
    );
    if (ok == true) await ref.read(paiementsRepositoryProvider).confirmer(p.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final tous = ref.watch(tousPaiementsProvider).value ?? const [];
    final maintenant = ref.watch(horlogeProvider)();
    final totalMois = tous
        .where(
          (p) =>
              p.statut == StatutPaiement.recu &&
              p.confirmeLe != null &&
              p.confirmeLe!.year == maintenant.year &&
              p.confirmeLe!.month == maintenant.month,
        )
        .fold<double>(0, (s, p) => s + p.montant);
    final liste = tous.where((p) => p.statut == _filtre).toList();
    final format = DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.paiementsCoach)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.totalRecuMois(euros(context, totalMois)),
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SegmentedButton<StatutPaiement>(
            showSelectedIcon: false,
            segments: [
              for (final s in StatutPaiement.values)
                ButtonSegment(value: s, label: Text(l10n.statutPaiement(s))),
            ],
            selected: {_filtre},
            onSelectionChanged: (s) => setState(() => _filtre = s.first),
          ),
          const SizedBox(height: 12),
          if (liste.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(l10n.aucunPaiement, textAlign: TextAlign.center),
            ),
          for (final p in liste)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            p.nom,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          euros(context, p.montant),
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Text(
                      [
                        l10n.objetPaiement(p),
                        if (p.createdAt != null) format.format(p.createdAt!),
                      ].join(' · '),
                    ),
                    SelectableText(formaterCommunication(p.communication)),
                    if (p.statut == StatutPaiement.enAttente) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          FilledButton.icon(
                            onPressed: () => _confirmer(p),
                            icon: const Icon(Icons.check),
                            label: Text(l10n.confirmerReception),
                          ),
                          OutlinedButton(
                            onPressed: () => ref
                                .read(paiementsRepositoryProvider)
                                .annuler(p.id),
                            child: Text(l10n.annuler),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
