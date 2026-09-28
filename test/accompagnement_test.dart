import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/features/accompagnement/data/accompagnement_repository.dart';

import 'helpers.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('un couple demande un accompagnement et reçoit un code', (
    tester,
  ) async {
    final banc = await bancAvecProfil();
    await banc.lancer(tester);
    await ouvrirProfil(tester);
    await toucher(tester, find.text('Demander un accompagnement'));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nom affiché'),
      'Paul & Marie',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Votre message au coach (facultatif)'),
      'Nous voulons mieux communiquer.',
    );
    await toucher(tester, find.text('Envoyer ma demande'));

    final docs =
        (await banc.firestore.collection('accompagnements').get()).docs;
    final d = docs.single.data();
    expect(d['type'], 'couple');
    expect(d['membres'], ['u1']);
    expect(d['statut'], 'demande');
    expect(d['noms'], {'u1': 'Marie'});
    final code = d['codeInvitation'] as String;
    expect(code, hasLength(6));
    expect(
      (await banc.firestore.doc('invitations/$code').get())
          .data()!['accompagnementId'],
      docs.single.id,
    );

    // Le profil affiche l'accompagnement et le code pour le conjoint.
    expect(find.text('Paul & Marie'), findsOneWidget);
    expect(find.text('Demande en attente'), findsOneWidget);
    expect(find.text('Code pour votre conjoint : $code'), findsOneWidget);
  });

  testWidgets('personne seule : demande individuelle, sans code', (
    tester,
  ) async {
    final banc = await bancAvecProfil(parcours: 'seul');
    await banc.lancer(tester);
    await ouvrirProfil(tester);
    await toucher(tester, find.text('Demander un accompagnement'));
    await toucher(tester, find.text('Envoyer ma demande'));
    final d = (await banc.firestore.collection('accompagnements').get())
        .docs
        .single
        .data();
    expect(d['type'], 'individuel');
    expect(d['nom'], 'Marie');
    expect(d.containsKey('codeInvitation'), isFalse);
    expect(find.textContaining('Code pour votre conjoint'), findsNothing);
  });

  testWidgets('le conjoint rejoint avec le code', (tester) async {
    final banc = await bancAvecProfil(uid: 'paul', nom: 'Paul');
    await banc.firestore.doc('accompagnements/a1').set({
      'type': 'couple',
      'nom': 'Paul & Marie',
      'membres': ['marie'],
      'noms': {'marie': 'Marie'},
      'codeInvitation': 'ABC234',
      'statut': 'actif',
      'seancesRestantes': 3,
      'createdAt': Timestamp.now(),
    });
    await banc.firestore.doc('invitations/ABC234').set({
      'accompagnementId': 'a1',
    });
    await banc.lancer(tester);
    await ouvrirProfil(tester);
    await toucher(tester, find.text('J\'ai un code de mon conjoint'));

    await tester.enterText(find.byType(TextField), 'zzz999');
    await toucher(tester, find.text('Rejoindre'));
    expect(
      find.text('Ce code n\'est pas valable, ou le couple est déjà complet.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), 'abc 234');
    await toucher(tester, find.text('Rejoindre'));
    final d = (await banc.firestore.doc('accompagnements/a1').get()).data()!;
    expect(d['membres'], ['marie', 'paul']);
    expect(d['noms'], {'marie': 'Marie', 'paul': 'Paul'});
    expect(find.text('Paul & Marie'), findsOneWidget);
    expect(find.text('3 séances restantes'), findsOneWidget);
    expect(find.textContaining('Code pour votre conjoint'), findsNothing);
  });

  test('code normalisé : majuscules, sans espaces ni tirets', () {
    expect(AccompagnementRepository.normaliserCode(' ab-c 2 34 '), 'ABC234');
  });
}
