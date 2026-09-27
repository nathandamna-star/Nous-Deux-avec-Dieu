import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/widgets/ecran_a_venir.dart';

class ContenusScreen extends StatelessWidget {
  const ContenusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EcranAVenir(
      titre: l10n.navContenus,
      icone: Icons.auto_stories_outlined,
      texte: l10n.contenusAVenir,
    );
  }
}
