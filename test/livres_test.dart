import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nous_deux_avec_dieu/features/paiements/domain/virement.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'helpers.dart';

Map<String, dynamic> livre({
  String titre = 'Aimer selon Dieu',
  bool publie = true,
}) => {
  'titre': {'fr': titre, 'en': 'Loving God\'s way'},
  'sousTitre': {'fr': 'Un chemin pour le couple'},
  'description': {'fr': 'Un livre pour grandir ensemble.'},
  'couvertureUrl': '',
  'langues': ['fr', 'en'],
  'formats': [
    {'type': 'papier', 'prix': 19.9, 'devise': 'EUR'},
    {'type': 'numerique', 'prix': 9.99, 'devise': 'EUR'},
  ],
  'prixPapier': 19.9,
  'liensAchat': [
    {'libelle': 'Amazon', 'url': 'https://amazon.fr/aimer'},
  ],
  'commandeDirecte': true,
  'fraisEnvoi': 4.5,
  'extraitUrl': 'https://exemple.com/extrait.pdf',
  'publie': publie,
  'ordre': 0,
};

Future<void> livres(Banc banc) async {
  await banc.firestore.doc('livres/l1').set(livre());
  await banc.firestore
      .doc('livres/l2')
      .set(livre(titre: 'Brouillon secret', publie: false));
  await banc.firestore.doc('parametres/coach').set({
    'titulaire': 'Nathan Damna',
    'iban': 'BE71096123456769',
    'bic': '',
    'messageDon': <String, String>{},
  });
}

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  testWidgets('sans compte : catalogue, liens d\'achat, commande = connexion', (
    tester,
  ) async {
    final banc = Banc();
    await livres(banc);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Contenus'));
    await tester.pumpAndSettle();
    await toucher(tester, find.byTooltip('Mes livres'));
    expect(find.text('Aimer selon Dieu'), findsOneWidget);
    expect(find.text('Brouillon secret'), findsNothing);

    await toucher(tester, find.text('Aimer selon Dieu'));
    expect(find.text('Disponible en : FR, EN'), findsOneWidget);
    expect(find.text('Numérique'), findsOneWidget);
    await toucher(tester, find.text('Acheter sur Amazon'));
    await toucher(tester, find.text('Lire un extrait'));
    expect(banc.lanceur.ouverts, [
      Uri.parse('https://amazon.fr/aimer'),
      Uri.parse('https://exemple.com/extrait.pdf'),
    ]);

    await toucher(tester, find.text('Commander au coach'));
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
  });

  testWidgets('commander le livre papier : montant, adresse, virement', (
    tester,
  ) async {
    final banc = await bancAvecProfil();
    await livres(banc);
    await banc.lancer(tester, grand: true);
    await toucher(tester, find.text('Mes livres'));
    await toucher(tester, find.text('Aimer selon Dieu'));
    await toucher(tester, find.text('Commander au coach'));
    await toucher(tester, find.byTooltip('+'));
    expect(find.textContaining('44,30'), findsOneWidget); // 2 × 19,90 + 4,50

    // Adresse incomplète refusée.
    await toucher(tester, find.text('Commander'));
    expect(find.text('Ce champ est obligatoire.'), findsWidgets);
    final champs = find.byType(TextFormField);
    await tester.enterText(champs.at(1), 'Rue de la Paix 1');
    await tester.enterText(champs.at(2), '1000');
    await tester.enterText(champs.at(3), 'Bruxelles');
    await tester.enterText(champs.at(4), 'Belgique');
    await toucher(tester, find.text('Commander'));

    final docs =
        (await banc.firestore.collection('commandesLivres').get()).docs;
    expect(docs, hasLength(1));
    final c = docs.single.data();
    expect(communicationValide(docs.single.id), isTrue);
    expect(c['quantite'], 2);
    expect(c['montant'], 19.9 * 2 + 4.5);
    expect(c['adresse']['nom'], 'Marie');
    expect(c['statut'], 'en_attente');
    expect(find.byType(QrImageView), findsOneWidget);
    expect(find.text(formaterCommunication(docs.single.id)), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Mes commandes'), findsOneWidget);
    expect(find.textContaining('Paiement attendu'), findsOneWidget);
  });

  testWidgets('le coach crée un livre', (tester) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Coach', coach: true);
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach').last);
    await tester.pumpAndSettle();
    await toucher(tester, find.byTooltip('Plus'));
    await toucher(tester, find.text('Mes livres'));
    expect(find.text('Aucun livre pour le moment.'), findsOneWidget);
    await toucher(tester, find.text('Nouveau livre'));

    await toucher(tester, find.text('Choisir une image'));
    expect(banc.couvertures.envois, hasLength(1));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Titre (FR)'),
      'Le pardon',
    );
    await tester.enterText(find.widgetWithText(TextFormField, 'Papier'), '15');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Livre audio'),
      '12,50',
    );
    await toucher(tester, find.text('Commande directe du livre papier'));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Frais d\'envoi'),
      '3,5',
    );
    await toucher(tester, find.text('Ajouter un lien'));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Boutique (ex. Amazon)'),
      'Fnac',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Adresse (https://…)'),
      'fnac.com',
    );
    await toucher(tester, find.text('Enregistrer'));
    expect(find.textContaining('https://'), findsWidgets); // lien refusé
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Adresse (https://…)'),
      'https://fnac.com/pardon',
    );
    await toucher(tester, find.text('Publié'));
    await toucher(tester, find.text('Enregistrer'));

    final l = (await banc.firestore.collection('livres').get()).docs.single
        .data();
    expect(l['titre'], {'fr': 'Le pardon'});
    expect(l['couvertureUrl'], startsWith('https://stockage.test/livres/'));
    expect(l['formats'], [
      {'type': 'papier', 'prix': 15.0, 'devise': 'EUR'},
      {'type': 'audio', 'prix': 12.5, 'devise': 'EUR'},
    ]);
    expect(l['prixPapier'], 15.0);
    expect(l['commandeDirecte'], isTrue);
    expect(l['fraisEnvoi'], 3.5);
    expect(l['liensAchat'], [
      {'libelle': 'Fnac', 'url': 'https://fnac.com/pardon'},
    ]);
    expect(l['publie'], isTrue);
    expect(find.text('Le pardon'), findsOneWidget);
  });

  testWidgets('le coach traite une commande : payée puis envoyée', (
    tester,
  ) async {
    final banc = await bancAvecProfil(uid: 'coach', nom: 'Coach', coach: true);
    await livres(banc);
    await banc.firestore.doc('commandesLivres/100000000034').set({
      'uid': 'u1',
      'nom': 'Marie',
      'livreId': 'l1',
      'livreTitre': 'Aimer selon Dieu',
      'quantite': 1,
      'montant': 24.4,
      'devise': 'EUR',
      'adresse': {
        'nom': 'Marie',
        'rue': 'Rue de la Paix 1',
        'codePostal': '1000',
        'ville': 'Bruxelles',
        'pays': 'Belgique',
      },
      'statut': 'en_attente',
      'createdAt': Timestamp.now(),
    });
    await banc.lancer(tester, grand: true);
    await tester.tap(find.text('Coach').last);
    await tester.pumpAndSettle();
    await toucher(tester, find.byTooltip('Plus'));
    await toucher(tester, find.text('Mes livres'));
    // La vue Commandes s'ouvre directement quand il y en a à traiter.
    expect(find.text('1000 Bruxelles'), findsOneWidget);
    await toucher(tester, find.text('Paiement reçu'));
    await toucher(tester, find.text('Marquer envoyée'));
    await tester.enterText(find.byType(TextField).last, 'BPOST123');
    await toucher(tester, find.text('Valider'));
    final c = (await banc.firestore.doc('commandesLivres/100000000034').get())
        .data()!;
    expect(c['statut'], 'envoyee');
    expect(c['numeroSuivi'], 'BPOST123');
    expect(find.text('Numéro de suivi : BPOST123'), findsOneWidget);
  });
}
