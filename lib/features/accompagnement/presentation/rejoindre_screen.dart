import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../auth/auth_providers.dart';
import '../accompagnement_providers.dart';
import '../data/accompagnement_repository.dart';

/// Le conjoint saisit le code reçu pour rejoindre l'accompagnement du couple.
class RejoindreScreen extends ConsumerStatefulWidget {
  const RejoindreScreen({super.key});

  @override
  ConsumerState<RejoindreScreen> createState() => _RejoindreScreenState();
}

class _RejoindreScreenState extends ConsumerState<RejoindreScreen> {
  final _code = TextEditingController();
  var _occupe = false;
  String? _erreur;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _rejoindre() async {
    final l10n = AppLocalizations.of(context);
    final user = ref.read(utilisateurFirebaseProvider).value!;
    setState(() {
      _occupe = true;
      _erreur = null;
    });
    try {
      await ref
          .read(accompagnementRepositoryProvider)
          .rejoindre(
            uid: user.uid,
            nomMembre:
                ref.read(profilProvider).value?.nom ?? user.displayName ?? '',
            code: _code.text,
          );
      if (mounted) context.pop();
    } on ExceptionCode {
      if (mounted) setState(() => _erreur = l10n.codeInvalide);
    } catch (_) {
      if (mounted) setState(() => _erreur = l10n.erreurInconnue);
    } finally {
      if (mounted) setState(() => _occupe = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.rejoindreTitre)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.rejoindreAide),
          const SizedBox(height: 16),
          TextField(
            controller: _code,
            decoration: InputDecoration(
              labelText: l10n.champCode,
              errorText: _erreur,
            ),
            textCapitalization: TextCapitalization.characters,
            autocorrect: false,
            onSubmitted: (_) => _rejoindre(),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _occupe ? null : _rejoindre,
            child: Text(l10n.rejoindre),
          ),
        ],
      ),
    );
  }
}
