import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../contenus/domain/contenu.dart';
import '../domain/paiement.dart';
import '../domain/virement.dart';
import '../paiements_providers.dart';

/// Coach : nom affiché, coordonnées bancaires, message des dons.
class ParametresCoachScreen extends ConsumerStatefulWidget {
  const ParametresCoachScreen({super.key});

  @override
  ConsumerState<ParametresCoachScreen> createState() =>
      _ParametresCoachScreenState();
}

class _ParametresCoachScreenState extends ConsumerState<ParametresCoachScreen> {
  final _cle = GlobalKey<FormState>();
  final _nom = TextEditingController();
  final _titulaire = TextEditingController();
  final _iban = TextEditingController();
  final _bic = TextEditingController();
  final _messages = {
    for (final l in languesContenu) l: TextEditingController(),
  };
  var _pret = false;

  @override
  void dispose() {
    for (final c in [_nom, _titulaire, _iban, _bic, ..._messages.values]) {
      c.dispose();
    }
    super.dispose();
  }

  void _charger(ParametresCoach? p) {
    if (_pret || p == null) return;
    _pret = true;
    _nom.text = p.nomAffiche;
    _titulaire.text = p.titulaire;
    _iban.text = p.iban.isEmpty ? '' : formaterIban(p.iban);
    _bic.text = p.bic;
    for (final l in languesContenu) {
      _messages[l]!.text = p.messagesDon[l] ?? '';
    }
  }

  Future<void> _enregistrer() async {
    if (!_cle.currentState!.validate()) return;
    final messager = ScaffoldMessenger.of(context);
    final texte = AppLocalizations.of(context).enregistre;
    await ref
        .read(paiementsRepositoryProvider)
        .enregistrerParametres(
          ParametresCoach(
            nomAffiche: _nom.text,
            titulaire: _titulaire.text,
            iban: _iban.text,
            bic: _bic.text,
            messagesDon: {
              for (final e in _messages.entries)
                if (e.value.text.trim().isNotEmpty) e.key: e.value.text.trim(),
            },
          ),
        );
    messager.showSnackBar(SnackBar(content: Text(texte)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    _charger(ref.watch(parametresCoachProvider).value);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.parametresCoach)),
      body: !_pret
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _cle,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(l10n.parametresCoachAide),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nom,
                    decoration: InputDecoration(
                      labelText: l10n.champNomAffiche,
                    ),
                    maxLength: 100,
                  ),
                  TextFormField(
                    controller: _titulaire,
                    decoration: InputDecoration(labelText: l10n.champTitulaire),
                    maxLength: 70,
                  ),
                  TextFormField(
                    controller: _iban,
                    textCapitalization: TextCapitalization.characters,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: l10n.iban),
                    validator: (v) => (v ?? '').trim().isEmpty || ibanValide(v!)
                        ? null
                        : l10n.ibanInvalide,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _bic,
                    textCapitalization: TextCapitalization.characters,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: l10n.bic,
                      helperText: l10n.champBicAide,
                    ),
                    validator: (v) {
                      final t = (v ?? '').trim().toUpperCase();
                      return t.isEmpty ||
                              RegExp(r'^[A-Z0-9]{8}([A-Z0-9]{3})?$').hasMatch(t)
                          ? null
                          : l10n.bicInvalide;
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.champMessageDon,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  for (final l in languesContenu)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        controller: _messages[l],
                        decoration: InputDecoration(labelText: l.toUpperCase()),
                        minLines: 1,
                        maxLines: 4,
                        maxLength: 500,
                      ),
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
