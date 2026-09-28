import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/preferences/langue.dart';
import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/auth_providers.dart';

/// Langue de l'app et pages d'information (avec ou sans compte).
List<Widget> reglages(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context);
  final langue = ref.watch(langueAppProvider);

  Future<void> choisirLangue() async {
    final choix = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.langueApp),
        children: [
          for (final (code, nom) in [
            ('', l10n.langueTelephone),
            for (final l in LangueApp.disponibles) (l, LangueApp.noms[l]!),
          ])
            ListTile(
              title: Text(nom),
              trailing: (langue ?? '') == code ? const Icon(Icons.check) : null,
              onTap: () => Navigator.pop(context, code),
            ),
        ],
      ),
    );
    if (choix == null) return;
    await ref
        .read(langueAppProvider.notifier)
        .definir(choix.isEmpty ? null : choix);
    // Langue des notifications envoyées par le serveur.
    final uid = ref.read(utilisateurFirebaseProvider).value?.uid;
    final effective = choix.isEmpty
        ? WidgetsBinding.instance.platformDispatcher.locale.languageCode
        : choix;
    if (uid != null && LangueApp.disponibles.contains(effective)) {
      try {
        await ref.read(firestoreProvider).doc('users/$uid').update({
          'langue': effective,
        });
      } catch (_) {
        // Profil pas encore créé : la langue sera enregistrée plus tard.
      }
    }
  }

  ListTile lien(IconData icone, String titre, String page) => ListTile(
    leading: Icon(icone),
    title: Text(titre),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => context.push(Routes.legal(page)),
  );

  return [
    Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.translate),
            title: Text(l10n.langueApp),
            subtitle: Text(
              langue == null ? l10n.langueTelephone : LangueApp.noms[langue]!,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: choisirLangue,
          ),
          lien(Icons.help_outline, l10n.aideContact, 'support'),
          lien(Icons.description_outlined, l10n.cgu, 'cgu'),
          lien(
            Icons.privacy_tip_outlined,
            l10n.confidentialite,
            'confidentialite',
          ),
        ],
      ),
    ),
  ];
}
