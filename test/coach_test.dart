import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers.dart';

Future<void> preparer(Banc banc) async {
  await banc.firestore.doc('accompagnements/a1').set({
    'type': 'couple',
    'nom': 'Paul & Marie',
    'membres': ['marie'],
    'noms': {'marie': 'Marie'},
    'codeInvitation': 'ABC234',
    'statut': 'demande',
    'message': 'Nous voulons mieux communiquer.',
    'createdAt': Timestamp.fromDate(DateTime(2026, 9, 28)),
  });
  await banc.firestore.doc('accompagnements/a2').set({
    'type': 'individuel',
    'nom': 'Jean',
    'membres': ['jean'],
    'noms': {'jean': 'Jean'},
    'statut': 'actif',
    'seancesRestantes': 2,
    'createdAt': Timestamp.fromDate(DateTime(2026, 9, 1)),
  });
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('le coach accepte une demande, gère séances et notes', (
    tester,
  ) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await preparer(banc);
    await banc.lancer(tester);
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();

    // Onglet Demandes par défaut : seulement la demande.
    expect(find.text('Paul & Marie'), findsOneWidget);
    expect(find.text('Jean'), findsNothing);
    await toucher(tester, find.text('Paul & Marie'));
    expect(find.text('Nous voulons mieux communiquer.'), findsOneWidget);
    expect(find.text('En attente du conjoint'), findsOneWidget);

    await toucher(tester, find.text('Accepter'));
    await toucher(tester, find.byTooltip('Ajouter une séance'));
    await toucher(tester, find.byTooltip('Ajouter une séance'));
    expect(find.text('2 séances restantes'), findsOneWidget);
    await toucher(tester, find.byTooltip('Retirer une séance'));

    await tester.enterText(
      find.widgetWithText(TextField, 'Nouvelle note'),
      'Première séance : écoute active.',
    );
    await toucher(tester, find.byTooltip('Ajouter'));
    expect(find.text('Première séance : écoute active.'), findsOneWidget);

    final d = (await banc.firestore.doc('accompagnements/a1').get()).data()!;
    expect(d['statut'], 'actif');
    expect(d['seancesRestantes'], 1);
    final notes = await banc.firestore
        .collection('accompagnements/a1/notes')
        .get();
    expect(
      notes.docs.single.data()['texte'],
      'Première séance : écoute active.',
    );

    await toucher(tester, find.byTooltip('Supprimer'));
    expect(find.text('Aucune note pour l\'instant.'), findsOneWidget);
  });

  testWidgets('filtre En cours', (tester) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await preparer(banc);
    await banc.lancer(tester);
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('En cours'));
    expect(find.text('Jean'), findsOneWidget);
    expect(find.text('Paul & Marie'), findsNothing);
  });

  testWidgets('activation de l\'espace coach par appui long', (tester) async {
    final banc = await bancAvecProfil();
    await banc.lancer(tester);
    await ouvrirProfil(tester);
    await tester.longPress(find.text('Bonjour Marie'));
    await tester.pumpAndSettle();
    expect(find.text('Activer l\'espace coach ?'), findsOneWidget);
    await toucher(tester, find.text('Valider'));
    expect(banc.fonctions.appels, 1);
    expect(find.text('Espace coach activé.'), findsOneWidget);
  });

  testWidgets('activation refusée pour un autre compte', (tester) async {
    final banc = await bancAvecProfil()
      ..fonctions.refuser = true;
    await banc.lancer(tester);
    await ouvrirProfil(tester);
    await tester.longPress(find.text('Bonjour Marie'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Valider'));
    expect(find.text('Ce compte ne peut pas devenir coach.'), findsOneWidget);
  });
}
