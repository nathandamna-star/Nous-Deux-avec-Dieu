import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/services/lanceur.dart';
import '../domain/rendez_vous.dart';
import '../rendez_vous_providers.dart';

/// « lundi 12 octobre · 19:00 », dans la langue de l'app.
String dateRendezVous(BuildContext context, DateTime d) {
  final langue = Localizations.localeOf(context).toLanguageTag();
  return '${DateFormat.MMMMEEEEd(langue).format(d)} · '
      '${DateFormat.Hm(langue).format(d)}';
}

/// Ouvre le lien Zoom ; message si le téléphone ne peut pas l'ouvrir.
Future<void> ouvrirZoom(
  BuildContext context,
  WidgetRef ref,
  String lien,
) async {
  final messager = ScaffoldMessenger.of(context);
  final texte = AppLocalizations.of(context).lienImpossible;
  final ok = await ref.read(lanceurProvider).ouvrir(Uri.parse(lien));
  if (!ok) messager.showSnackBar(SnackBar(content: Text(texte)));
}

/// Un rendez-vous : date, durée, état et bouton Zoom s'il est à venir.
class CarteRendezVous extends ConsumerWidget {
  const CarteRendezVous({
    super.key,
    required this.rdv,
    this.afficherNom = false,
    this.onTap,
    this.actions,
  });

  final RendezVous rdv;

  /// Agenda du coach : le nom de l'accompagnement est affiché.
  final bool afficherNom;
  final VoidCallback? onTap;

  /// Menu du coach (modifier, annuler, séance faite).
  final Widget? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final maintenant = ref.watch(horlogeProvider)();
    final aVenir = rdv.aVenir(maintenant);
    final etat = switch (rdv.statut) {
      StatutRendezVous.annule => l10n.rdvAnnule,
      StatutRendezVous.fait => l10n.rdvFait,
      StatutRendezVous.prevu when !aVenir => l10n.rdvPasse,
      StatutRendezVous.prevu when !rdv.debut.isAfter(maintenant) =>
        l10n.rdvEnCours,
      StatutRendezVous.prevu => null,
    };

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    rdv.statut == StatutRendezVous.annule
                        ? Icons.event_busy
                        : Icons.videocam_outlined,
                    color: aVenir
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (afficherNom)
                          Text(rdv.nom, style: theme.textTheme.titleMedium),
                        Text(
                          dateRendezVous(context, rdv.debut),
                          style: afficherNom
                              ? theme.textTheme.bodyMedium
                              : theme.textTheme.titleMedium,
                        ),
                        Text(
                          [l10n.dureeMinutes(rdv.dureeMin), ?etat].join(' · '),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ?actions,
                ],
              ),
              if (aVenir) ...[
                const SizedBox(height: 12),
                if (rdv.lienZoom.isEmpty)
                  Text(l10n.lienZoomAVenir, style: theme.textTheme.bodySmall)
                else if (rdv.imminent(maintenant))
                  FilledButton.icon(
                    onPressed: () => ouvrirZoom(context, ref, rdv.lienZoom),
                    icon: const Icon(Icons.videocam),
                    label: Text(l10n.rejoindreZoom),
                  )
                else
                  OutlinedButton.icon(
                    onPressed: () => ouvrirZoom(context, ref, rdv.lienZoom),
                    icon: const Icon(Icons.videocam_outlined),
                    label: Text(l10n.rejoindreZoom),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
