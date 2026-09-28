import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/features/contenus/domain/contenu.dart';

import 'helpers.dart';

Map<String, dynamic> contenu(
  String titre, {
  String type = 'meditation',
  bool publie = true,
  String visibilite = 'public',
  int ordre = 0,
  Map<String, String> autres = const {},
}) => {
  'type': type,
  'theme': 'priere',
  'titre': {'fr': titre, ...autres},
  'texte': {'fr': 'Texte de $titre'},
  'reference': 'Matthieu 18:20',
  'visibilite': visibilite,
  'publie': publie,
  'ordre': ordre,
  'createdAt': Timestamp.fromDate(DateTime(2026, 9, ordre + 1)),
};

Contenu med(String id, int ordre) => Contenu(
  id: id,
  type: TypeContenu.meditation,
  theme: ThemeContenu.priere,
  titres: {'fr': id},
  textes: const {},
  ordre: ordre,
);

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  test('traduction : langue demandée, sinon français, sinon autre', () {
    expect(Contenu.traduire({'fr': 'Bonjour', 'nl': 'Hallo'}, 'nl'), 'Hallo');
    expect(Contenu.traduire({'fr': 'Bonjour', 'nl': ' '}, 'nl'), 'Bonjour');
    expect(Contenu.traduire({'es': 'Hola'}, 'en'), 'Hola');
  });

  test('méditation du jour : une par jour, dans l\'ordre, en boucle', () {
    final liste = [med('b', 2), med('a', 1), med('c', 3)];
    final j0 = meditationDuJour(liste, DateTime(2026, 1, 1))!;
    final j1 = meditationDuJour(liste, DateTime(2026, 1, 2))!;
    final j3 = meditationDuJour(liste, DateTime(2026, 1, 4))!;
    expect([j0.id, j1.id, j3.id], ['a', 'b', 'a']);
    expect(meditationDuJour(const [], DateTime(2026)), isNull);
  });

  testWidgets('bibliothèque sans compte : publics seulement, filtre, lecture', (
    tester,
  ) async {
    final banc = Banc();
    final db = banc.firestore;
    await db.doc('contenus/m1').set(contenu('Prier à deux', ordre: 1));
    await db
        .doc('contenus/q1')
        .set(contenu('Qu\'est-ce qui te rend heureux ?', type: 'question'));
    await db
        .doc('contenus/prive')
        .set(contenu('Pour les membres', visibilite: 'connectes'));
    await db.doc('contenus/brouillon').set(contenu('Brouillon', publie: false));
    await banc.lancer(tester);

    // Accueil : méditation du jour.
    expect(find.text('Méditation du jour'), findsOneWidget);
    expect(find.text('Prier à deux'), findsOneWidget);

    await tester.tap(find.text('Contenus'));
    await tester.pumpAndSettle();
    expect(find.text('Prier à deux'), findsOneWidget);
    expect(find.text('Qu\'est-ce qui te rend heureux ?'), findsOneWidget);
    expect(find.text('Pour les membres'), findsNothing);
    expect(find.text('Brouillon'), findsNothing);

    await toucher(tester, find.widgetWithText(ChoiceChip, 'Question à deux'));
    expect(find.text('Prier à deux'), findsNothing);
    await toucher(tester, find.text('Qu\'est-ce qui te rend heureux ?'));
    expect(
      find.text('Texte de Qu\'est-ce qui te rend heureux ?'),
      findsOneWidget,
    );
    expect(find.text('Matthieu 18:20'), findsOneWidget);
  });

  testWidgets('connecté : contenus réservés visibles ; langue de secours', (
    tester,
  ) async {
    final banc = await bancAvecProfil();
    await banc.firestore
        .doc('contenus/prive')
        .set(
          contenu(
            'Pour les membres',
            visibilite: 'connectes',
            autres: {'nl': 'Voor leden'},
          ),
        );
    await banc.lancer(tester, locale: const Locale('nl'));
    await tester.tap(find.text('Inhoud'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Voor leden'));
    // Texte seulement en français : affiché avec la mention.
    expect(find.text('Texte de Pour les membres'), findsOneWidget);
  });

  testWidgets('le coach écrit un contenu en deux langues et le publie', (
    tester,
  ) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Nathan', coach: true);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach'));
    await tester.pumpAndSettle();
    await toucher(tester, find.text('Mes contenus'));
    await toucher(tester, find.text('Nouveau contenu'));

    // Titre français obligatoire.
    await toucher(tester, find.text('Enregistrer'));
    expect(find.text('Le titre en français est obligatoire.'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Titre (FR)'),
      'Le pardon au quotidien',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Texte (FR)'),
      'Pardonner, c\'est choisir.',
    );
    await toucher(tester, find.text('ES'));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Titre (ES)'),
      'El perdón cada día',
    );
    await toucher(tester, find.text('Publier'));
    await toucher(tester, find.text('Enregistrer'));

    final docs = (await banc.firestore.collection('contenus').get()).docs;
    final d = docs.single.data();
    expect(d['titre'], {
      'fr': 'Le pardon au quotidien',
      'es': 'El perdón cada día',
    });
    expect(d['texte'], {'fr': 'Pardonner, c\'est choisir.'});
    expect(d['publie'], isTrue);
    expect(d['visibilite'], 'public');
    expect(find.text('Le pardon au quotidien'), findsOneWidget);
    expect(find.text('Publié'), findsOneWidget);

    // Suppression.
    await toucher(tester, find.text('Le pardon au quotidien'));
    await toucher(tester, find.byTooltip('Supprimer'));
    await toucher(tester, find.widgetWithText(FilledButton, 'Supprimer'));
    expect((await banc.firestore.collection('contenus').get()).docs, isEmpty);
  });
}
