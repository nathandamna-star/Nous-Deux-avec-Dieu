import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/widgets/ecran_a_venir.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EcranAVenir(
      titre: l10n.navMessages,
      icone: Icons.chat_bubble_outline,
      texte: l10n.messagesAVenir,
    );
  }
}
