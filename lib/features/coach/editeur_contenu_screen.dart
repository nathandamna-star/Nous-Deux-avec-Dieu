import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../contenus/contenus_providers.dart';
import '../contenus/domain/contenu.dart';
import '../contenus/presentation/libelles.dart';

/// Création ou modification d'un contenu, avec une version par langue.
class EditeurContenuScreen extends ConsumerWidget {
  const EditeurContenuScreen({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (id == null) return const _Formulaire(existant: null);
    final c = ref.watch(contenuProvider(id!));
    return switch (c) {
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

  final Contenu? existant;

  @override
  ConsumerState<_Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends ConsumerState<_Formulaire> {
  final _formulaire = GlobalKey<FormState>();
  late var _type = widget.existant?.type ?? TypeContenu.meditation;
  late var _theme = widget.existant?.theme ?? ThemeContenu.communication;
  late var _public =
      (widget.existant?.visibilite ?? Visibilite.public) == Visibilite.public;
  late var _publie = widget.existant?.publie ?? false;
  var _langue = 'fr';
  late final _reference = TextEditingController(
    text: widget.existant?.reference,
  );
  late final _ordre = TextEditingController(
    text: '${widget.existant?.ordre ?? 0}',
  );
  late final _titres = {
    for (final l in languesContenu)
      l: TextEditingController(text: widget.existant?.titres[l]),
  };
  late final _textes = {
    for (final l in languesContenu)
      l: TextEditingController(text: widget.existant?.textes[l]),
  };
  late final _id =
      widget.existant?.id ?? ref.read(contenusRepositoryProvider).nouvelId();
  late final _medias = {...?widget.existant?.medias};
  double? _envoi;
  var _occupe = false;
  String? _erreur;

  @override
  void dispose() {
    for (final c in [
      _reference,
      _ordre,
      ..._titres.values,
      ..._textes.values,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _choisirFichier() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _envoi = 0;
      _erreur = null;
    });
    try {
      final url = await ref
          .read(mediasServiceProvider)
          .choisirEtEnvoyer(
            contenuId: _id,
            langue: _langue,
            type: _type,
            progression: (p) {
              if (mounted) setState(() => _envoi = p);
            },
          );
      if (url != null && mounted) setState(() => _medias[_langue] = url);
    } catch (_) {
      if (mounted) setState(() => _erreur = l10n.envoiEchoue);
    } finally {
      if (mounted) setState(() => _envoi = null);
    }
  }

  Future<void> _enregistrer() async {
    final l10n = AppLocalizations.of(context);
    if (_type.estMedia && _medias.values.every((u) => u.isEmpty)) {
      setState(() => _erreur = l10n.fichierRequis);
      return;
    }
    if (_titres['fr']!.text.trim().isEmpty) {
      setState(() {
        _langue = 'fr';
        _erreur = l10n.titreFrancaisRequis;
      });
      return;
    }
    setState(() {
      _occupe = true;
      _erreur = null;
    });
    final contenu = Contenu(
      id: _id,
      medias: _medias,
      type: _type,
      theme: _theme,
      titres: {for (final e in _titres.entries) e.key: e.value.text},
      textes: {for (final e in _textes.entries) e.key: e.value.text},
      reference: _reference.text,
      visibilite: _public ? Visibilite.public : Visibilite.connectes,
      publie: _publie,
      ordre: int.tryParse(_ordre.text.trim()) ?? 0,
    );
    try {
      await ref
          .read(contenusRepositoryProvider)
          .enregistrer(contenu, nouveau: widget.existant == null);
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
        title: Text(l10n.supprimerContenuTitre),
        content: Text(l10n.supprimerContenuTexte),
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
    await ref.read(contenusRepositoryProvider).supprimer(widget.existant!.id);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existant == null ? l10n.nouveauContenu : l10n.modifierContenu,
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
      body: Form(
        key: _formulaire,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<TypeContenu>(
              initialValue: _type,
              decoration: InputDecoration(labelText: l10n.champType),
              items: [
                for (final t in TypeContenu.values)
                  DropdownMenuItem(value: t, child: Text(l10n.typeContenu(t))),
              ],
              onChanged: (t) => setState(() => _type = t ?? _type),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ThemeContenu>(
              initialValue: _theme,
              decoration: InputDecoration(labelText: l10n.champTheme),
              items: [
                for (final t in ThemeContenu.values)
                  DropdownMenuItem(value: t, child: Text(l10n.themeContenu(t))),
              ],
              onChanged: (t) => setState(() => _theme = t ?? _theme),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _reference,
              decoration: InputDecoration(
                labelText: l10n.champReference,
                hintText: l10n.champReferenceAide,
              ),
            ),
            const SizedBox(height: 24),
            Text(l10n.langueVersion, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
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
            TextFormField(
              key: ValueKey('titre-$_langue'),
              controller: _titres[_langue],
              decoration: InputDecoration(
                labelText: '${l10n.champTitre} (${_langue.toUpperCase()})',
              ),
              maxLength: 150,
            ),
            const SizedBox(height: 8),
            if (_type.estMedia) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.fichierMedia(_langue.toUpperCase()),
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            (_medias[_langue] ?? '').isEmpty
                                ? Icons.info_outline
                                : Icons.check_circle,
                            color: (_medias[_langue] ?? '').isEmpty
                                ? theme.colorScheme.onSurfaceVariant
                                : theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              (_medias[_langue] ?? '').isEmpty
                                  ? l10n.aucunFichier
                                  : l10n.fichierAjoute,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _envoi != null ? null : _choisirFichier,
                            icon: Icon(
                              _type == TypeContenu.video
                                  ? Icons.video_library_outlined
                                  : Icons.audio_file_outlined,
                            ),
                            label: Text(
                              (_medias[_langue] ?? '').isEmpty
                                  ? l10n.choisirFichier
                                  : l10n.remplacerFichier,
                            ),
                          ),
                        ],
                      ),
                      if (_envoi != null) ...[
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: _envoi),
                        const SizedBox(height: 4),
                        Text(l10n.envoiEnCours((_envoi! * 100).round())),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              key: ValueKey('texte-$_langue'),
              controller: _textes[_langue],
              decoration: InputDecoration(
                labelText:
                    '${_type.estMedia ? l10n.champDescription : l10n.champTexte}'
                    ' (${_langue.toUpperCase()})',
                alignLabelWithHint: true,
              ),
              minLines: _type.estMedia ? 3 : 8,
              maxLines: 20,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ordre,
              decoration: InputDecoration(
                labelText: l10n.champOrdre,
                helperText: l10n.champOrdreAide,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
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
              onPressed: _occupe || _envoi != null ? null : _enregistrer,
              child: Text(l10n.enregistrer),
            ),
          ],
        ),
      ),
    );
  }
}
