import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../contenus/domain/contenu.dart';
import '../../rendezvous/domain/rendez_vous.dart';
import '../domain/livre.dart';
import '../livres_providers.dart';
import 'libelles_livres.dart';

/// Coach : créer ou modifier un article de la boutique, livre ou autre
/// (textes par langue, photo, formats et prix, liens d'achat, commande
/// directe, publication).
class EditeurLivreScreen extends ConsumerStatefulWidget {
  const EditeurLivreScreen({super.key, this.id, this.categorie});

  final String? id;

  /// Catégorie proposée pour un nouvel article.
  final CategorieArticle? categorie;

  @override
  ConsumerState<EditeurLivreScreen> createState() => _EditeurLivreScreenState();
}

class _LigneLien {
  final libelle = TextEditingController();
  final url = TextEditingController();

  void dispose() {
    libelle.dispose();
    url.dispose();
  }
}

class _EditeurLivreScreenState extends ConsumerState<EditeurLivreScreen> {
  final _cle = GlobalKey<FormState>();
  late final String _id =
      widget.id ?? ref.read(livresRepositoryProvider).nouvelId();
  late var _pret = widget.id == null;
  var _langue = 'fr';

  final _titres = {for (final l in languesContenu) l: TextEditingController()};
  final _sousTitres = {
    for (final l in languesContenu) l: TextEditingController(),
  };
  final _descriptions = {
    for (final l in languesContenu) l: TextEditingController(),
  };
  final _prix = {for (final t in TypeFormat.values) t: TextEditingController()};
  final _fraisEnvoi = TextEditingController(text: '0');
  final _extrait = TextEditingController();
  final _liens = <_LigneLien>[];
  var _couverture = '';
  var _langues = <String>{'fr'};
  var _commandeDirecte = false;
  var _publie = false;
  var _ordre = 0;
  var _envoiCouverture = false;
  late var _categorie = widget.categorie ?? CategorieArticle.livre;

  @override
  void dispose() {
    for (final c in [
      ..._titres.values,
      ..._sousTitres.values,
      ..._descriptions.values,
      ..._prix.values,
      _fraisEnvoi,
      _extrait,
    ]) {
      c.dispose();
    }
    for (final l in _liens) {
      l.dispose();
    }
    super.dispose();
  }

  static String _nombre(double v) =>
      v.toStringAsFixed(v == v.roundToDouble() ? 0 : 2).replaceAll('.', ',');

  static double? _lire(String t) =>
      double.tryParse(t.trim().replaceAll(',', '.'));

  void _charger(Livre? l) {
    if (_pret || l == null) return;
    _pret = true;
    for (final lg in languesContenu) {
      _titres[lg]!.text = l.titres[lg] ?? '';
      _sousTitres[lg]!.text = l.sousTitres[lg] ?? '';
      _descriptions[lg]!.text = l.descriptions[lg] ?? '';
    }
    for (final f in l.formats) {
      _prix[f.type]!.text = _nombre(f.prix);
    }
    for (final lien in l.liens) {
      _liens.add(
        _LigneLien()
          ..libelle.text = lien.libelle
          ..url.text = lien.url,
      );
    }
    _fraisEnvoi.text = _nombre(l.fraisEnvoi);
    _extrait.text = l.extraitUrl;
    _couverture = l.couvertureUrl;
    _langues = {...l.langues};
    _commandeDirecte = l.commandeDirecte;
    _publie = l.publie;
    _ordre = l.ordre;
    _categorie = l.categorie;
  }

  Map<String, String> _carte(Map<String, TextEditingController> c) => {
    for (final e in c.entries)
      if (e.value.text.trim().isNotEmpty) e.key: e.value.text.trim(),
  };

  Future<void> _choisirCouverture() async {
    setState(() => _envoiCouverture = true);
    try {
      final url = await ref
          .read(couverturesServiceProvider)
          .choisirEtEnvoyer(_id);
      if (url != null) _couverture = url;
    } finally {
      if (mounted) setState(() => _envoiCouverture = false);
    }
  }

  Future<void> _enregistrer() async {
    final l10n = AppLocalizations.of(context);
    if (_titres['fr']!.text.trim().isEmpty) {
      setState(() => _langue = 'fr');
    }
    if (!_cle.currentState!.validate()) return;
    if (_titres['fr']!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.titreFrancaisRequis)));
      return;
    }
    final nb = ref.read(tousLivresProvider).value?.length ?? 0;
    await ref
        .read(livresRepositoryProvider)
        .enregistrer(
          Livre(
            id: _id,
            titres: _carte(_titres),
            sousTitres: _carte(_sousTitres),
            descriptions: _carte(_descriptions),
            couvertureUrl: _couverture,
            langues: [
              for (final l in languesContenu)
                if (_langues.contains(l)) l,
            ],
            formats: [
              for (final t in TypeFormat.values)
                if (_lire(_prix[t]!.text) case final prix? when prix > 0)
                  FormatLivre(type: t, prix: prix),
            ],
            liens: [
              for (final l in _liens)
                if (l.url.text.trim().isNotEmpty)
                  LienAchat(
                    libelle: l.libelle.text.trim(),
                    url: l.url.text.trim(),
                  ),
            ],
            commandeDirecte: _commandeDirecte,
            fraisEnvoi: _lire(_fraisEnvoi.text) ?? 0,
            extraitUrl: _extrait.text.trim(),
            publie: _publie,
            ordre: widget.id == null ? nb : _ordre,
            categorie: _categorie,
          ),
          nouveau: widget.id == null,
        );
    if (mounted) context.pop();
  }

  Future<void> _supprimer() async {
    await ref.read(livresRepositoryProvider).supprimer(_id);
    if (mounted) context.pop();
  }

  String? _validerPrix(String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return null;
    final p = _lire(t);
    return p == null || p <= 0 || p > 10000
        ? AppLocalizations.of(context).nombreInvalide
        : null;
  }

  String? _validerLien(String? v) {
    final t = (v ?? '').trim();
    return t.isEmpty || lienVisioValide(t)
        ? null
        : AppLocalizations.of(context).lienInvalide;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    if (widget.id != null) _charger(ref.watch(livreProvider(_id)).value);
    if (!_pret) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final papier = _lire(_prix[TypeFormat.papier]!.text) != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id != null
              ? l10n.modifierLivre
              : _categorie == CategorieArticle.autre
              ? l10n.nouvelArticle
              : l10n.nouveauLivre,
        ),
        actions: [
          if (widget.id != null)
            IconButton(
              tooltip: l10n.supprimer,
              icon: const Icon(Icons.delete_outline),
              onPressed: _supprimer,
            ),
        ],
      ),
      body: Form(
        key: _cle,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SegmentedButton<CategorieArticle>(
              segments: [
                ButtonSegment(
                  value: CategorieArticle.livre,
                  icon: const Icon(Icons.menu_book_outlined),
                  label: Text(l10n.categorieLivre),
                ),
                ButtonSegment(
                  value: CategorieArticle.autre,
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: Text(l10n.categorieAutre),
                ),
              ],
              selected: {_categorie},
              onSelectionChanged: (s) => setState(() => _categorie = s.first),
            ),
            if (_categorie == CategorieArticle.autre) ...[
              const SizedBox(height: 8),
              Text(l10n.articleAutreAide, style: theme.textTheme.bodySmall),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Couverture(url: _couverture, largeur: 72),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: _envoiCouverture ? null : _choisirCouverture,
                  icon: const Icon(Icons.image_outlined),
                  label: Text(l10n.choisirCouverture),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SegmentedButton<String>(
              showSelectedIcon: false,
              segments: [
                for (final l in languesContenu)
                  ButtonSegment(value: l, label: Text(l.toUpperCase())),
              ],
              selected: {_langue},
              onSelectionChanged: (s) => setState(() => _langue = s.first),
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: ValueKey('titre-$_langue'),
              controller: _titres[_langue],
              decoration: InputDecoration(
                labelText: '${l10n.champTitre} (${_langue.toUpperCase()})',
              ),
              maxLength: 200,
            ),
            TextFormField(
              key: ValueKey('sous-titre-$_langue'),
              controller: _sousTitres[_langue],
              decoration: InputDecoration(
                labelText: '${l10n.champSousTitre} (${_langue.toUpperCase()})',
              ),
              maxLength: 200,
            ),
            TextFormField(
              key: ValueKey('description-$_langue'),
              controller: _descriptions[_langue],
              decoration: InputDecoration(
                labelText:
                    '${l10n.champDescription} (${_langue.toUpperCase()})',
              ),
              minLines: 3,
              maxLines: 10,
              maxLength: 5000,
            ),
            const SizedBox(height: 8),
            Text(l10n.languesDuLivre, style: theme.textTheme.titleMedium),
            Wrap(
              spacing: 8,
              children: [
                for (final l in languesContenu)
                  FilterChip(
                    label: Text(l.toUpperCase()),
                    selected: _langues.contains(l),
                    onSelected: (v) => setState(
                      () => v ? _langues.add(l) : _langues.remove(l),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(l10n.formatsEtPrix, style: theme.textTheme.titleMedium),
            for (final t in TypeFormat.values)
              TextFormField(
                controller: _prix[t],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: l10n.format(t)),
                validator: _validerPrix,
                onChanged: (_) => setState(() {}),
              ),
            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.commandeDirecteOption),
              subtitle: Text(l10n.commandeDirecteAide),
              value: _commandeDirecte,
              onChanged: (v) => setState(() => _commandeDirecte = v),
            ),
            if (_commandeDirecte) ...[
              if (!papier)
                Text(
                  l10n.prixPapierRequis,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              TextFormField(
                controller: _fraisEnvoi,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: l10n.fraisEnvoi),
                validator: (v) {
                  final p = _lire(v ?? '');
                  return p == null || p < 0 || p > 1000
                      ? l10n.nombreInvalide
                      : null;
                },
              ),
            ],
            const SizedBox(height: 16),
            Text(l10n.liensAchat, style: theme.textTheme.titleMedium),
            for (final (i, lien) in _liens.indexed)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: lien.libelle,
                      decoration: InputDecoration(labelText: l10n.nomBoutique),
                      validator: (v) =>
                          lien.url.text.trim().isNotEmpty &&
                              (v ?? '').trim().isEmpty
                          ? l10n.champObligatoire
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: lien.url,
                      keyboardType: TextInputType.url,
                      autocorrect: false,
                      decoration: InputDecoration(labelText: l10n.adresseLien),
                      validator: _validerLien,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.supprimer,
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() => _liens.removeAt(i)),
                  ),
                ],
              ),
            if (_liens.length < 10)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => setState(() => _liens.add(_LigneLien())),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.ajouterLien),
                ),
              ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _extrait,
              keyboardType: TextInputType.url,
              autocorrect: false,
              decoration: InputDecoration(labelText: l10n.champExtrait),
              validator: _validerLien,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.publierLivre),
              value: _publie,
              onChanged: (v) => setState(() => _publie = v),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _envoiCouverture ? null : _enregistrer,
              child: Text(l10n.enregistrer),
            ),
          ],
        ),
      ),
    );
  }
}
