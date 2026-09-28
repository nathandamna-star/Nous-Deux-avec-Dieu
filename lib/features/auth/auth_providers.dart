import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/auth_repository.dart';
import 'domain/parcours.dart';
import 'domain/utilisateur.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  ),
);

/// Utilisateur connecté (null sinon). Suit aussi le rafraîchissement du jeton,
/// pour voir le custom claim « coach » dès qu'il est attribué.
final utilisateurFirebaseProvider = StreamProvider<User?>((ref) async* {
  final auth = ref.watch(firebaseAuthProvider);
  yield auth.currentUser;
  yield* auth.idTokenChanges();
});

final estConnecteProvider = Provider<bool>(
  (ref) => ref.watch(utilisateurFirebaseProvider).value != null,
);

/// Vrai pour le compte du coach (custom claim `coach: true`, attribué par une
/// Cloud Function, jamais par l'app).
final estCoachFutureProvider = FutureProvider<bool>((ref) async {
  final user = ref.watch(utilisateurFirebaseProvider).value;
  if (user == null) return false;
  final jeton = await user.getIdTokenResult();
  return jeton.claims?['coach'] == true;
});

final estCoachProvider = Provider<bool>(
  (ref) => ref.watch(estCoachFutureProvider).value ?? false,
);

/// Profil Firestore de l'utilisateur connecté.
final profilProvider = StreamProvider<Utilisateur?>((ref) {
  final user = ref.watch(utilisateurFirebaseProvider).value;
  if (user == null) return Stream.value(null);
  return ref
      .watch(firestoreProvider)
      .collection('users')
      .doc(user.uid)
      .snapshots()
      .map((doc) => doc.exists ? Utilisateur.depuisFirestore(doc) : null);
});

/// Choix fait sur l'écran de bienvenue avant l'inscription.
final parcoursSouhaiteProvider = NotifierProvider<ParcoursSouhaite, Parcours>(
  ParcoursSouhaite.new,
);

class ParcoursSouhaite extends Notifier<Parcours> {
  @override
  Parcours build() => Parcours.couple;

  void choisir(Parcours p) => state = p;
}
