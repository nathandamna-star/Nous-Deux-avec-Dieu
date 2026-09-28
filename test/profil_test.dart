import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets(
    'changer la langue de l\'app, enregistrée pour les notifications',
    (tester) async {
      final banc = await bancAvecProfil();
      await banc.lancer(tester, grand: true);
      await ouvrirProfil(tester);
      await toucher(tester, find.text('Langue de l\'application'));
      await toucher(tester, find.text('Nederlands'));
      expect(find.text('Taal van de app'), findsOneWidget);
      expect(find.text('Profiel'), findsWidgets);
      expect(
        (await banc.firestore.doc('users/u1').get()).data()!['langue'],
        'nl',
      );
      await toucher(tester, find.text('Taal van de app'));
      await toucher(tester, find.text('Taal van de telefoon'));
      expect(find.text('Langue de l\'application'), findsOneWidget);
    },
  );

  testWidgets('pages légales accessibles sans compte', (tester) async {
    final banc = Banc();
    await banc.lancer(tester, grand: true, bienvenueVue: false);
    await toucher(tester, find.text('Confidentialité'));
    expect(find.text('Politique de confidentialité'), findsOneWidget);
    expect(find.textContaining('article 9 du RGPD'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    await toucher(tester, find.text('Découvrir sans compte'));
    await ouvrirProfil(tester);
    await toucher(tester, find.text('Aide et contact'));
    expect(find.text('Questions fréquentes'), findsOneWidget);
  });

  testWidgets('télécharger ses données', (tester) async {
    final banc = await bancAvecProfil();
    await banc.lancer(tester, grand: true);
    await ouvrirProfil(tester);
    await toucher(tester, find.text('Télécharger mes données'));
    expect(banc.compte.exports, 1);
    expect(
      banc.partage.fichiers['mes-donnees-nous-deux-avec-dieu.json'],
      contains('Marie'),
    );
  });

  testWidgets('supprimer son compte : confirmation, puis déconnexion', (
    tester,
  ) async {
    final banc = await bancAvecProfil();
    await banc.lancer(tester, grand: true);
    await ouvrirProfil(tester);

    // Refus du serveur : message clair, rien n'est fait.
    banc.compte.erreur = 'commande-en-cours';
    await toucher(tester, find.text('Supprimer mon compte'));
    await toucher(tester, find.text('Supprimer définitivement'));
    expect(find.textContaining('pas encore été envoyé'), findsOneWidget);
    expect(banc.auth.currentUser, isNotNull);

    banc.compte.erreur = null;
    await toucher(tester, find.text('Supprimer mon compte'));
    await toucher(tester, find.text('Annuler'));
    expect(banc.compte.suppressions, 0);
    await toucher(tester, find.text('Supprimer mon compte'));
    await toucher(tester, find.text('Supprimer définitivement'));
    expect(banc.compte.suppressions, 1);
    expect(banc.auth.currentUser, isNull);
    expect(find.text('Votre compte a été supprimé.'), findsOneWidget);
  });

  testWidgets('le coach se présente ; tout le monde le voit à l\'accueil', (
    tester,
  ) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Coach', coach: true);
    await banc.lancer(tester, grand: true);
    await ouvrirProfil(tester);
    // Pas de suppression de compte pour le coach.
    expect(find.text('Supprimer mon compte'), findsNothing);

    await tester.tap(find.text('Coach').last);
    await tester.pumpAndSettle();
    await toucher(tester, find.byTooltip('Plus'));
    await toucher(tester, find.text('Paramètres du coach'));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nom affiché'),
      'Nathan Damna',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Présentation (FR)'),
      'Coach de couple chrétien depuis dix ans.',
    );
    await toucher(tester, find.text('Enregistrer'));
    final p = (await banc.firestore.doc('parametres/presentation').get())
        .data()!;
    expect(p['nomAffiche'], 'Nathan Damna');
    expect(p['bio'], {'fr': 'Coach de couple chrétien depuis dix ans.'});

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Accueil'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Nathan Damna'));
    expect(
      find.text('Coach de couple chrétien depuis dix ans.'),
      findsOneWidget,
    );
  });
}
