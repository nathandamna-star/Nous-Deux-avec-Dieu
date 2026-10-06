import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/preferences/preferences.dart';
import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../auth_providers.dart';
import '../domain/parcours.dart';

/// Premier écran : ce que la personne vient chercher, puis connexion.
class BienvenueScreen extends ConsumerWidget {
  const BienvenueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final choix = ref.watch(parcoursSouhaiteProvider);

    Widget carte(Parcours p, IconData icone, String titre, String aide) {
      final actif = choix == p;
      return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: actif
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            width: actif ? 2 : 1,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          leading: Icon(icone, color: theme.colorScheme.primary),
          title: Text(titre, style: theme.textTheme.titleMedium),
          subtitle: Text(aide),
          trailing: actif
              ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
              : null,
          selected: actif,
          onTap: () => ref.read(parcoursSouhaiteProvider.notifier).choisir(p),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/logo/logo.png',
                    semanticLabel: l10n.appTitle,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.slogan,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),
                Text(l10n.bienvenueQuestion, style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                carte(
                  Parcours.couple,
                  Icons.favorite_outline,
                  l10n.parcoursCouple,
                  l10n.parcoursCoupleAide,
                ),
                const SizedBox(height: 8),
                carte(
                  Parcours.seul,
                  Icons.person_outline,
                  l10n.parcoursSeul,
                  l10n.parcoursSeulAide,
                ),
                const SizedBox(height: 8),
                carte(
                  Parcours.decouverte,
                  Icons.auto_stories_outlined,
                  l10n.parcoursDecouverte,
                  l10n.parcoursDecouverteAide,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => context.push(Routes.connexionEmail),
                  icon: const Icon(Icons.mail_outline),
                  label: Text(l10n.continuerEmail),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () async {
                    await ref.read(bienvenueVueProvider.notifier).marquer();
                    if (context.mounted) context.go(Routes.accueil);
                  },
                  child: Text(l10n.explorerSansCompte),
                ),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => context.push(Routes.legal('cgu')),
                      child: Text(l10n.cgu),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.push(Routes.legal('confidentialite')),
                      child: Text(l10n.confidentialite),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
