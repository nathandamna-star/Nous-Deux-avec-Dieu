import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/avatar.dart';
import '../paiements/paiements_providers.dart';

/// Carte « Votre coach » de l'accueil (masquée tant que le coach ne s'est
/// pas présenté).
class CarteCoach extends ConsumerWidget {
  const CarteCoach({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final p = ref.watch(presentationCoachProvider).value;
    if (p == null || p.vide) return const SizedBox.shrink();
    final bio = p.bio(Localizations.localeOf(context).languageCode);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: ListTile(
          leading: Avatar(photoUrl: p.photoUrl, nom: p.nomAffiche),
          title: Text(p.nomAffiche),
          subtitle: Text(
            bio.isEmpty ? l10n.votreCoach : bio,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push(Routes.presentationCoach),
        ),
      ),
    );
  }
}

/// Présentation complète du coach.
class PresentationCoachScreen extends ConsumerWidget {
  const PresentationCoachScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final p = ref.watch(presentationCoachProvider).value;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.votreCoach)),
      body: p == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Center(
                  child: Avatar(
                    photoUrl: p.photoUrl,
                    nom: p.nomAffiche,
                    rayon: 56,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  p.nomAffiche,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                SelectableText(
                  p.bio(Localizations.localeOf(context).languageCode),
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
    );
  }
}
