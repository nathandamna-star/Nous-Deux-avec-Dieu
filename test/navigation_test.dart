import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('cinq onglets, navigation entre les écrans', (tester) async {
    await bancConnecte().lancer(tester);
    expect(find.byType(NavigationDestination), findsNWidgets(5));
    expect(find.text('Coach'), findsNothing);
    expect(find.textContaining('méditation du jour'), findsOneWidget);

    await tester.tap(find.text('Séances'));
    await tester.pumpAndSettle();
    expect(find.textContaining('séances restantes'), findsOneWidget);

    await tester.tap(find.text('Contenus'));
    await tester.pumpAndSettle();
    expect(find.textContaining('audios et vidéos'), findsOneWidget);
  });

  testWidgets('onglet Coach pour le coach seulement', (tester) async {
    await bancConnecte(coach: true).lancer(tester);
    expect(find.byType(NavigationDestination), findsNWidgets(6));
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    expect(find.textContaining('vos accompagnements'), findsOneWidget);
  });

  for (final (langue, accueil, bientot) in [
    ('en', 'Home', 'Coming soon'),
    ('pt', 'Início', 'Em breve'),
    ('es', 'Inicio', 'Próximamente'),
    ('nl', 'Start', 'Binnenkort beschikbaar'),
  ]) {
    testWidgets('interface traduite : $langue', (tester) async {
      await bancConnecte().lancer(tester, locale: Locale(langue));
      expect(find.text(accueil), findsWidgets);
      expect(find.text(bientot), findsOneWidget);
    });
  }

  testWidgets('langue non prise en charge : français', (tester) async {
    await bancConnecte().lancer(tester, locale: const Locale('de'));
    expect(find.text('Accueil'), findsWidgets);
  });
}
