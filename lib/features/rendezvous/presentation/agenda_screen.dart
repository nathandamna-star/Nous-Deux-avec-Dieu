import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../rendez_vous_providers.dart';
import 'carte_rendez_vous.dart';
import 'menu_rendez_vous.dart';

/// Agenda du coach : tous les rendez-vous à venir, du plus proche au plus loin.
class AgendaScreen extends ConsumerWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final maintenant = ref.watch(horlogeProvider)();
    final aVenir = (ref.watch(agendaProvider).value ?? const [])
        .where((r) => r.aVenir(maintenant))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.agenda)),
      body: aVenir.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.agendaVide, textAlign: TextAlign.center),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final r in aVenir)
                  CarteRendezVous(
                    rdv: r,
                    afficherNom: true,
                    actions: MenuRendezVous(rdv: r),
                    onTap: () => context.push(
                      Routes.ficheAccompagnement(r.accompagnementId),
                    ),
                  ),
              ],
            ),
    );
  }
}
