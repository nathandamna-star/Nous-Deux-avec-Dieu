import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/widgets/connexion_requise.dart';
import '../../shared/widgets/ecran_a_venir.dart';
import '../auth/auth_providers.dart';

class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (!ref.watch(estConnecteProvider)) {
      return ConnexionRequise(titre: l10n.navMessages);
    }
    return EcranAVenir(
      titre: l10n.navMessages,
      icone: Icons.chat_bubble_outline,
      texte: l10n.messagesAVenir,
    );
  }
}
