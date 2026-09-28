import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/connexion_requise.dart';
import '../../auth/auth_providers.dart';
import '../../paiements/presentation/libelles_paiement.dart';
import '../domain/livre.dart';
import '../livres_providers.dart';

/// Commande d'un livre papier au coach : quantité, adresse, total.
class CommanderLivreScreen extends ConsumerStatefulWidget {
  const CommanderLivreScreen({super.key, required this.id, required this.base});

  final String id;
  final String base;

  @override
  ConsumerState<CommanderLivreScreen> createState() =>
      _CommanderLivreScreenState();
}

class _CommanderLivreScreenState extends ConsumerState<CommanderLivreScreen> {
  final _cle = GlobalKey<FormState>();
  late final TextEditingController _nom;
  final _rue = TextEditingController();
  final _codePostal = TextEditingController();
  final _ville = TextEditingController();
  final _pays = TextEditingController();
  var _quantite = 1;
  var _envoi = false;

  @override
  void initState() {
    super.initState();
    _nom = TextEditingController(
      text: ref.read(profilProvider).value?.nom ?? '',
    );
  }

  @override
  void dispose() {
    for (final c in [_nom, _rue, _codePostal, _ville, _pays]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _commander(Livre livre) async {
    if (!_cle.currentState!.validate()) return;
    final user = ref.read(utilisateurFirebaseProvider).value;
    if (user == null) return;
    setState(() => _envoi = true);
    try {
      final id = await ref
          .read(livresRepositoryProvider)
          .commander(
            uid: user.uid,
            nom: ref.read(profilProvider).value?.nom ?? _nom.text.trim(),
            livre: livre,
            langue: Localizations.localeOf(context).languageCode,
            quantite: _quantite,
            adresse: Adresse(
              nom: _nom.text,
              rue: _rue.text,
              codePostal: _codePostal.text,
              ville: _ville.text,
              pays: _pays.text,
            ),
          );
      if (mounted) context.pushReplacement('${widget.base}/commande/$id');
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
    if (!ref.watch(estConnecteProvider)) {
      return ConnexionRequise(titre: l10n.commanderAuCoach);
    }
    final livre = ref.watch(livreProvider(widget.id)).value;
    if (livre == null || !livre.commandable) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final langue = Localizations.localeOf(context).languageCode;

    Widget champ(TextEditingController c, String libelle, {int max = 100}) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextFormField(
            controller: c,
            decoration: InputDecoration(labelText: libelle),
            textCapitalization: TextCapitalization.words,
            validator: (v) {
              final t = (v ?? '').trim();
              return t.isEmpty || t.length > max ? l10n.champObligatoire : null;
            },
          ),
        );

    Widget montant(String libelle, double valeur, {bool fort = false}) => Row(
      children: [
        Expanded(child: Text(libelle)),
        Text(
          euros(context, valeur),
          style: fort ? theme.textTheme.titleMedium : null,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.commanderAuCoach)),
      body: Form(
        key: _cle,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(livre.titre(langue), style: theme.textTheme.titleLarge),
            Text(l10n.formatPapier),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Text(l10n.quantite)),
                IconButton.outlined(
                  tooltip: '−',
                  icon: const Icon(Icons.remove),
                  onPressed: _quantite > 1
                      ? () => setState(() => _quantite--)
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('$_quantite', style: theme.textTheme.titleLarge),
                ),
                IconButton.outlined(
                  tooltip: '+',
                  icon: const Icon(Icons.add),
                  onPressed: _quantite < 20
                      ? () => setState(() => _quantite++)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            montant(
              '$_quantite × ${euros(context, livre.prixPapier!)}',
              livre.prixPapier! * _quantite,
            ),
            montant(l10n.fraisEnvoi, livre.fraisEnvoi),
            const Divider(),
            montant(l10n.total, livre.montantCommande(_quantite), fort: true),
            const SizedBox(height: 24),
            Text(l10n.adresseLivraison, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            champ(_nom, l10n.champNom),
            champ(_rue, l10n.champRue, max: 200),
            champ(_codePostal, l10n.champCodePostal, max: 20),
            champ(_ville, l10n.champVille),
            champ(_pays, l10n.champPays),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _envoi ? null : () => _commander(livre),
              child: Text(l10n.commander),
            ),
          ],
        ),
      ),
    );
  }
}
