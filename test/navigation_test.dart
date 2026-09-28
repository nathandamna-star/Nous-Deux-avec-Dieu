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
    expect(find.text('Découvrir tous les contenus'), findsOneWidget);

    await tester.tap(find.text('Séances'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('une fois votre accompagnement'),
      findsOneWidget,
    );

    await tester.tap(find.text('Contenus'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Aucun contenu'), findsOneWidget);
  });

  testWidgets('onglet Coach pour le coach seulement', (tester) async {
    await bancConnecte(coach: true).lancer(tester);
    expect(find.byType(NavigationDestination), findsNWidgets(6));
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    expect(find.text('Demandes'), findsOneWidget);
  });

  for (final (langue, accueil, bientot) in [
    ('en', 'Home', 'Explore all content'),
    ('pt', 'Início', 'Descobrir todos os conteúdos'),
    ('es', 'Inicio', 'Descubrir todos los contenidos'),
    ('nl', 'Start', 'Alle inhoud ontdekken'),
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
