import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/avatar.dart';
import '../../shared/widgets/connexion_requise.dart';
import '../accompagnement/accompagnement_providers.dart';
import '../accompagnement/presentation/carte_mon_accompagnement.dart';
import '../auth/auth_providers.dart';
import '../notifications/notifications_providers.dart';
import 'presentation/mes_donnees.dart';
import 'presentation/reglages.dart';
import 'profil_providers.dart';

class ProfilScreen extends ConsumerWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final user = ref.watch(utilisateurFirebaseProvider).value;
    if (user == null) {
      return ConnexionRequise(
        titre: l10n.navProfil,
        enBas: [const SizedBox(height: 24), ...reglages(context, ref)],
      );
    }
    final profil = ref.watch(profilProvider).value;
    final nom = profil?.nom ?? user.displayName ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navProfil)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              // Appui long : activation de l'espace coach (voir
              // functions/index.js, revendiquerCoach).
              onLongPress: ref.watch(estCoachProvider)
                  ? null
                  : () => _activerCoach(context, ref),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Semantics(
                        button: true,
                        label: l10n.changerPhoto,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => _changerPhoto(
                            context,
                            ref,
                            user.uid,
                            (profil?.photoUrl ?? '').isNotEmpty,
                          ),
                          child: Stack(
                            children: [
                              Avatar(
                                photoUrl: profil?.photoUrl,
                                nom: nom,
                                rayon: 44,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: theme.colorScheme.primary,
                                  child: Icon(
                                    Icons.photo_camera,
                                    size: 16,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
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
          ),
          if (!ref.watch(estCoachProvider)) ...[
            const SizedBox(height: 12),
            const CarteMonAccompagnement(),
            const SizedBox(height: 12),
            Card(
              child: ref.watch(donsDansAppProvider)
                  ? ListTile(
                      leading: const Icon(Icons.volunteer_activism_outlined),
                      title: Text(l10n.faireUnDon),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(Routes.don),
                    )
                  : ListTile(
                      leading: const Icon(Icons.volunteer_activism_outlined),
                      title: Text(l10n.donAilleurs),
                    ),
            ),
          ],
          const SizedBox(height: 12),
          ...reglages(context, ref),
          if (!ref.watch(estCoachProvider)) ...[
            const SizedBox(height: 12),
            const CarteMesDonnees(),
          ],
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () async {
              await ref.read(notificationsServiceProvider).desactiver(user.uid);
              await ref.read(authRepositoryProvider).deconnexion();
            },
            icon: const Icon(Icons.logout),
            label: Text(l10n.seDeconnecter),
          ),
        ],
      ),
    );
  }

  Future<void> _changerPhoto(
    BuildContext context,
    WidgetRef ref,
    String uid,
    bool aUnePhoto,
  ) async {
    final l10n = AppLocalizations.of(context);
    final choix = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.prendrePhoto),
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.choisirGalerie),
              onTap: () => Navigator.pop(context, 'galerie'),
            ),
            if (aUnePhoto)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: Text(l10n.supprimerPhoto),
                onTap: () => Navigator.pop(context, 'supprimer'),
              ),
          ],
        ),
      ),
    );
    if (choix == null || !context.mounted) return;
    final messager = ScaffoldMessenger.of(context);
    final service = ref.read(photoProfilServiceProvider);
    final repo = ref.read(authRepositoryProvider);
    try {
      if (choix == 'supprimer') {
        await service.supprimer(uid);
        await repo.definirPhoto(null);
      } else {
        final url = await service.choisirEtEnvoyer(
          uid,
          camera: choix == 'camera',
        );
        if (url != null) await repo.definirPhoto(url);
      }
    } catch (_) {
      messager.showSnackBar(SnackBar(content: Text(l10n.photoEnvoiEchoue)));
    }
  }

  Future<void> _activerCoach(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.activerCoachTitre),
        content: Text(l10n.activerCoachTexte),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.annuler),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.valider),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final messager = ScaffoldMessenger.of(context);
    try {
      await ref.read(fonctionsCoachProvider).revendiquerCoach();
      await ref.read(authRepositoryProvider).rafraichirJeton();
      messager.showSnackBar(SnackBar(content: Text(l10n.coachActive)));
    } catch (_) {
      messager.showSnackBar(SnackBar(content: Text(l10n.coachRefuse)));
    }
  }
}

/// Dons dans l'app : pas sur iPhone / iPad (règle 3.2.2 de l'App Store :
/// collecte réservée aux organismes caritatifs reconnus).
final donsDansAppProvider = Provider<bool>(
  (ref) =>
      kIsWeb ||
      (defaultTargetPlatform != TargetPlatform.iOS &&
          defaultTargetPlatform != TargetPlatform.macOS),
);
