import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../accompagnement/accompagnement_providers.dart';
import '../domain/rendez_vous.dart';
import '../rendez_vous_providers.dart';

/// Menu du coach sur un rendez-vous prévu : modifier, séance faite, annuler.
class MenuRendezVous extends ConsumerWidget {
  const MenuRendezVous({super.key, required this.rdv});

  final RendezVous rdv;

  Future<void> _annuler(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.annulerRendezVous),
        content: Text(l10n.confirmerAnnulationRdv),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.nonMerci),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.annulerRendezVous),
          ),
        ],
      ),
    );
    if (ok == true) await ref.read(rendezVousRepositoryProvider).annuler(rdv);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (rdv.statut != StatutRendezVous.prevu) return const SizedBox.shrink();
    return PopupMenuButton<String>(
      onSelected: (choix) async {
        switch (choix) {
          case 'modifier':
            context.push(
              Routes.modifierRendezVous(rdv.accompagnementId, rdv.id),
            );
          case 'fait':
            final acc = ref
                .read(accompagnementProvider(rdv.accompagnementId))
                .value;
            await ref
                .read(rendezVousRepositoryProvider)
                .marquerFaite(rdv, acc?.seancesRestantes ?? 0);
          case 'annuler':
            await _annuler(context, ref);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'modifier', child: Text(l10n.modifierRendezVous)),
        PopupMenuItem(value: 'fait', child: Text(l10n.marquerSeanceFaite)),
        PopupMenuItem(value: 'annuler', child: Text(l10n.annulerRendezVous)),
      ],
    );
  }
}
