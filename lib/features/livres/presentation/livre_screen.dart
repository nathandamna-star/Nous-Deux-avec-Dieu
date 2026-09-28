import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/services/lanceur.dart';
import '../../paiements/presentation/libelles_paiement.dart';
import '../livres_providers.dart';
import 'libelles_livres.dart';

/// Présentation d'un livre : formats, prix, liens d'achat externes et
/// commande directe du livre papier. Rien n'est lu ni vendu dans l'app.
class LivreScreen extends ConsumerWidget {
  const LivreScreen({super.key, required this.id, required this.base});

  final String id;
  final String base;

  Future<void> _ouvrir(BuildContext context, WidgetRef ref, String url) async {
    final messager = ScaffoldMessenger.of(context);
    final texte = AppLocalizations.of(context).lienImpossible;
    final ok = await ref.read(lanceurProvider).ouvrir(Uri.parse(url));
    if (!ok) messager.showSnackBar(SnackBar(content: Text(texte)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final l = ref.watch(livreProvider(id)).value;
    if (l == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.titre(langue))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(child: Couverture(url: l.couvertureUrl, largeur: 160)),
          const SizedBox(height: 16),
          Text(l.titre(langue), style: theme.textTheme.headlineSmall),
          if (l.sousTitre(langue).isNotEmpty)
            Text(l.sousTitre(langue), style: theme.textTheme.titleMedium),
          if (l.langues.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n.disponibleEn(
                  l.langues.map((x) => x.toUpperCase()).join(', '),
                ),
                style: theme.textTheme.bodySmall,
              ),
            ),
          const SizedBox(height: 12),
          if (l.description(langue).isNotEmpty) Text(l.description(langue)),
          const SizedBox(height: 16),
          for (final f in l.formats)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(l10n.format(f.type)),
              trailing: Text(
                euros(context, f.prix),
                style: theme.textTheme.titleMedium,
              ),
            ),
          if (l.extraitUrl.isNotEmpty)
            TextButton.icon(
              onPressed: () => _ouvrir(context, ref, l.extraitUrl),
              icon: const Icon(Icons.auto_stories_outlined),
              label: Text(l10n.lireExtrait),
            ),
          const SizedBox(height: 8),
          if (l.commandable) ...[
            FilledButton.icon(
              onPressed: () => context.push('$base/${l.id}/commander'),
              icon: const Icon(Icons.local_shipping_outlined),
              label: Text(l10n.commanderAuCoach),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 8),
              child: Text(
                l10n.commanderAuCoachAide,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          for (final lien in l.liens)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: OutlinedButton.icon(
                onPressed: () => _ouvrir(context, ref, lien.url),
                icon: const Icon(Icons.open_in_new),
                label: Text(l10n.acheterSur(lien.libelle)),
              ),
            ),
        ],
      ),
    );
  }
}
