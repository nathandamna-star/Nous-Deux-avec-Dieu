import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/widgets/connexion_requise.dart';
import '../auth/auth_providers.dart';

class ProfilScreen extends ConsumerWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final user = ref.watch(utilisateurFirebaseProvider).value;
    if (user == null) return ConnexionRequise(titre: l10n.navProfil);
    final profil = ref.watch(profilProvider).value;
    final nom = profil?.nom ?? user.displayName ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProfil)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.bonjourNom(nom),
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email ?? '',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (ref.watch(estCoachProvider)) ...[
                    const SizedBox(height: 12),
                    Chip(label: Text(l10n.roleCoach)),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => ref.read(authRepositoryProvider).deconnexion(),
            icon: const Icon(Icons.logout),
            label: Text(l10n.seDeconnecter),
          ),
        ],
      ),
    );
  }
}
