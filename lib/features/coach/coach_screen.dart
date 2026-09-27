import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/widgets/ecran_a_venir.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EcranAVenir(
      titre: l10n.navCoach,
      icone: Icons.volunteer_activism_outlined,
      texte: l10n.coachAVenir,
    );
  }
}
