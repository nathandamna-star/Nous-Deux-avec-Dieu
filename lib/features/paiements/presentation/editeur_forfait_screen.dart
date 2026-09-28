import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../contenus/domain/contenu.dart';
import '../domain/paiement.dart';
import '../paiements_providers.dart';

/// Coach : créer ou modifier un forfait (nom par langue, séances, prix).
class EditeurForfaitScreen extends ConsumerStatefulWidget {
  const EditeurForfaitScreen({super.key, this.id});

  final String? id;

  @override
  ConsumerState<EditeurForfaitScreen> createState() =>
      _EditeurForfaitScreenState();
}

class _EditeurForfaitScreenState extends ConsumerState<EditeurForfaitScreen> {
  final _cle = GlobalKey<FormState>();
  final _noms = {for (final l in languesContenu) l: TextEditingController()};
  final _seances = TextEditingController(text: '5');
  final _prix = TextEditingController();
  var _actif = true;
  var _ordre = 0;
  late var _pret = widget.id == null;

  @override
  void dispose() {
    for (final c in [..._noms.values, _seances, _prix]) {
      c.dispose();
    }
    super.dispose();
  }

  void _charger(List<Forfait> liste) {
    if (_pret) return;
    final f = liste.where((f) => f.id == widget.id).firstOrNull;
    if (f == null) return;
    _pret = true;
    for (final l in languesContenu) {
      _noms[l]!.text = f.noms[l] ?? '';
    }
    _seances.text = '${f.nbSeances}';
    _prix.text = f.prix
        .toStringAsFixed(f.prix == f.prix.roundToDouble() ? 0 : 2)
        .replaceAll('.', ',');
    _actif = f.actif;
    _ordre = f.ordre;
  }

  double? get _valeurPrix =>
      double.tryParse(_prix.text.trim().replaceAll(',', '.'));

  Future<void> _enregistrer() async {
    if (!_cle.currentState!.validate()) return;
    final nb = ref.read(tousForfaitsProvider).value?.length ?? 0;
    await ref
        .read(paiementsRepositoryProvider)
        .enregistrerForfait(
          Forfait(
            id: widget.id ?? '',
            noms: {
              for (final e in _noms.entries)
                if (e.value.text.trim().isNotEmpty) e.key: e.value.text.trim(),
            },
            nbSeances: int.parse(_seances.text.trim()),
            prix: (_valeurPrix! * 100).round() / 100,
            actif: _actif,
            ordre: widget.id == null ? nb : _ordre,
          ),
        );
    if (mounted) context.pop();
  }

  Future<void> _supprimer() async {
    await ref.read(paiementsRepositoryProvider).supprimerForfait(widget.id!);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    _charger(ref.watch(tousForfaitsProvider).value ?? const []);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id == null ? l10n.nouveauForfait : l10n.modifierForfait,
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
      body: !_pret
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _cle,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  for (final l in languesContenu)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        controller: _noms[l],
                        decoration: InputDecoration(
                          labelText:
                              '${l10n.champNomForfait} (${l.toUpperCase()})',
                        ),
                        maxLength: 100,
                        validator: (v) => l == 'fr' && (v ?? '').trim().isEmpty
                            ? l10n.champObligatoire
                            : null,
                      ),
                    ),
                  TextFormField(
                    controller: _seances,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n.champNbSeances),
                    validator: (v) {
                      final n = int.tryParse((v ?? '').trim());
                      return n == null || n < 1 || n > 100
                          ? l10n.nombreInvalide
                          : null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _prix,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(labelText: l10n.champPrix),
                    validator: (_) {
                      final p = _valeurPrix;
                      return p == null || p <= 0 || p > 100000
                          ? l10n.nombreInvalide
                          : null;
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.forfaitActif),
                    value: _actif,
                    onChanged: (v) => setState(() => _actif = v),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _enregistrer,
                    child: Text(l10n.enregistrer),
                  ),
                ],
              ),
            ),
    );
  }
}
