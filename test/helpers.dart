import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nous_deux_avec_dieu/app.dart';
import 'package:nous_deux_avec_dieu/core/preferences/preferences.dart';
import 'package:nous_deux_avec_dieu/features/accompagnement/accompagnement_providers.dart';
import 'package:nous_deux_avec_dieu/features/accompagnement/data/fonctions_coach.dart';
import 'package:nous_deux_avec_dieu/features/auth/auth_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Banc d'essai : Firebase simulé, préférences en mémoire.
class Banc {
  Banc({MockFirebaseAuth? auth}) : auth = auth ?? MockFirebaseAuth();

  final MockFirebaseAuth auth;
  final firestore = FakeFirebaseFirestore();
  final fonctions = FaussesFonctionsCoach();

  Future<void> lancer(
    WidgetTester tester, {
    bool bienvenueVue = true,
    Locale locale = const Locale('fr'),
    bool grand = false,
  }) async {
    tester.view.physicalSize = Size(1080, grand ? 6000 : 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    tester.platformDispatcher.localesTestValue = [locale];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    SharedPreferences.setMockInitialValues({'bienvenueVue': bienvenueVue});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          firebaseAuthProvider.overrideWithValue(auth),
          firestoreProvider.overrideWithValue(firestore),
          fonctionsCoachProvider.overrideWithValue(fonctions),
        ],
        child: const NousDeuxAvecDieuApp(),
      ),
    );
    await tester.pumpAndSettle();
  }
}

/// Utilisateur déjà connecté ; `coach: true` ajoute le custom claim.
Banc bancConnecte({bool coach = false}) => Banc(
  auth: MockFirebaseAuth(
    signedIn: true,
    mockUser: MockUser(
      uid: 'u1',
      email: 'marie@exemple.com',
      displayName: 'Marie',
      customClaim: coach ? {'coach': true} : {},
    ),
  ),
);

Future<void> toucher(WidgetTester tester, Finder cible) async {
  await tester.ensureVisible(cible);
  await tester.pumpAndSettle();
  await tester.tap(cible);
  await tester.pumpAndSettle();
}

class FaussesFonctionsCoach implements FonctionsCoach {
  var appels = 0;
  var refuser = false;

  @override
  Future<void> revendiquerCoach() async {
    appels++;
    if (refuser) throw Exception('refusé');
  }
}

/// Utilisateur connecté avec son profil déjà créé.
Future<Banc> bancAvecProfil({
  String uid = 'u1',
  String nom = 'Marie',
  String parcours = 'couple',
  bool coach = false,
}) async {
  final banc = Banc(
    auth: MockFirebaseAuth(
      signedIn: true,
      mockUser: MockUser(
        uid: uid,
        email: '$uid@exemple.com',
        displayName: nom,
        customClaim: coach ? {'coach': true} : {},
      ),
    ),
  );
  await banc.firestore.doc('users/$uid').set({
    'nom': nom,
    'email': '$uid@exemple.com',
    'langue': 'fr',
    'parcours': parcours,
  });
  return banc;
}

Future<void> ouvrirProfil(WidgetTester tester) async {
  await tester.tap(find.text('Profil'));
  await tester.pumpAndSettle();
}
