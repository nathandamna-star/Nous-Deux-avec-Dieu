import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('le coach charge les contenus de départ', (tester) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Coach', coach: true);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach').last);
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Mes contenus'));
    await toucher(
      tester,
      find.widgetWithText(FilledButton, 'Contenus de départ'),
    );
    expect(find.textContaining('30 méditations'), findsOneWidget);
    await toucher(tester, find.text('Annuler'));
    expect(banc.fonctions.chargements, 0);

    await toucher(tester, find.byTooltip('Plus').last);
    await toucher(tester, find.text('Contenus de départ').last);
    await toucher(tester, find.text('Charger'));
    expect(banc.fonctions.chargements, 1);
    expect(find.text('114 contenus ajoutés.'), findsOneWidget);
  });
}
