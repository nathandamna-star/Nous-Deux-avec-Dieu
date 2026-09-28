import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../contenus/contenus_providers.dart';
import '../contenus/domain/contenu.dart';
import '../contenus/presentation/libelles.dart';
import '../parcours/domain/parcours.dart';
import '../parcours/parcours_providers.dart';

/// Création ou modification d'un parcours : textes par langue et étapes
/// choisies dans la bibliothèque, dans l'ordre (glisser pour réordonner).
class EditeurParcoursScreen extends ConsumerWidget {
  const EditeurParcoursScreen({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (id == null) return const _Formulaire(existant: null);
    return switch (ref.watch(parcoursProvider(id!))) {
      AsyncData(:final value) => _Formulaire(existant: value),
      _ => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
    };
  }
}

class _Formulaire extends ConsumerStatefulWidget {
  const _Formulaire({required this.existant});

  final Parcours? existant;

  @override
  ConsumerState<_Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends ConsumerState<_Formulaire> {
  var _langue = 'fr';
  late final _titres = {
    for (final l in languesContenu)
      l: TextEditingController(text: widget.existant?.titres[l]),
  };
  late final _descriptions = {
    for (final l in languesContenu)
      l: TextEditingController(text: widget.existant?.descriptions[l]),
  };
  late final _etapes = [...?widget.existant?.etapes];
  late var _public =
      (widget.existant?.visibilite ?? Visibilite.public) == Visibilite.public;
  late var _publie = widget.existant?.publie ?? false;
  late final _ordre = TextEditingController(
    text: '${widget.existant?.ordre ?? 0}',
  );
  var _occupe = false;
  String? _erreur;

  @override
  void dispose() {
    for (final c in [..._titres.values, ..._descriptions.values, _ordre]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _ajouterEtape(List<Contenu> contenus) async {
    final l10n = AppLocalizations.of(context);
    final choix = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        builder: (context, controleur) => ListView(
          controller: controleur,
          children: [
            ListTile(title: Text(l10n.choisirContenuEtape)),
            for (final c in contenus.where((c) => !_etapes.contains(c.id)))
              ListTile(
                title: Text(c.titre('fr')),
                subtitle: Text(l10n.typeContenu(c.type)),
                onTap: () => Navigator.pop(context, c.id),
              ),
          ],
        ),
      ),
    );
    if (choix != null) setState(() => _etapes.add(choix));
  }

  Future<void> _enregistrer() async {
    final l10n = AppLocalizations.of(context);
    if (_titres['fr']!.text.trim().isEmpty) {
      setState(() {
        _langue = 'fr';
        _erreur = l10n.titreFrancaisRequis;
      });
      return;
    }
    if (_etapes.isEmpty) {
      setState(() => _erreur = l10n.etapesRequises);
      return;
    }
    setState(() {
      _occupe = true;
      _erreur = null;
    });
    try {
      await ref
          .read(parcoursRepositoryProvider)
          .enregistrer(
            Parcours(
              id: widget.existant?.id ?? '',
              titres: {for (final e in _titres.entries) e.key: e.value.text},
              descriptions: {
                for (final e in _descriptions.entries) e.key: e.value.text,
              },
              etapes: _etapes,
              visibilite: _public ? Visibilite.public : Visibilite.connectes,
              publie: _publie,
              ordre: int.tryParse(_ordre.text.trim()) ?? 0,
            ),
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.enregistre)));
      context.pop();
    } catch (_) {
      if (mounted) setState(() => _erreur = l10n.erreurInconnue);
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  Future<void> _supprimer() async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.supprimerParcoursTitre),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.annuler),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.supprimer),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await ref.read(parcoursRepositoryProvider).supprimer(widget.existant!.id);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final contenus = ref.watch(tousContenusProvider).value ?? const [];
    final parId = {for (final c in contenus) c.id: c};

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existant == null
              ? l10n.nouveauParcours
              : l10n.modifierParcours,
        ),
        actions: [
          if (widget.existant != null)
            IconButton(
              tooltip: l10n.supprimer,
              icon: const Icon(Icons.delete_outline),
              onPressed: _supprimer,
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<String>(
            showSelectedIcon: false,
            segments: [
              for (final l in languesContenu)
                ButtonSegment(value: l, label: Text(l.toUpperCase())),
            ],
            selected: {_langue},
            onSelectionChanged: (s) => setState(() => _langue = s.first),
          ),
          const SizedBox(height: 16),
          TextField(
            key: ValueKey('titre-$_langue'),
            controller: _titres[_langue],
            decoration: InputDecoration(
              labelText: '${l10n.champTitre} (${_langue.toUpperCase()})',
            ),
            maxLength: 150,
          ),
          TextField(
            key: ValueKey('description-$_langue'),
            controller: _descriptions[_langue],
            decoration: InputDecoration(
              labelText: '${l10n.champDescription} (${_langue.toUpperCase()})',
              alignLabelWithHint: true,
            ),
            minLines: 3,
            maxLines: 8,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(l10n.etapes, style: theme.textTheme.titleMedium),
              ),
              TextButton.icon(
                onPressed: () => _ajouterEtape(contenus),
                icon: const Icon(Icons.add),
                label: Text(l10n.ajouterEtape),
              ),
            ],
          ),
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: true,
            onReorderItem: (ancien, nouveau) => setState(
              () => _etapes.insert(nouveau, _etapes.removeAt(ancien)),
            ),
            children: [
              for (final (i, id) in _etapes.indexed)
                ListTile(
                  key: ValueKey(id),
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(child: Text('${i + 1}')),
                  title: Text(parId[id]?.titre('fr') ?? id),
                  trailing: IconButton(
                    tooltip: l10n.retirerEtape,
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => setState(() => _etapes.removeAt(i)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ordre,
            decoration: InputDecoration(labelText: l10n.champOrdre),
            keyboardType: TextInputType.number,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.visiblePourTous),
            subtitle: Text(l10n.visiblePourTousAide),
            value: _public,
            onChanged: (v) => setState(() => _public = v),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.publier),
            subtitle: Text(l10n.publierAide),
            value: _publie,
            onChanged: (v) => setState(() => _publie = v),
          ),
          if (_erreur != null) ...[
            const SizedBox(height: 8),
            Text(_erreur!, style: TextStyle(color: theme.colorScheme.error)),
          ],
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _occupe ? null : _enregistrer,
            child: Text(l10n.enregistrer),
          ),
        ],
      ),
    );
  }
}
