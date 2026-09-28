import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/features/parcours/domain/parcours.dart';

import 'helpers.dart';

Map<String, dynamic> contenu(String titre) => {
  'type': 'meditation',
  'theme': 'communication',
  'titre': {'fr': titre},
  'texte': {'fr': 'Texte de $titre'},
  'visibilite': 'public',
  'publie': true,
  'ordre': 0,
  'createdAt': Timestamp.now(),
};

Future<void> preparer(Banc banc) async {
  final db = banc.firestore;
  await db.doc('contenus/c1').set(contenu('Jour 1 : écouter'));
  await db.doc('contenus/c2').set(contenu('Jour 2 : parler'));
  await db.doc('parcours/p1').set({
    'titre': {'fr': 'Mieux communiquer'},
    'description': {'fr': 'Deux jours pour mieux se parler.'},
    'etapes': ['c1', 'c2'],
    'visibilite': 'public',
    'publie': true,
    'ordre': 0,
    'createdAt': Timestamp.now(),
  });
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  test('progression : étapes faites et prochaine étape', () {
    const p = Parcours(
      id: 'p',
      titres: {},
      descriptions: {},
      etapes: ['a', 'b', 'c'],
    );
    const prog = Progression({'a', 'x'});
    expect(prog.nbFaits(p), 1);
    expect(prog.prochaine(p), 'b');
    expect(const Progression({'a', 'b', 'c'}).prochaine(p), isNull);
  });

  testWidgets('suivre un parcours étape par étape', (tester) async {
    final banc = await bancAvecProfil();
    await preparer(banc);
    await banc.lancer(tester);
    await tester.tap(find.text('Contenus'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Parcours'));
    expect(find.text('Mieux communiquer'), findsOneWidget);
    expect(find.text('0 / 2 étapes'), findsOneWidget);

    await toucher(tester, find.text('Mieux communiquer'));
    await toucher(tester, find.text('Commencer'));
    expect(find.text('Texte de Jour 1 : écouter'), findsOneWidget);
    await toucher(tester, find.text('Marquer comme fait'));

    // Retour au parcours : une étape faite, on continue avec la deuxième.
    expect(find.text('1 / 2 étapes'), findsOneWidget);
    expect(
      (await banc.firestore.doc('users/u1/progression/p1').get())
          .data()!['faits'],
      ['c1'],
    );
    await toucher(tester, find.text('Continuer'));
    expect(find.text('Texte de Jour 2 : parler'), findsOneWidget);
    await toucher(tester, find.text('Marquer comme fait'));
    expect(find.text('Parcours terminé. Bravo à vous !'), findsOneWidget);
  });

  testWidgets('sans compte : lecture possible, pas de progression', (
    tester,
  ) async {
    final banc = Banc();
    await preparer(banc);
    await banc.lancer(tester);
    await tester.tap(find.text('Contenus'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Parcours'));
    await toucher(tester, find.text('Mieux communiquer'));
    expect(
      find.text('Connectez-vous pour suivre votre progression.'),
      findsOneWidget,
    );
    await toucher(tester, find.text('Jour 1 : écouter'));
    expect(find.text('Marquer comme fait'), findsNothing);
  });

  testWidgets('le coach crée un parcours avec deux étapes', (tester) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await banc.firestore.doc('contenus/c1').set(contenu('Jour 1 : écouter'));
    await banc.firestore.doc('contenus/c2').set(contenu('Jour 2 : parler'));
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Mes contenus'));
    await toucher(tester, find.text('Mes parcours'));
    await toucher(tester, find.text('Nouveau parcours'));

    await tester.enterText(
      find.widgetWithText(TextField, 'Titre (FR)'),
      'Mieux communiquer',
    );
    await toucher(tester, find.text('Enregistrer'));
    expect(find.text('Ajoutez au moins une étape.'), findsOneWidget);

    await toucher(tester, find.text('Ajouter une étape'));
    await toucher(tester, find.text('Jour 2 : parler'));
    await toucher(tester, find.text('Ajouter une étape'));
    await toucher(tester, find.text('Jour 1 : écouter').last);
    await toucher(tester, find.text('Publier'));
    await toucher(tester, find.text('Enregistrer'));

    final d = (await banc.firestore.collection('parcours').get()).docs.single
        .data();
    expect(d['titre'], {'fr': 'Mieux communiquer'});
    expect(d['etapes'], ['c2', 'c1']);
    expect(d['publie'], isTrue);
    expect(find.text('2 étapes'), findsOneWidget);
  });
}
