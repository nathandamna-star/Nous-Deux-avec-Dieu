import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/features/paiements/domain/virement.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'helpers.dart';

Future<void> donnees(Banc banc, {bool coordonnees = true}) async {
  await banc.firestore.doc('accompagnements/a1').set({
    'type': 'couple',
    'nom': 'Paul & Marie',
    'membres': ['u1', 'paul'],
    'noms': {'u1': 'Marie', 'paul': 'Paul'},
    'statut': 'actif',
    'seancesRestantes': 0,
    'createdAt': Timestamp.now(),
  });
  await banc.firestore.doc('forfaits/f5').set({
    'nom': {'fr': 'Forfait 5 séances', 'en': '5 sessions'},
    'nbSeances': 5,
    'prix': 250,
    'devise': 'EUR',
    'actif': true,
    'ordre': 0,
  });
  await banc.firestore.doc('forfaits/vieux').set({
    'nom': {'fr': 'Ancien forfait'},
    'nbSeances': 1,
    'prix': 60,
    'devise': 'EUR',
    'actif': false,
    'ordre': 1,
  });
  if (coordonnees) {
    await banc.firestore.doc('parametres/coach').set({
      'nomAffiche': 'Nathan',
      'titulaire': 'Nathan Damna',
      'iban': 'BE71096123456769',
      'bic': 'GKCCBEBB',
      'messageDon': {'fr': 'Merci de soutenir ce ministère !'},
    });
  }
}

Future<Map<String, dynamic>> seulPaiement(Banc banc) async {
  final docs = (await banc.firestore.collection('paiements').get()).docs;
  expect(docs, hasLength(1));
  expect(communicationValide(docs.single.id), isTrue);
  return {...docs.single.data(), 'id': docs.single.id};
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('acheter un forfait : QR code, IBAN, communication', (
    tester,
  ) async {
    final banc = await bancAvecProfil();
    await donnees(banc);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Séances').last);
    await tester.pumpAndSettle();
    expect(find.text('Forfait 5 séances'), findsOneWidget);
    expect(find.text('Ancien forfait'), findsNothing);

    await toucher(tester, find.text('Choisir'));
    final p = await seulPaiement(banc);
    expect(p['type'], 'forfait');
    expect(p['montant'], 250);
    expect(p['nbSeances'], 5);
    expect(p['accompagnementId'], 'a1');
    expect(p['statut'], 'en_attente');

    expect(find.byType(QrImageView), findsOneWidget);
    expect(find.text('BE71 0961 2345 6769'), findsOneWidget);
    expect(find.text(formaterCommunication(p['id'] as String)), findsOneWidget);
    expect(find.textContaining('250'), findsWidgets);

    // Retour : le paiement est listé, en attente.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Mes paiements'), findsOneWidget);
    expect(find.textContaining('En attente'), findsOneWidget);
  });

  testWidgets('sans coordonnées bancaires : message clair', (tester) async {
    final banc = await bancAvecProfil();
    await donnees(banc, coordonnees: false);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Séances').last);
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Choisir'));
    expect(find.textContaining('pas encore disponibles'), findsOneWidget);
    expect(find.byType(QrImageView), findsNothing);
    // On peut renoncer.
    await toucher(tester, find.text('Je ne paie pas finalement'));
    expect((await seulPaiement(banc))['statut'], 'annule');
  });

  testWidgets('faire un don depuis le profil', (tester) async {
    final banc = await bancAvecProfil();
    await donnees(banc);
    await banc.lancer(tester, grand: true);
    await ouvrirProfil(tester);
    await toucher(tester, find.text('Faire un don'));
    expect(find.text('Merci de soutenir ce ministère !'), findsOneWidget);
    expect(find.textContaining('ne donne accès à rien'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '0');
    await toucher(tester, find.text('Continuer'));
    expect(find.text('Entre 1 et 10 000 €'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '35,50');
    await toucher(tester, find.text('Continuer'));
    final p = await seulPaiement(banc);
    expect(p['type'], 'don');
    expect(p['montant'], 35.5);
    expect(p.containsKey('nbSeances'), isFalse);
    expect(find.byType(QrImageView), findsOneWidget);
  });

  testWidgets('sur iPhone : pas de don dans l\'app (règle 3.2.2)', (
    tester,
  ) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      final banc = await bancAvecProfil();
      await donnees(banc);
      await banc.lancer(tester, grand: true);
      await ouvrirProfil(tester);
      expect(find.text('Faire un don'), findsNothing);
      expect(find.textContaining('soutenir ce ministère'), findsOneWidget);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('le coach confirme un paiement reçu', (tester) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Coach', coach: true)
      ..maintenant = DateTime(2030, 3, 15);
    await donnees(banc);
    await banc.firestore.doc('paiements/100000000034').set({
      'type': 'forfait',
      'uid': 'u1',
      'nom': 'Marie',
      'accompagnementId': 'a1',
      'forfaitId': 'f5',
      'forfaitNom': 'Forfait 5 séances',
      'nbSeances': 5,
      'montant': 250,
      'devise': 'EUR',
      'statut': 'en_attente',
      'createdAt': Timestamp.fromDate(DateTime(2030, 3, 14)),
    });
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach').last);
    await tester.pumpAndSettle();
    expect(find.text('1'), findsWidgets); // pastille
    await toucher(tester, find.byTooltip('Paiements et dons'));
    expect(find.text('Marie'), findsOneWidget);
    expect(find.text('+++100/0000/00034+++'), findsOneWidget);

    await toucher(tester, find.widgetWithText(FilledButton, 'Paiement reçu'));
    expect(find.textContaining('+++100/0000/00034+++'), findsWidgets);
    await toucher(tester, find.text('Valider'));
    final d = (await banc.firestore.doc('paiements/100000000034').get())
        .data()!;
    expect(d['statut'], 'recu');
    // Les séances sont créditées par le serveur, pas par l'app.
    expect(
      (await banc.firestore.doc('accompagnements/a1').get())
          .data()!['seancesRestantes'],
      0,
    );
    expect(find.text('Aucun paiement.'), findsOneWidget);
  });

  testWidgets('le coach crée un forfait et saisit son IBAN', (tester) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Coach', coach: true);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach').last);
    await tester.pumpAndSettle();

    await toucher(tester, find.byTooltip('Plus'));
    await toucher(tester, find.text('Forfaits de séances'));
    expect(find.textContaining('Aucun forfait'), findsOneWidget);
    await toucher(tester, find.text('Nouveau forfait'));
    await tester.enterText(find.byType(TextFormField).at(0), 'Forfait 10');
    await tester.enterText(find.byType(TextFormField).at(5), '10');
    await tester.enterText(find.byType(TextFormField).at(6), '450,50');
    await toucher(tester, find.text('Enregistrer'));
    final f = (await banc.firestore.collection('forfaits').get()).docs.single
        .data();
    expect(f['nom'], {'fr': 'Forfait 10'});
    expect(f['nbSeances'], 10);
    expect(f['prix'], 450.5);
    expect(f['actif'], isTrue);
    expect(find.text('Forfait 10'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await toucher(tester, find.byTooltip('Plus'));
    await toucher(tester, find.text('Paramètres du coach'));
    await tester.enterText(find.byType(TextFormField).at(1), 'Nathan Damna');
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'BE72 0961 2345 6769',
    );
    await toucher(tester, find.text('Enregistrer'));
    expect(find.textContaining('IBAN invalide'), findsOneWidget);
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'be71 0961 2345 6769',
    );
    await toucher(tester, find.text('Enregistrer'));
    final p = (await banc.firestore.doc('parametres/coach').get()).data()!;
    expect(p['iban'], 'BE71096123456769');
    expect(p['titulaire'], 'Nathan Damna');
  });
}
