import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../paiements/presentation/libelles_paiement.dart';
import '../livres_providers.dart';
import 'libelles_livres.dart';

/// « Mes livres » : les livres publiés par le coach et les commandes de la
/// personne. [base] : adresse de cet écran (depuis l'Accueil ou les Contenus).
class LivresScreen extends ConsumerWidget {
  const LivresScreen({super.key, required this.base});

  final String base;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final livres = ref.watch(livresPubliesProvider);
    final commandes = ref.watch(mesCommandesLivresProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mesLivres)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.mesLivresAide,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          if (livres.isLoading)
            const Center(child: CircularProgressIndicator())
          else if ((livres.value ?? const []).isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(l10n.aucunLivre, textAlign: TextAlign.center),
            ),
          for (final l in livres.value ?? const [])
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => context.push('$base/${l.id}'),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Couverture(url: l.couvertureUrl),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l.titre(langue),
                              style: theme.textTheme.titleMedium,
                            ),
                            if (l.sousTitre(langue).isNotEmpty)
                              Text(l.sousTitre(langue)),
                            const SizedBox(height: 4),
                            Text(
                              [for (final f in l.formats) l10n.format(f.type)]
                                  .join(' · '),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          if (commandes.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(l10n.mesCommandes, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final c in commandes)
              Card(
                child: ListTile(
                  leading: Icon(iconeCommande(c.statut)),
                  title: Text('${c.quantite} × ${c.livreTitre}'),
                  subtitle: Text(
                    '${euros(context, c.montant)} · ${l10n.statutCommande(c.statut)}',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('$base/commande/${c.id}'),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
