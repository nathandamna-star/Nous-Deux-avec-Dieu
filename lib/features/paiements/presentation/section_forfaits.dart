import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../accompagnement/domain/accompagnement.dart';
import '../../auth/auth_providers.dart';
import '../domain/paiement.dart';
import '../paiements_providers.dart';
import 'libelles_paiement.dart';

/// Onglet Séances : forfaits à acheter et paiements de la personne.
List<Widget> sectionForfaits(
  BuildContext context,
  WidgetRef ref,
  Accompagnement acc,
) {
  final l10n = AppLocalizations.of(context);
  final theme = Theme.of(context);
  final langue = Localizations.localeOf(context).languageCode;
  final forfaits = ref.watch(forfaitsActifsProvider).value ?? const [];
  final paiements = ref.watch(mesPaiementsProvider).value ?? const [];

  Future<void> acheter(Forfait f) async {
    final user = ref.read(utilisateurFirebaseProvider).value;
    if (user == null) return;
    final nom = ref.read(profilProvider).value?.nom ?? user.displayName ?? '';
    final id = await ref
        .read(paiementsRepositoryProvider)
        .acheterForfait(
          uid: user.uid,
          nom: nom,
          accompagnementId: acc.id,
          forfait: f,
          langue: langue,
        );
    if (context.mounted) context.push(Routes.paiementSeances(id));
  }

  return [
    if (forfaits.isNotEmpty) ...[
      const SizedBox(height: 24),
      Text(l10n.forfaits, style: theme.textTheme.titleMedium),
      Text(l10n.forfaitsAide, style: theme.textTheme.bodySmall),
      const SizedBox(height: 8),
      for (final f in forfaits)
        Card(
          child: ListTile(
            title: Text(f.nom(langue)),
            subtitle: Text(
              '${l10n.nbSeancesForfait(f.nbSeances)} · ${euros(context, f.prix)}',
            ),
            trailing: FilledButton.tonal(
              onPressed: () => acheter(f),
              child: Text(l10n.choisir),
            ),
          ),
        ),
    ],
    if (paiements.isNotEmpty) ...[
      const SizedBox(height: 24),
      Text(l10n.mesPaiements, style: theme.textTheme.titleMedium),
      const SizedBox(height: 8),
      for (final p in paiements)
        Card(
          child: ListTile(
            leading: Icon(iconeStatut(p.statut)),
            title: Text(l10n.objetPaiement(p)),
            subtitle: Text(
              '${euros(context, p.montant)} · ${l10n.statutPaiement(p.statut)}',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.paiementSeances(p.id)),
          ),
        ),
    ],
  ];
}
