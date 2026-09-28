import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/preferences/preferences.dart';
import '../../../l10n/app_localizations.dart';
import '../../accompagnement/accompagnement_providers.dart';
import '../domain/rendez_vous.dart';
import '../rendez_vous_providers.dart';

/// Coach : planifier ou modifier un rendez-vous (date, heure, durée, Zoom).
class EditeurRendezVousScreen extends ConsumerStatefulWidget {
  const EditeurRendezVousScreen({
    super.key,
    required this.accompagnementId,
    this.rendezVousId,
  });

  final String accompagnementId;
  final String? rendezVousId;

  @override
  ConsumerState<EditeurRendezVousScreen> createState() =>
      _EditeurRendezVousScreenState();
}

class _EditeurRendezVousScreenState
    extends ConsumerState<EditeurRendezVousScreen> {
  static const durees = [30, 45, 60, 90, 120];

  final _cle = GlobalKey<FormState>();
  late final TextEditingController _lien;
  late DateTime _jour;
  late TimeOfDay _heure;
  var _duree = 60;
  var _pret = false;
  RendezVous? _existant;
  var _envoi = false;

  @override
  void initState() {
    super.initState();
    _lien = TextEditingController(
      text: dernierLienZoom(ref.read(sharedPreferencesProvider)),
    );
    // Par défaut : demain à 19:00.
    final demain = ref.read(horlogeProvider)().add(const Duration(days: 1));
    _jour = DateTime(demain.year, demain.month, demain.day);
    _heure = const TimeOfDay(hour: 19, minute: 0);
    _pret = widget.rendezVousId == null;
  }

  @override
  void dispose() {
    _lien.dispose();
    super.dispose();
  }

  /// Remplit le formulaire avec le rendez-vous existant (une seule fois).
  void _charger(List<RendezVous> liste) {
    if (_pret) return;
    final r = liste.where((r) => r.id == widget.rendezVousId).firstOrNull;
    if (r == null) return;
    _pret = true;
    _existant = r;
    _jour = DateTime(r.debut.year, r.debut.month, r.debut.day);
    _heure = TimeOfDay.fromDateTime(r.debut);
    _duree = r.dureeMin;
    _lien.text = r.lienZoom;
  }

  DateTime get _debut =>
      DateTime(_jour.year, _jour.month, _jour.day, _heure.hour, _heure.minute);

  Future<void> _choisirJour() async {
    final maintenant = ref.read(horlogeProvider)();
    final choix = await showDatePicker(
      context: context,
      initialDate: _jour,
      firstDate: DateTime(maintenant.year, maintenant.month, maintenant.day),
      lastDate: maintenant.add(const Duration(days: 366)),
    );
    if (choix != null) setState(() => _jour = choix);
  }

  Future<void> _choisirHeure() async {
    final choix = await showTimePicker(context: context, initialTime: _heure);
    if (choix != null) setState(() => _heure = choix);
  }

  Future<void> _enregistrer() async {
    final l10n = AppLocalizations.of(context);
    if (!_cle.currentState!.validate()) return;
    if (!_debut.isAfter(ref.read(horlogeProvider)())) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.dateDansLePasse)));
      return;
    }
    final acc = ref.read(accompagnementProvider(widget.accompagnementId)).value;
    if (acc == null) return;
    setState(() => _envoi = true);
    final messager = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(rendezVousRepositoryProvider)
          .planifier(
            acc,
            existant: _existant,
            debut: _debut,
            dureeMin: _duree,
            lienZoom: _lien.text,
          );
      if (_lien.text.trim().isNotEmpty) {
        await memoriserLienZoom(
          ref.read(sharedPreferencesProvider),
          _lien.text,
        );
      }
      messager.showSnackBar(SnackBar(content: Text(l10n.rendezVousEnregistre)));
      if (mounted) context.pop();
    } catch (_) {
      messager.showSnackBar(SnackBar(content: Text(l10n.erreurInconnue)));
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langue = Localizations.localeOf(context).toLanguageTag();
    if (widget.rendezVousId != null) {
      _charger(
        ref.watch(rendezVousProvider(widget.accompagnementId)).value ??
            const [],
      );
    }
    final acc = ref.watch(accompagnementProvider(widget.accompagnementId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.rendezVousId == null
              ? l10n.planifierRendezVous
              : l10n.modifierRendezVous,
        ),
      ),
      body: !_pret
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _cle,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (acc.value != null)
                    Text(
                      acc.value!.nom,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today_outlined),
                    title: Text(l10n.champDate),
                    subtitle: Text(DateFormat.yMMMMEEEEd(langue).format(_jour)),
                    onTap: _choisirJour,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.schedule),
                    title: Text(l10n.champHeure),
                    subtitle: Text(DateFormat.Hm(langue).format(_debut)),
                    onTap: _choisirHeure,
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.champDuree),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final d in {...durees, _duree}.toList()..sort())
                        ChoiceChip(
                          label: Text(l10n.dureeMinutes(d)),
                          selected: _duree == d,
                          onSelected: (_) => setState(() => _duree = d),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lien,
                    keyboardType: TextInputType.url,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: l10n.champLienZoom,
                      helperText: l10n.champLienZoomAide,
                      prefixIcon: const Icon(Icons.videocam_outlined),
                    ),
                    validator: (v) {
                      final t = (v ?? '').trim();
                      if (t.isEmpty || lienVisioValide(t)) return null;
                      return l10n.lienZoomInvalide;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.rappelsAutomatiques,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _envoi ? null : _enregistrer,
                    child: Text(l10n.enregistrer),
                  ),
                ],
              ),
            ),
    );
  }
}
