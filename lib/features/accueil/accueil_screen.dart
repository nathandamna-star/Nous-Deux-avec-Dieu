import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import '../auth/auth_providers.dart';
import '../contenus/contenus_providers.dart';
import '../contenus/domain/contenu.dart';

/// Accueil : salutation et méditation du jour.
class AccueilScreen extends ConsumerWidget {
  const AccueilScreen({super.key, this.aujourdhui});

  /// Date du jour (remplaçable dans les tests).
  final DateTime? aujourdhui;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final nom = ref.watch(profilProvider).value?.nom;
    final contenus = ref.watch(contenusPubliesProvider).value ?? const [];
    final meditation = meditationDuJour(contenus, aujourdhui ?? DateTime.now());

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (nom != null && nom.isNotEmpty)
            Text(l10n.bonjourNom(nom), style: theme.textTheme.headlineSmall),
          Text(
            l10n.accueilBienvenue,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          if (meditation != null)
            Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => context.push(Routes.contenuAccueil(meditation.id)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            color: theme.colorScheme.secondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.meditationDuJour,
                            style: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        meditation.titre(langue),
                        style: theme.textTheme.headlineSmall,
                      ),
                      if (meditation.reference.isNotEmpty)
                        Text(
                          meditation.reference,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        meditation.texte(langue),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          l10n.lire,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.go(Routes.contenus),
            icon: const Icon(Icons.auto_stories_outlined),
            label: Text(l10n.decouvrirContenus),
          ),
        ],
      ),
    );
  }
}
