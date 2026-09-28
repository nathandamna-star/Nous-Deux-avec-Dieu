import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/features/exercices/domain/exercice.dart';

import 'helpers.dart';

Future<void> accompagnement(Banc banc, {List<String>? membres}) =>
    banc.firestore.doc('accompagnements/a1').set({
      'type': 'couple',
      'nom': 'Paul & Marie',
      'membres': membres ?? ['u1', 'paul'],
      'noms': {'u1': 'Marie', 'paul': 'Paul'},
      'statut': 'actif',
      'createdAt': Timestamp.now(),
    });

Future<void> exercice(Banc banc, String id, String mode, {String? contenuId}) =>
    banc.firestore.doc('accompagnements/a1/exercices/$id').set({
      'titre': 'Trois qualités',
      'consignes': 'Écrivez trois qualités de votre conjoint.',
      'mode': mode,
      'contenuId': ?contenuId,
      'repondu': <String>[],
      'statut': 'a_faire',
      'createdAt': Timestamp.now(),
    });

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  test('exercice fait : réponse commune, ou chaque membre a répondu', () {
    expect(
      Exercice.estFait(ModeExercice.aDeux, ['u1'], ['u1', 'paul']),
      isTrue,
    );
    expect(
      Exercice.estFait(ModeExercice.seul, ['u1'], ['u1', 'paul']),
      isFalse,
    );
    expect(
      Exercice.estFait(ModeExercice.seul, ['paul', 'u1'], ['u1', 'paul']),
      isTrue,
    );
  });

  testWidgets('chacun de son côté : Marie répond, l\'exercice reste à faire', (
    tester,
  ) async {
    final banc = await bancAvecProfil();
    await accompagnement(banc);
    await exercice(banc, 'e1', 'seul');
    await banc.lancer(tester);

    expect(find.text('1 exercice à faire'), findsOneWidget);
    await toucher(tester, find.text('Mes exercices'));
    await toucher(tester, find.text('Trois qualités'));
    expect(
      find.text('Votre réponse est vue seulement par vous et votre coach.'),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextField), 'Patient, drôle, fidèle.');
    await toucher(tester, find.text('Enregistrer ma réponse'));

    final rep = await banc.firestore
        .doc('accompagnements/a1/exercices/e1/reponses/u1')
        .get();
    expect(rep.data()!['texte'], 'Patient, drôle, fidèle.');
    expect(rep.data()!['auteur'], 'u1');
    final ex =
        (await banc.firestore.doc('accompagnements/a1/exercices/e1').get())
            .data()!;
    expect(ex['repondu'], ['u1']);
    expect(ex['statut'], 'a_faire');
  });

  testWidgets('à deux : une réponse commune termine l\'exercice', (
    tester,
  ) async {
    final banc = await bancAvecProfil();
    await accompagnement(banc);
    await exercice(banc, 'e1', 'a_deux');
    await banc.lancer(tester);
    await toucher(tester, find.text('Mes exercices'));
    await toucher(tester, find.text('Trois qualités'));
    expect(find.text('Notre réponse'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Nous prions ensemble.');
    await toucher(tester, find.text('Enregistrer ma réponse'));
    expect(
      (await banc.firestore
              .doc('accompagnements/a1/exercices/e1/reponses/couple')
              .get())
          .data()!['texte'],
      'Nous prions ensemble.',
    );
    expect(
      (await banc.firestore.doc('accompagnements/a1/exercices/e1').get())
          .data()!['statut'],
      'fait',
    );
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Fait'), findsOneWidget);
  });

  testWidgets('le coach envoie un exercice et lit les réponses', (
    tester,
  ) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await accompagnement(banc, membres: ['marie', 'paul']);
    await banc.firestore.doc('accompagnements/a1').update({
      'noms': {'marie': 'Marie', 'paul': 'Paul'},
    });
    await banc.firestore.doc('contenus/q1').set({
      'type': 'question',
      'theme': 'communication',
      'titre': {'fr': 'Ce que j\'admire chez toi'},
      'texte': {'fr': 'Dites à votre conjoint ce que vous admirez.'},
      'publie': true,
      'visibilite': 'public',
      'ordre': 0,
      'createdAt': Timestamp.now(),
    });
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('En cours'));
    await toucher(tester, find.text('Paul & Marie'));
    await toucher(tester, find.text('Envoyer un exercice'));

    await toucher(tester, find.text('Aucun'));
    await toucher(tester, find.text('Ce que j\'admire chez toi').last);
    await toucher(tester, find.text('À faire à deux'));
    await toucher(tester, find.text('Envoyer'));

    final docs =
        (await banc.firestore.collection('accompagnements/a1/exercices').get())
            .docs;
    final d = docs.single.data();
    expect(d['titre'], 'Ce que j\'admire chez toi');
    expect(d['consignes'], 'Dites à votre conjoint ce que vous admirez.');
    expect(d['mode'], 'a_deux');
    expect(d['contenuId'], 'q1');

    await banc.firestore
        .doc('accompagnements/a1/exercices/${docs.single.id}/reponses/couple')
        .set({'texte': 'Ta patience.', 'auteur': 'marie'});
    await toucher(tester, find.text('Ce que j\'admire chez toi'));
    expect(find.text('Réponse commune'), findsOneWidget);
    expect(find.text('Ta patience.'), findsOneWidget);
  });
}
