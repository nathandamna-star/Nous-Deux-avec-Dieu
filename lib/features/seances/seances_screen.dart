import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/widgets/connexion_requise.dart';
import '../../shared/widgets/ecran_a_venir.dart';
import '../auth/auth_providers.dart';

class SeancesScreen extends ConsumerWidget {
  const SeancesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (!ref.watch(estConnecteProvider)) {
      return ConnexionRequise(titre: l10n.navSeances);
    }
    return EcranAVenir(
      titre: l10n.navSeances,
      icone: Icons.event_outlined,
      texte: l10n.seancesAVenir,
    );
  }
}
