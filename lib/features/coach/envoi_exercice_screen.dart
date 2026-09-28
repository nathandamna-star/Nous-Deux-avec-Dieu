import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../contenus/contenus_providers.dart';
import '../contenus/domain/contenu.dart';
import '../exercices/domain/exercice.dart';
import '../exercices/exercices_providers.dart';

/// Coach : envoyer un exercice à un accompagnement, écrit à la main ou à
/// partir d'un contenu de la bibliothèque.
class EnvoiExerciceScreen extends ConsumerStatefulWidget {
  const EnvoiExerciceScreen({super.key, required this.accId});

  final String accId;

  @override
  ConsumerState<EnvoiExerciceScreen> createState() =>
      _EnvoiExerciceScreenState();
}

class _EnvoiExerciceScreenState extends ConsumerState<EnvoiExerciceScreen> {
  final _formulaire = GlobalKey<FormState>();
  final _titre = TextEditingController();
  final _consignes = TextEditingController();
  var _mode = ModeExercice.seul;
  String? _contenuId;
  DateTime? _echeance;
  var _occupe = false;

  @override
  void dispose() {
    _titre.dispose();
    _consignes.dispose();
    super.dispose();
  }

  void _choisirContenu(Contenu? c) {
    setState(() => _contenuId = c?.id);
    if (c == null) return;
    // Pré-remplit avec le texte français, que le coach peut adapter.
    _titre.text = c.titre('fr');
    if (_consignes.text.trim().isEmpty) _consignes.text = c.texte('fr');
  }

  Future<void> _choisirDate() async {
    final maintenant = DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: maintenant,
      lastDate: maintenant.add(const Duration(days: 365)),
      initialDate: _echeance ?? maintenant.add(const Duration(days: 7)),
    );
    if (date != null) setState(() => _echeance = date);
  }

  Future<void> _envoyer() async {
    if (!_formulaire.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    setState(() => _occupe = true);
    final messager = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(exercicesRepositoryProvider)
          .envoyer(
            widget.accId,
            titre: _titre.text,
            consignes: _consignes.text,
            mode: _mode,
            contenuId: _contenuId,
            echeance: _echeance,
          );
      messager.showSnackBar(SnackBar(content: Text(l10n.exerciceEnvoye)));
      if (mounted) context.pop();
    } catch (_) {
      messager.showSnackBar(SnackBar(content: Text(l10n.erreurInconnue)));
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langue = Localizations.localeOf(context).toLanguageTag();
    final contenus = (ref.watch(tousContenusProvider).value ?? const [])
        .where(
          (c) =>
              c.type == TypeContenu.exercice || c.type == TypeContenu.question,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.envoyerExercice)),
      body: Form(
        key: _formulaire,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String?>(
              initialValue: _contenuId,
              isExpanded: true,
              decoration: InputDecoration(labelText: l10n.apartirContenu),
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(l10n.aucunContenuLie),
                ),
                for (final c in contenus)
                  DropdownMenuItem(
                    value: c.id,
                    child: Text(c.titre('fr'), overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: (id) => _choisirContenu(
                contenus.where((c) => c.id == id).firstOrNull,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titre,
              decoration: InputDecoration(labelText: l10n.champTitre),
              maxLength: 150,
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? l10n.champObligatoire : null,
            ),
            TextFormField(
              controller: _consignes,
              decoration: InputDecoration(
                labelText: l10n.champConsignes,
                alignLabelWithHint: true,
              ),
              minLines: 5,
              maxLines: 15,
            ),
            const SizedBox(height: 16),
            SegmentedButton<ModeExercice>(
              segments: [
                ButtonSegment(
                  value: ModeExercice.seul,
                  icon: const Icon(Icons.person_outline),
                  label: Text(l10n.modeSeul),
                ),
                ButtonSegment(
                  value: ModeExercice.aDeux,
                  icon: const Icon(Icons.favorite_outline),
                  label: Text(l10n.modeADeux),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (s) => setState(() => _mode = s.first),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event_outlined),
              title: Text(l10n.echeance),
              subtitle: Text(
                _echeance == null
                    ? l10n.choisirDate
                    : DateFormat.yMMMd(langue).format(_echeance!),
              ),
              trailing: _echeance == null
                  ? null
                  : IconButton(
                      tooltip: l10n.supprimer,
                      icon: const Icon(Icons.close),
                      onPressed: () => setState(() => _echeance = null),
                    ),
              onTap: _choisirDate,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _occupe ? null : _envoyer,
              icon: const Icon(Icons.send),
              label: Text(l10n.envoyer),
            ),
          ],
        ),
      ),
    );
  }
}
