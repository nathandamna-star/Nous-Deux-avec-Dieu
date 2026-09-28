import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/shared/widgets/avatar.dart';

import 'helpers.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  test('initiales', () {
    expect(Avatar.initiales('Marie Mbala'), 'MM');
    expect(Avatar.initiales(' paul '), 'P');
    expect(Avatar.initiales(''), '');
  });

  testWidgets('ajouter puis supprimer sa photo de profil', (tester) async {
    final banc = await bancAvecProfil();
    await banc.lancer(tester);
    await ouvrirProfil(tester);

    await toucher(tester, find.byIcon(Icons.photo_camera));
    expect(find.text('Supprimer la photo'), findsNothing);
    await toucher(tester, find.text('Choisir dans la galerie'));
    expect(banc.photo.appels, ['galerie']);
    expect(
      (await banc.firestore.doc('users/u1').get()).data()!['photoUrl'],
      'https://stockage.test/users/u1/profil.jpg',
    );

    await toucher(tester, find.byIcon(Icons.photo_camera));
    await toucher(tester, find.text('Supprimer la photo'));
    expect(banc.photo.appels, ['galerie', 'supprimer']);
    expect(
      (await banc.firestore.doc('users/u1').get()).data()!['photoUrl'],
      isNull,
    );
  });

  testWidgets('le coach voit la photo des membres', (tester) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await banc.firestore.doc('users/marie').set({
      'nom': 'Marie',
      'photoUrl': 'https://stockage.test/marie.jpg',
    });
    await banc.firestore.doc('accompagnements/a1').set({
      'type': 'individuel',
      'nom': 'Marie',
      'membres': ['marie'],
      'noms': {'marie': 'Marie'},
      'statut': 'demande',
      'createdAt': Timestamp.now(),
    });
    await banc.lancer(tester);
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Marie'));
    final avatar = tester.widget<Avatar>(find.byType(Avatar));
    expect(avatar.photoUrl, 'https://stockage.test/marie.jpg');
  });
}
