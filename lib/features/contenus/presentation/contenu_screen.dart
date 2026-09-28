import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/auth_providers.dart';
import '../../parcours/parcours_providers.dart';
import '../contenus_providers.dart';
import '../domain/contenu.dart';
import 'lecteurs/lecteurs.dart';
import 'libelles.dart';

/// Lecture d'un contenu, dans la langue de l'app si elle existe.
class ContenuScreen extends ConsumerWidget {
  const ContenuScreen({super.key, required this.id, this.parcoursId});

  final String id;

  /// Ouvert depuis un parcours : bouton « Marquer comme fait ».
  final String? parcoursId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final c = ref.watch(contenuProvider(id)).value;
    if (c == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.typeContenu(c.type))),
      body: SelectionArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              l10n.themeContenu(c.theme).toUpperCase(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(c.titre(langue), style: theme.textTheme.headlineMedium),
            if (c.reference.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                c.reference,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
            if (c.manque(langue)) ...[
              const SizedBox(height: 12),
              Text(l10n.autreLangue, style: theme.textTheme.bodySmall),
            ],
            if (c.type.estMedia && c.media(langue).isNotEmpty) ...[
              const SizedBox(height: 20),
              if (c.type == TypeContenu.audio)
                ref
                    .read(fabriqueLecteursProvider)
                    .audio(url: c.media(langue), cle: '${c.id}:$langue')
              else
                ref
                    .read(fabriqueLecteursProvider)
                    .video(url: c.media(langue), cle: '${c.id}:$langue'),
            ],
            const SizedBox(height: 20),
            Text(
              c.texte(langue),
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
            ),
            if (parcoursId != null) ...[
              const SizedBox(height: 32),
              _BoutonFait(parcoursId: parcoursId!, contenuId: id),
            ],
          ],
        ),
      ),
    );
  }
}

class _BoutonFait extends ConsumerWidget {
  const _BoutonFait({required this.parcoursId, required this.contenuId});

  final String parcoursId;
  final String contenuId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final uid = ref.watch(utilisateurFirebaseProvider).value?.uid;
    if (uid == null) {
      return Text(
        l10n.connexionPourSuivre,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }
    final fait =
        ref
            .watch(progressionProvider(parcoursId))
            .value
            ?.faits
            .contains(contenuId) ??
        false;
    final repo = ref.read(parcoursRepositoryProvider);
    return fait
        ? OutlinedButton.icon(
            onPressed: () => repo.marquer(uid, parcoursId, contenuId, false),
            icon: const Icon(Icons.check_circle),
            label: Text(l10n.etapeFaite),
          )
        : FilledButton.icon(
            onPressed: () async {
              await repo.marquer(uid, parcoursId, contenuId, true);
              if (context.mounted) context.pop();
            },
            icon: const Icon(Icons.check),
            label: Text(l10n.marquerFait),
          );
  }
}
