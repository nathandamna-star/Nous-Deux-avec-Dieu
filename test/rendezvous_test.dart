import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/features/rendezvous/domain/rendez_vous.dart';

import 'helpers.dart';

final maintenant = DateTime(2030, 1, 10, 8);

Future<void> accompagnement(Banc banc, {int seances = 3}) =>
    banc.firestore.doc('accompagnements/a1').set({
      'type': 'couple',
      'nom': 'Paul & Marie',
      'membres': ['u1', 'paul'],
      'noms': {'u1': 'Marie', 'paul': 'Paul'},
      'statut': 'actif',
      'seancesRestantes': seances,
      'createdAt': Timestamp.now(),
    });

Future<void> rdv(
  Banc banc,
  String id,
  DateTime debut, {
  String statut = 'prevu',
  String lien = 'https://zoom.us/j/123',
}) => banc.firestore.doc('accompagnements/a1/rendezVous/$id').set({
  'nom': 'Paul & Marie',
  'debut': Timestamp.fromDate(debut),
  'dureeMin': 60,
  'lienZoom': lien,
  'statut': statut,
  'rappelVeille': false,
  'rappelHeure': false,
});

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  test('lien de visio : https seulement', () {
    expect(lienVisioValide('https://zoom.us/j/123?pwd=abc'), isTrue);
    expect(lienVisioValide('http://zoom.us/j/123'), isFalse);
    expect(lienVisioValide('zoom'), isFalse);
    expect(lienVisioValide('javascript:alert(1)'), isFalse);
  });

  testWidgets('sans accompagnement : explication', (tester) async {
    final banc = await bancAvecProfil();
    await banc.lancer(tester);
    await tester.tap(find.text('Séances'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('une fois votre accompagnement'),
      findsOneWidget,
    );
  });

  testWidgets('séances : à venir avec Zoom, historique, séances restantes', (
    tester,
  ) async {
    final banc = await bancAvecProfil()
      ..maintenant = maintenant;
    await accompagnement(banc);
    await rdv(banc, 'r1', DateTime(2030, 1, 14, 19));
    await rdv(banc, 'r2', DateTime(2030, 1, 3, 19), statut: 'fait');
    await rdv(banc, 'r3', DateTime(2030, 1, 20, 19), statut: 'annule');
    await rdv(banc, 'r4', DateTime(2030, 1, 21, 19), lien: '');
    await banc.lancer(tester, grand: true);

    // Accueil : prochain rendez-vous.
    expect(find.text('Prochain rendez-vous'), findsOneWidget);
    expect(find.textContaining('lundi 14 janvier · 19:00'), findsOneWidget);

    await tester.tap(find.text('Séances').last);
    await tester.pumpAndSettle();
    expect(find.text('3 séances restantes'), findsOneWidget);
    expect(find.text('Historique'), findsOneWidget);
    expect(find.textContaining('Fait'), findsOneWidget);
    expect(find.textContaining('Annulé'), findsOneWidget);
    expect(
      find.text('Le lien Zoom sera ajouté par votre coach.'),
      findsOneWidget,
    );
    expect(find.textContaining('Rappel automatique'), findsOneWidget);

    await toucher(tester, find.text('Rejoindre sur Zoom'));
    expect(banc.lanceur.ouverts, [Uri.parse('https://zoom.us/j/123')]);
  });

  testWidgets('le coach planifie, marque une séance faite, annule', (
    tester,
  ) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Coach', coach: true)
      ..maintenant = maintenant;
    await accompagnement(banc);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach').last);
    await tester.pumpAndSettle();
    await toucher(tester, find.text('En cours'));
    await toucher(tester, find.text('Paul & Marie'));
    await toucher(tester, find.text('Planifier un rendez-vous'));

    // Lien invalide refusé.
    await tester.enterText(find.byType(TextFormField), 'zoom.us/j/9');
    await toucher(tester, find.text('Enregistrer'));
    expect(find.textContaining('Lien invalide'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'https://zoom.us/j/9');
    await toucher(tester, find.text('45 min'));
    await toucher(tester, find.text('Enregistrer'));
    final docs =
        (await banc.firestore.collection('accompagnements/a1/rendezVous').get())
            .docs;
    expect(docs, hasLength(1));
    final r = RendezVous.depuisFirestore(docs.single);
    expect(r.debut, DateTime(2030, 1, 11, 19)); // demain 19:00 par défaut
    expect(r.dureeMin, 45);
    expect(r.lienZoom, 'https://zoom.us/j/9');
    expect(r.accompagnementId, 'a1');

    // Retour sur la fiche : le rendez-vous est listé.
    expect(find.textContaining('vendredi 11 janvier · 19:00'), findsOneWidget);

    // Séance faite : une séance décomptée.
    await toucher(tester, find.byType(PopupMenuButton<String>));
    await toucher(tester, find.text('Séance faite (−1 séance)'));
    expect(
      (await banc.firestore.doc('accompagnements/a1').get())
          .data()!['seancesRestantes'],
      2,
    );

    // Un autre, puis annulation avec confirmation.
    await rdv(banc, 'r2', DateTime(2030, 1, 15, 19));
    await tester.pumpAndSettle();
    await toucher(tester, find.byType(PopupMenuButton<String>).first);
    await toucher(tester, find.text('Annuler le rendez-vous'));
    await toucher(tester, find.text('Annuler le rendez-vous').last);
    expect(
      (await banc.firestore.doc('accompagnements/a1/rendezVous/r2').get())
          .data()!['statut'],
      'annule',
    );
  });

  testWidgets('modifier sans changer la date garde les rappels', (
    tester,
  ) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Coach', coach: true)
      ..maintenant = maintenant;
    await accompagnement(banc);
    await rdv(banc, 'r1', DateTime(2030, 1, 10, 19));
    await banc.firestore.doc('accompagnements/a1/rendezVous/r1').update({
      'rappelVeille': true,
    });
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach').last);
    await tester.pumpAndSettle();
    await toucher(tester, find.byTooltip('Agenda'));
    expect(find.text('Paul & Marie'), findsOneWidget);
    await toucher(tester, find.byType(PopupMenuButton<String>));
    await toucher(tester, find.text('Modifier le rendez-vous'));
    await tester.enterText(
      find.byType(TextFormField),
      'https://zoom.us/j/nouveau',
    );
    await toucher(tester, find.text('Enregistrer'));
    final d =
        (await banc.firestore.doc('accompagnements/a1/rendezVous/r1').get())
            .data()!;
    expect(d['lienZoom'], 'https://zoom.us/j/nouveau');
    expect(d['rappelVeille'], isTrue);
  });
}
