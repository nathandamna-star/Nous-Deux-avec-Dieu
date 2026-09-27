import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Écran provisoire : titre, icône et ce que l'écran contiendra.
class EcranAVenir extends StatelessWidget {
  const EcranAVenir({
    super.key,
    required this.titre,
    required this.icone,
    required this.texte,
  });

  final String titre;
  final IconData icone;
  final String texte;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(titre)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icone, size: 56, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(l10n.bientot, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                texte,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
