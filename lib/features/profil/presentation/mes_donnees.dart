import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/services/partage.dart';
import '../../auth/auth_providers.dart';
import '../../notifications/notifications_providers.dart';
import '../data/compte_service.dart';
import '../profil_providers.dart';

/// RGPD : télécharger ses données et supprimer son compte.
class CarteMesDonnees extends ConsumerStatefulWidget {
  const CarteMesDonnees({super.key});

  @override
  ConsumerState<CarteMesDonnees> createState() => _CarteMesDonneesState();
}

class _CarteMesDonneesState extends ConsumerState<CarteMesDonnees> {
  var _occupe = false;

  String _erreur(AppLocalizations l10n, Object e) => switch (e) {
    ErreurCompte(code: 'commande-en-cours') => l10n.erreurCommandeEnCours,
    ErreurCompte(code: 'compte-coach') => l10n.erreurCompteCoach,
    ErreurCompte(code: 'reseau') => l10n.erreurReseau,
    _ => l10n.erreurInconnue,
  };

  Future<void> _exporter() async {
    final l10n = AppLocalizations.of(context);
    final messager = ScaffoldMessenger.of(context);
    setState(() => _occupe = true);
    try {
      final json = await ref.read(compteServiceProvider).exporterMesDonnees();
      await ref
          .read(partageProvider)
          .partagerFichier(
            nom: 'mes-donnees-nous-deux-avec-dieu.json',
            contenu: json,
            typeMime: 'application/json',
          );
    } catch (_) {
      messager.showSnackBar(SnackBar(content: Text(l10n.exportEchoue)));
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  Future<void> _supprimer() async {
    final l10n = AppLocalizations.of(context);
    final messager = ScaffoldMessenger.of(context);
    final routeur = GoRouter.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.supprimerMonCompte),
        content: Text(l10n.supprimerCompteTexte),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.annuler),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.supprimerDefinitivement),
          ),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _occupe = true);
    final uid = ref.read(utilisateurFirebaseProvider).value?.uid;
    try {
      if (uid != null) {
        await ref.read(notificationsServiceProvider).desactiver(uid);
      }
      await ref.read(compteServiceProvider).supprimerMonCompte();
      await ref.read(authRepositoryProvider).deconnexion();
      messager
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.compteSupprime)));
      routeur.go(Routes.bienvenue);
    } catch (e) {
      messager
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(_erreur(l10n, e))));
      if (mounted) setState(() => _occupe = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final erreur = Theme.of(context).colorScheme.error;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(
              l10n.mesDonnees,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.download_outlined),
            title: Text(l10n.telechargerMesDonnees),
            enabled: !_occupe,
            onTap: _exporter,
          ),
          ListTile(
            leading: Icon(Icons.delete_forever_outlined, color: erreur),
            title: Text(
              l10n.supprimerMonCompte,
              style: TextStyle(color: erreur),
            ),
            enabled: !_occupe,
            onTap: _supprimer,
          ),
          if (_occupe) const LinearProgressIndicator(),
        ],
      ),
    );
  }
}
