import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/features/contenus/presentation/lecteurs/lecteurs.dart';
import 'package:nous_deux_avec_dieu/features/contenus/presentation/lecteurs/position.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  test('reprise : position gardée, remise à zéro à la fin', () async {
    SharedPreferences.setMockInitialValues({});
    final p = PositionLecture(await SharedPreferences.getInstance());
    const duree = Duration(minutes: 10);
    await p.ecrire('a:fr', const Duration(minutes: 3), duree);
    expect(p.lire('a:fr'), const Duration(minutes: 3));
    await p.ecrire('a:fr', const Duration(minutes: 9, seconds: 58), duree);
    expect(p.lire('a:fr'), Duration.zero);
  });

  test('durée affichée', () {
    expect(formatDuree(const Duration(minutes: 4, seconds: 5)), '04:05');
    expect(formatDuree(const Duration(hours: 1, minutes: 2)), '1:02:00');
  });

  testWidgets('le coach publie un audio en deux langues', (tester) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Mes contenus'));
    await toucher(tester, find.text('Nouveau contenu'));

    await toucher(tester, find.text('Méditation').first);
    await toucher(tester, find.text('Audio').last);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Titre (FR)'),
      'Courage pour aujourd\'hui',
    );

    // Un fichier est obligatoire pour un audio.
    await toucher(tester, find.text('Enregistrer'));
    expect(find.text('Ajoutez au moins un fichier.'), findsOneWidget);

    await toucher(tester, find.text('Choisir le fichier'));
    expect(find.text('Fichier ajouté'), findsOneWidget);
    await toucher(tester, find.text('EN'));
    expect(find.text('Aucun fichier dans cette langue.'), findsOneWidget);
    await toucher(tester, find.text('Choisir le fichier'));
    await toucher(tester, find.text('Publier'));
    await toucher(tester, find.text('Enregistrer'));

    final d = (await banc.firestore.collection('contenus').get()).docs.single;
    expect(d.data()['type'], 'audio');
    expect(d.data()['medias'], {
      'fr': 'https://stockage.test/${d.id}/fr.audio',
      'en': 'https://stockage.test/${d.id}/en.audio',
    });
    expect(banc.medias.envois, hasLength(2));
  });

  testWidgets('lecture : le fichier de la langue, sinon le français', (
    tester,
  ) async {
    final banc = Banc();
    await banc.firestore.doc('contenus/v1').set({
      'type': 'video',
      'theme': 'communication',
      'titre': {'fr': 'Écouter son conjoint'},
      'texte': {'fr': 'Une vidéo de 5 minutes.'},
      'medias': {'fr': 'https://x/fr.mp4', 'es': 'https://x/es.mp4'},
      'visibilite': 'public',
      'publie': true,
      'ordre': 0,
      'createdAt': Timestamp.now(),
    });
    await banc.lancer(tester, locale: const Locale('es'));
    await tester.tap(find.text('Contenidos'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Écouter son conjoint'));
    expect(find.text('lecteur vidéo : https://x/es.mp4'), findsOneWidget);
  });

  testWidgets('lecture audio en néerlandais : fichier français', (
    tester,
  ) async {
    final banc = Banc();
    await banc.firestore.doc('contenus/a1').set({
      'type': 'audio',
      'theme': 'priere',
      'titre': {'fr': 'Prière du soir'},
      'medias': {'fr': 'https://x/fr.m4a'},
      'visibilite': 'public',
      'publie': true,
      'ordre': 0,
      'createdAt': Timestamp.now(),
    });
    await banc.lancer(tester, locale: const Locale('nl'));
    await tester.tap(find.text('Inhoud'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Prière du soir'));
    expect(find.text('lecteur audio : https://x/fr.m4a'), findsOneWidget);
  });
}
