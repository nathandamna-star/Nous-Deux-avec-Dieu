import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/widgets/ecran_a_venir.dart';

class AccueilScreen extends StatelessWidget {
  const AccueilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EcranAVenir(
      titre: l10n.navAccueil,
      icone: Icons.wb_sunny_outlined,
      texte: l10n.accueilAVenir,
    );
  }
}
