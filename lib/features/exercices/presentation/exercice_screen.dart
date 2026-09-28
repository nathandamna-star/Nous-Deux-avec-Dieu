import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../accompagnement/accompagnement_providers.dart';
import '../../auth/auth_providers.dart';
import '../domain/exercice.dart';
import '../exercices_providers.dart';

/// Client : consignes d'un exercice et sa réponse.
class ExerciceScreen extends ConsumerWidget {
  const ExerciceScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acc = ref.watch(monAccompagnementProvider).value;
    final uid = ref.watch(utilisateurFirebaseProvider).value?.uid;
    final e = acc == null
        ? null
        : ref.watch(exerciceProvider((acc: acc.id, id: id))).value;
    if (acc == null || uid == null || e == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final reponse = ref.watch(
      reponseProvider((acc: acc.id, id: id, cle: e.cleReponse(uid))),
    );
    if (reponse.isLoading && !reponse.hasValue) {
      return Scaffold(
        appBar: AppBar(title: Text(e.titre)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return _Formulaire(
      accId: acc.id,
      membres: acc.membres,
      uid: uid,
      exercice: e,
      reponseInitiale: reponse.value?.texte ?? '',
    );
  }
}

class _Formulaire extends ConsumerStatefulWidget {
  const _Formulaire({
    required this.accId,
    required this.membres,
    required this.uid,
    required this.exercice,
    required this.reponseInitiale,
  });

  final String accId;
  final List<String> membres;
  final String uid;
  final Exercice exercice;
  final String reponseInitiale;

  @override
  ConsumerState<_Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends ConsumerState<_Formulaire> {
  late final _reponse = TextEditingController(text: widget.reponseInitiale);
  var _occupe = false;

  @override
  void dispose() {
    _reponse.dispose();
    super.dispose();
  }

  Future<void> _enregistrer() async {
    final l10n = AppLocalizations.of(context);
    if (_reponse.text.trim().isEmpty) return;
    setState(() => _occupe = true);
    final messager = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(exercicesRepositoryProvider)
          .repondre(
            accId: widget.accId,
            exercice: widget.exercice,
            uid: widget.uid,
            membres: widget.membres,
            texte: _reponse.text,
          );
      messager.showSnackBar(SnackBar(content: Text(l10n.reponseEnregistree)));
    } catch (_) {
      messager.showSnackBar(SnackBar(content: Text(l10n.erreurInconnue)));
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final e = widget.exercice;
    final aDeux = e.mode == ModeExercice.aDeux;
    final langue = Localizations.localeOf(context).toLanguageTag();
    return Scaffold(
      appBar: AppBar(title: Text(e.titre)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                avatar: Icon(
                  aDeux ? Icons.favorite_outline : Icons.person_outline,
                ),
                label: Text(aDeux ? l10n.modeADeux : l10n.modeSeul),
              ),
              if (e.echeance != null)
                Chip(
                  avatar: const Icon(Icons.event_outlined),
                  label: Text(
                    l10n.aFaireAvant(
                      DateFormat.yMMMd(langue).format(e.echeance!),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          SelectableText(e.consignes, style: theme.textTheme.bodyLarge),
          if (e.contenuId != null) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () =>
                  context.push(Routes.contenuAccueil(e.contenuId!)),
              icon: const Icon(Icons.auto_stories_outlined),
              label: Text(l10n.lireAvant),
            ),
          ],
          const Divider(height: 32),
          Text(
            aDeux ? l10n.notreReponse : l10n.maReponse,
            style: theme.textTheme.titleMedium,
          ),
          Text(
            aDeux ? l10n.modeADeuxAide : l10n.modeSeulAide,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _reponse,
            minLines: 6,
            maxLines: 20,
            maxLength: 10000,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _occupe ? null : _enregistrer,
            child: Text(l10n.enregistrerReponse),
          ),
        ],
      ),
    );
  }
}
