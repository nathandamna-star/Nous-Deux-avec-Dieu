import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/features/messages/domain/message.dart';

import 'helpers.dart';

Future<void> accompagnement(
  Banc banc, {
  Map<String, int> nonLus = const {},
  int nonLusCoach = 0,
}) => banc.firestore.doc('accompagnements/a1').set({
  'type': 'couple',
  'nom': 'Paul & Marie',
  'membres': ['u1', 'paul'],
  'noms': {'u1': 'Marie', 'paul': 'Paul'},
  'statut': 'actif',
  'nonLus': nonLus,
  'nonLusCoach': nonLusCoach,
  'createdAt': Timestamp.now(),
});

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  test('aperçu du dernier message', () {
    expect(apercuMessage(texte: '  Bonjour  à tous '), 'Bonjour à tous');
    expect(apercuMessage(texte: '', vocal: true), '🎤');
    expect(apercuMessage(texte: '', photo: true), '📷');
  });

  testWidgets('sans accompagnement : invitation à en demander un', (
    tester,
  ) async {
    final banc = await bancAvecProfil();
    await banc.lancer(tester);
    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('demandez d\'abord un accompagnement'),
      findsOneWidget,
    );
  });

  testWidgets('un membre écrit, envoie une photo et un vocal', (tester) async {
    final banc = await bancAvecProfil();
    await accompagnement(banc, nonLus: {'u1': 2});
    await banc.lancer(tester);
    expect(find.text('2'), findsWidgets); // pastille de l'onglet
    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(find.text('Votre coach'), findsOneWidget);
    // Ouvrir la conversation remet ses non-lus à zéro.
    expect(
      (await banc.firestore.doc('accompagnements/a1').get()).data()!['nonLus'],
      {'u1': 0},
    );

    await tester.enterText(find.byType(TextField), 'Bonjour coach !');
    await toucher(tester, find.byTooltip('Envoyer'));
    expect(find.text('Bonjour coach !'), findsOneWidget);

    await toucher(tester, find.byTooltip('Envoyer une photo'));
    await toucher(tester, find.text('Choisir dans la galerie'));
    await toucher(tester, find.byTooltip('Message vocal'));
    expect(banc.pieces.enregistre, isTrue);
    expect(find.textContaining('Enregistrement…'), findsOneWidget);
    await toucher(tester, find.byTooltip('Arrêter et envoyer'));
    expect(
      find.text('message vocal : https://stockage.test/messages/a1/vocal.m4a'),
      findsOneWidget,
    );

    final msgs = await banc.firestore
        .collection('accompagnements/a1/messages')
        .get();
    expect(msgs.docs, hasLength(3));
    expect(msgs.docs.every((d) => d.data()['auteur'] == 'u1'), isTrue);
    final a = (await banc.firestore.doc('accompagnements/a1').get()).data()!;
    expect(a['nonLusCoach'], 3);
    expect(a['dernierMessage'], '🎤');
  });

  testWidgets('micro refusé : message d\'aide', (tester) async {
    final banc = await bancAvecProfil();
    banc.pieces.micro = false;
    await accompagnement(banc);
    await banc.lancer(tester);
    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    await toucher(tester, find.byTooltip('Message vocal'));
    expect(find.textContaining('L\'accès au micro est refusé'), findsOneWidget);
  });

  testWidgets('le coach voit ses conversations et répond', (tester) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await accompagnement(banc, nonLusCoach: 1);
    await banc.firestore.doc('accompagnements/a1/messages/m1').set({
      'auteur': 'paul',
      'texte': 'Merci pour la séance.',
      'createdAt': Timestamp.now(),
    });
    await banc.firestore.doc('accompagnements/a1').update({
      'dernierMessage': 'Merci pour la séance.',
      'dernierMessageLe': Timestamp.now(),
    });
    await banc.lancer(tester);
    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(find.text('Paul & Marie'), findsOneWidget);
    expect(find.text('Merci pour la séance.'), findsOneWidget);

    await toucher(tester, find.text('Paul & Marie'));
    expect(find.text('Paul'), findsOneWidget); // auteur du message
    await tester.enterText(find.byType(TextField), 'Avec plaisir !');
    await toucher(tester, find.byTooltip('Envoyer'));

    final a = (await banc.firestore.doc('accompagnements/a1').get()).data()!;
    expect(a['nonLusCoach'], 0);
    expect(a['nonLus'], {'u1': 1, 'paul': 1});
  });

  testWidgets('notifications activées à la connexion, notification touchée', (
    tester,
  ) async {
    final banc = await bancAvecProfil();
    await accompagnement(banc);
    await banc.firestore.doc('accompagnements/a1/exercices/e1').set({
      'titre': 'Trois qualités',
      'consignes': 'x',
      'mode': 'seul',
      'repondu': <String>[],
      'statut': 'a_faire',
      'createdAt': Timestamp.now(),
    });
    await banc.lancer(tester);
    expect(banc.notifications.actives, ['u1']);
    banc.notifications.touchees.add({'exerciceId': 'e1'});
    await tester.pumpAndSettle();
    expect(find.text('Enregistrer ma réponse'), findsOneWidget);
    banc.notifications.touchees.add({'accompagnementId': 'a1'});
    await tester.pumpAndSettle();
    expect(find.text('Votre coach'), findsOneWidget);
  });
}
