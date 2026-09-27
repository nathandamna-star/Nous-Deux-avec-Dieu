import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/widgets/ecran_a_venir.dart';

class SeancesScreen extends StatelessWidget {
  const SeancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EcranAVenir(
      titre: l10n.navSeances,
      icone: Icons.event_outlined,
      texte: l10n.seancesAVenir,
    );
  }
}
