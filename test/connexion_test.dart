import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('premier lancement : bienvenue, puis découverte sans compte', (
    tester,
  ) async {
    final banc = Banc();
    await banc.lancer(tester, bienvenueVue: false);
    expect(find.text('Qu\'est-ce qui vous amène ?'), findsOneWidget);
    await toucher(tester, find.text('Découvrir sans compte'));
    expect(find.text('Découvrir tous les contenus'), findsOneWidget);

    // Les espaces personnels demandent une connexion.
    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(find.text('Un espace rien qu\'à vous'), findsOneWidget);
  });

  testWidgets('inscription : consentement obligatoire, profil créé', (
    tester,
  ) async {
    final banc = Banc();
    await banc.lancer(tester, bienvenueVue: false);
    await toucher(tester, find.text('Je viens seul(e)'));
    await toucher(tester, find.text('Continuer avec l\'e-mail'));
    await toucher(tester, find.text('Créer un compte').first);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Prénom et nom'),
      'Paul Mbala',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Adresse e-mail'),
      'paul@exemple.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Mot de passe'),
      'unmotdepasse',
    );
    await toucher(tester, find.widgetWithText(FilledButton, 'Créer un compte'));
    expect(
      find.text('Cochez la case pour créer votre compte.'),
      findsOneWidget,
    );
    expect(banc.auth.currentUser, isNull);

    await toucher(tester, find.byType(Checkbox));
    await toucher(tester, find.widgetWithText(FilledButton, 'Créer un compte'));

    final uid = banc.auth.currentUser!.uid;
    final profil = (await banc.firestore.doc('users/$uid').get()).data()!;
    expect(profil['nom'], 'Paul Mbala');
    expect(profil['parcours'], 'seul');
    expect(profil['langue'], 'fr');
    expect(profil['consentementLe'], isNotNull);
    // Connecté : retour à l'accueil, profil accessible.
    expect(find.text('Découvrir tous les contenus'), findsOneWidget);
    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();
    expect(find.text('Bonjour Paul Mbala'), findsOneWidget);
  });

  testWidgets('déconnexion depuis le profil', (tester) async {
    final banc = bancConnecte();
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Se déconnecter'));
    expect(banc.auth.currentUser, isNull);
    expect(find.text('Un espace rien qu\'à vous'), findsOneWidget);
  });

  testWidgets('interface de bienvenue en néerlandais', (tester) async {
    await Banc().lancer(
      tester,
      bienvenueVue: false,
      locale: const Locale('nl'),
    );
    expect(find.text('Wat brengt je hier?'), findsOneWidget);
    expect(find.text('We komen als koppel'), findsOneWidget);
  });
}
