import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../paiements/domain/virement.dart';
import '../../paiements/presentation/libelles_paiement.dart';
import '../domain/livre.dart';
import '../livres_providers.dart';
import 'libelles_livres.dart';

enum _Vue { livres, commandes }

/// Coach : ses livres et les commandes de livres papier.
class LivresCoachScreen extends ConsumerStatefulWidget {
  const LivresCoachScreen({super.key});

  @override
  ConsumerState<LivresCoachScreen> createState() => _LivresCoachScreenState();
}

class _LivresCoachScreenState extends ConsumerState<LivresCoachScreen> {
  late var _vue = ref.read(nbCommandesATraiterProvider) > 0
      ? _Vue.commandes
      : _Vue.livres;

  Future<void> _envoyer(CommandeLivre c) async {
    final suivi = await showDialog<String>(
      context: context,
      builder: (context) => const _DialogueEnvoi(),
    );
    if (suivi == null) return;
    await ref
        .read(livresRepositoryProvider)
        .changerStatut(c.id, StatutCommande.envoyee, numeroSuivi: suivi);
  }

  Widget _commande(CommandeLivre c) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final repo = ref.read(livresRepositoryProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(c.nom, style: theme.textTheme.titleMedium),
                ),
                Text(
                  euros(context, c.montant),
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            Text('${c.quantite} × ${c.livreTitre}'),
            Text(
              '${l10n.statutCommande(c.statut)} · '
              '${formaterCommunication(c.id)}',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            for (final ligne in c.adresse.lignes) Text(ligne),
            if (c.numeroSuivi.isNotEmpty)
              Text('${l10n.numeroSuivi} : ${c.numeroSuivi}'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (c.statut == StatutCommande.enAttente)
                  FilledButton.icon(
                    onPressed: () =>
                        repo.changerStatut(c.id, StatutCommande.payee),
                    icon: const Icon(Icons.check),
                    label: Text(l10n.marquerPayee),
                  ),
                if (c.statut == StatutCommande.payee)
                  FilledButton.icon(
                    onPressed: () => _envoyer(c),
                    icon: const Icon(Icons.local_shipping_outlined),
                    label: Text(l10n.marquerEnvoyee),
                  ),
                if (c.statut == StatutCommande.enAttente ||
                    c.statut == StatutCommande.payee)
                  OutlinedButton(
                    onPressed: () =>
                        repo.changerStatut(c.id, StatutCommande.annulee),
                    child: Text(l10n.annuler),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final livres = ref.watch(tousLivresProvider).value ?? const [];
    final commandes =
        ref.watch(toutesCommandesLivresProvider).value ?? const [];
    final aTraiter = ref.watch(nbCommandesATraiterProvider);
    // Commandes à traiter d'abord, puis les autres.
    final triees = [
      ...commandes.where(
        (c) =>
            c.statut == StatutCommande.enAttente ||
            c.statut == StatutCommande.payee,
      ),
      ...commandes.where(
        (c) =>
            c.statut == StatutCommande.envoyee ||
            c.statut == StatutCommande.annulee,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mesLivres)),
      floatingActionButton: _vue == _Vue.livres
          ? FloatingActionButton.extended(
              onPressed: () => context.push(Routes.nouveauLivre),
              icon: const Icon(Icons.add),
              label: Text(l10n.nouveauLivre),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          SegmentedButton<_Vue>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: _Vue.livres, label: Text(l10n.livresCoach)),
              ButtonSegment(
                value: _Vue.commandes,
                label: Badge(
                  isLabelVisible: aTraiter > 0,
                  label: Text('$aTraiter'),
                  child: Text(l10n.commandesLivres),
                ),
              ),
            ],
            selected: {_vue},
            onSelectionChanged: (s) => setState(() => _vue = s.first),
          ),
          const SizedBox(height: 12),
          if (_vue == _Vue.livres) ...[
            if (livres.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.aucunLivre, textAlign: TextAlign.center),
              ),
            for (final l in livres)
              Card(
                child: ListTile(
                  leading: Couverture(url: l.couvertureUrl, largeur: 36),
                  title: Text(l.titre(langue)),
                  subtitle: Text(l.publie ? l10n.publierLivre : l10n.brouillon),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(Routes.modifierLivre(l.id)),
                ),
              ),
          ] else ...[
            if (triees.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.aucuneCommande, textAlign: TextAlign.center),
              ),
            for (final c in triees) _commande(c),
          ],
        ],
      ),
    );
  }
}

/// Confirmation de l'envoi, avec numéro de suivi facultatif.
class _DialogueEnvoi extends StatefulWidget {
  const _DialogueEnvoi();

  @override
  State<_DialogueEnvoi> createState() => _DialogueEnvoiState();
}

class _DialogueEnvoiState extends State<_DialogueEnvoi> {
  final _suivi = TextEditingController();

  @override
  void dispose() {
    _suivi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.marquerEnvoyee),
      content: TextField(
        controller: _suivi,
        decoration: InputDecoration(
          labelText: l10n.numeroSuivi,
          helperText: l10n.champBicAide,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.annuler),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _suivi.text),
          child: Text(l10n.valider),
        ),
      ],
    );
  }
}
