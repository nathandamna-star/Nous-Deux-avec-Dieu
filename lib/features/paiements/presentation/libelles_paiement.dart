import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/paiement.dart';

/// « 250,00 € » dans la langue de l'app.
String euros(BuildContext context, double montant) => NumberFormat.currency(
  locale: Localizations.localeOf(context).toLanguageTag(),
  symbol: '€',
  decimalDigits: montant == montant.roundToDouble() ? 0 : 2,
).format(montant);

extension LibellesPaiement on AppLocalizations {
  String statutPaiement(StatutPaiement s) => switch (s) {
    StatutPaiement.enAttente => paiementEnAttente,
    StatutPaiement.recu => paiementRecu,
    StatutPaiement.annule => paiementAnnule,
  };

  String objetPaiement(Paiement p) =>
      p.type == TypePaiement.don ? don : p.forfaitNom;
}

IconData iconeStatut(StatutPaiement s) => switch (s) {
  StatutPaiement.enAttente => Icons.hourglass_top,
  StatutPaiement.recu => Icons.check_circle,
  StatutPaiement.annule => Icons.cancel_outlined,
};
