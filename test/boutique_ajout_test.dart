import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('le coach ajoute un audio depuis l\'onglet Contenus', (
    tester,
  ) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Contenus'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Ajouter un audio ou une vidéo'));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Titre (FR)'),
      'Prier ensemble le soir',
    );
    // Type « Audio » déjà choisi : il suffit d'envoyer le fichier.
    await toucher(tester, find.text('Choisir le fichier'));
    await toucher(tester, find.text('Enregistrer'));
    final c = (await banc.firestore.collection('contenus').get()).docs.single
        .data();
    expect(c['type'], 'audio');
    expect(c['titre'], containsPair('fr', 'Prier ensemble le soir'));
  });

  testWidgets('le coach ajoute un autre article depuis l\'onglet Boutique', (
    tester,
  ) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await banc.firestore.doc('livres/l1').set({
      'titre': {'fr': 'Aimer selon Dieu'},
      'publie': true,
      'ordre': 0,
      'categorie': 'livre',
    });
    await banc.firestore.doc('livres/a1').set({
      'titre': {'fr': 'Agenda du couple'},
      'publie': true,
      'ordre': 1,
      'categorie': 'autre',
    });
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Boutique'));
    await tester.pumpAndSettle();
    expect(find.text('Aimer selon Dieu'), findsOneWidget);
    await toucher(tester, find.text('Autres articles'));
    expect(find.text('Aimer selon Dieu'), findsNothing);
    expect(find.text('Agenda du couple'), findsOneWidget);

    await toucher(tester, find.text('Ajouter un article'));
    expect(find.text('Nouvel article'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Titre (FR)'),
      'Carte de prière',
    );
    await toucher(tester, find.text('Enregistrer'));
    final docs = (await banc.firestore.collection('livres').get()).docs;
    final nouveau = docs.firstWhere(
      (d) => (d['titre'] as Map)['fr'] == 'Carte de prière',
    );
    expect(nouveau['categorie'], 'autre');
  });
}
