import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/auth_providers.dart';
import '../../auth/domain/parcours.dart';
import '../accompagnement_providers.dart';
import '../domain/accompagnement.dart';

/// Demande d'accompagnement : en couple ou seul(e), avec un message au coach.
class DemandeScreen extends ConsumerStatefulWidget {
  const DemandeScreen({super.key});

  @override
  ConsumerState<DemandeScreen> createState() => _DemandeScreenState();
}

class _DemandeScreenState extends ConsumerState<DemandeScreen> {
  final _formulaire = GlobalKey<FormState>();
  late final _nom = TextEditingController(
    text: ref.read(profilProvider).value?.nom,
  );
  final _message = TextEditingController();
  late var _type = ref.read(profilProvider).value?.parcours == Parcours.seul
      ? TypeAccompagnement.individuel
      : TypeAccompagnement.couple;
  var _occupe = false;
  String? _erreur;

  @override
  void dispose() {
    _nom.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _envoyer() async {
    if (!_formulaire.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    final user = ref.read(utilisateurFirebaseProvider).value!;
    final profil = ref.read(profilProvider).value;
    setState(() {
      _occupe = true;
      _erreur = null;
    });
    try {
      await ref
          .read(accompagnementRepositoryProvider)
          .demander(
            uid: user.uid,
            nomMembre: profil?.nom ?? user.displayName ?? '',
            type: _type,
            nom: _nom.text,
            message: _message.text,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.demandeEnvoyee)));
      context.pop();
    } catch (_) {
      if (mounted) setState(() => _erreur = l10n.erreurInconnue);
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.demanderAccompagnement)),
      body: Form(
        key: _formulaire,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.demanderAccompagnementAide),
            const SizedBox(height: 16),
            SegmentedButton<TypeAccompagnement>(
              segments: [
                ButtonSegment(
                  value: TypeAccompagnement.couple,
                  icon: const Icon(Icons.favorite_outline),
                  label: Text(l10n.typeCouple),
                ),
                ButtonSegment(
                  value: TypeAccompagnement.individuel,
                  icon: const Icon(Icons.person_outline),
                  label: Text(l10n.typeIndividuel),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nom,
              decoration: InputDecoration(
                labelText: l10n.champNomAccompagnement,
                helperText: _type == TypeAccompagnement.couple
                    ? l10n.champNomAccompagnementAide
                    : null,
              ),
              textCapitalization: TextCapitalization.words,
              maxLength: 80,
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? l10n.champObligatoire : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _message,
              decoration: InputDecoration(
                labelText: l10n.champMessage,
                hintText: l10n.champMessageAide,
                alignLabelWithHint: true,
              ),
              minLines: 4,
              maxLines: 8,
              maxLength: 2000,
            ),
            if (_erreur != null) ...[
              const SizedBox(height: 8),
              Text(_erreur!, style: TextStyle(color: theme.colorScheme.error)),
            ],
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _occupe ? null : _envoyer,
              child: Text(l10n.envoyerDemande),
            ),
          ],
        ),
      ),
    );
  }
}
