import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/livre.dart';

extension LibellesLivres on AppLocalizations {
  String format(TypeFormat t) => switch (t) {
    TypeFormat.papier => formatPapier,
    TypeFormat.numerique => formatNumerique,
    TypeFormat.audio => formatAudio,
  };

  String statutCommande(StatutCommande s) => switch (s) {
    StatutCommande.enAttente => commandeEnAttente,
    StatutCommande.payee => commandePayee,
    StatutCommande.envoyee => commandeEnvoyee,
    StatutCommande.annulee => commandeAnnulee,
  };
}

IconData iconeCommande(StatutCommande s) => switch (s) {
  StatutCommande.enAttente => Icons.hourglass_top,
  StatutCommande.payee => Icons.inventory_2_outlined,
  StatutCommande.envoyee => Icons.local_shipping_outlined,
  StatutCommande.annulee => Icons.cancel_outlined,
};

/// Couverture d'un livre (ou une icône si elle manque).
class Couverture extends StatelessWidget {
  const Couverture({super.key, required this.url, this.largeur = 56});

  final String url;
  final double largeur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vide = Container(
      width: largeur,
      height: largeur * 1.5,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(Icons.menu_book, color: theme.colorScheme.primary),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: url.isEmpty
          ? vide
          : Image.network(
              url,
              width: largeur,
              height: largeur * 1.5,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => vide,
            ),
    );
  }
}
