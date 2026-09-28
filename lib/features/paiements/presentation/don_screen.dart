import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/auth_providers.dart';
import '../paiements_providers.dart';
import 'libelles_paiement.dart';

/// Don libre par virement (il ne débloque rien : règles des stores).
class DonScreen extends ConsumerStatefulWidget {
  const DonScreen({super.key});

  @override
  ConsumerState<DonScreen> createState() => _DonScreenState();
}

class _DonScreenState extends ConsumerState<DonScreen> {
  static const montants = [10.0, 20.0, 50.0, 100.0];

  final _cle = GlobalKey<FormState>();
  final _autre = TextEditingController();
  double? _choix = 20;
  var _envoi = false;

  @override
  void dispose() {
    _autre.dispose();
    super.dispose();
  }

  double? get _montant =>
      _choix ?? double.tryParse(_autre.text.trim().replaceAll(',', '.'));

  Future<void> _continuer() async {
    if (!_cle.currentState!.validate()) return;
    final montant = _montant;
    final user = ref.read(utilisateurFirebaseProvider).value;
    if (montant == null || user == null) return;
    setState(() => _envoi = true);
    try {
      final id = await ref
          .read(paiementsRepositoryProvider)
          .faireUnDon(
            uid: user.uid,
            nom: ref.read(profilProvider).value?.nom ?? user.displayName ?? '',
            montant: (montant * 100).round() / 100,
          );
      if (mounted) context.pushReplacement(Routes.paiementProfil(id));
    } catch (_) {
      if (!mounted) return;
      setState(() => _envoi = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).erreurInconnue)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final merci =
        ref.watch(parametresCoachProvider).value?.messageDon(langue) ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.faireUnDon)),
      body: Form(
        key: _cle,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (merci.isNotEmpty) ...[
              Text(merci, style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
            ],
            Text(l10n.donAide),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in montants)
                  ChoiceChip(
                    label: Text(euros(context, m)),
                    selected: _choix == m,
                    onSelected: (_) => setState(() {
                      _choix = m;
                      _autre.clear();
                    }),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _autre,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: l10n.autreMontant),
              onChanged: (v) =>
                  setState(() => _choix = v.trim().isEmpty ? 20 : null),
              validator: (_) {
                final m = _montant;
                return m == null || m < 1 || m > 10000
                    ? l10n.montantInvalide
                    : null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _envoi ? null : _continuer,
              child: Text(l10n.continuer),
            ),
          ],
        ),
      ),
    );
  }
}
