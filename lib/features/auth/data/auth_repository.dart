import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/erreur_auth.dart';
import '../domain/parcours.dart';

/// Connexion, inscription et création du profil `users/{uid}`.
class AuthRepository {
  AuthRepository({required this.auth, required this.firestore});

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<void> connexionEmail({
    required String email,
    required String motDePasse,
  }) => _executer(() async {
    await auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: motDePasse,
    );
  });

  /// Crée le compte et le profil. [consentement] doit avoir été donné
  /// explicitement (case cochée) : il est daté dans le profil.
  Future<void> inscriptionEmail({
    required String nom,
    required String email,
    required String motDePasse,
    required Parcours parcours,
    required String langue,
  }) => _executer(() async {
    final cred = await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: motDePasse,
    );
    await cred.user!.updateDisplayName(nom.trim());
    await firestore.collection('users').doc(cred.user!.uid).set({
      'nom': nom.trim(),
      'email': email.trim(),
      'langue': langue,
      'parcours': parcours.name,
      'consentementLe': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  });

  /// Nouvelle photo de profil (null : supprimée).
  Future<void> definirPhoto(String? url) async {
    final user = auth.currentUser;
    if (user == null) return;
    await firestore.collection('users').doc(user.uid).update({'photoUrl': url});
    await user.updatePhotoURL(url);
  }

  Future<void> motDePasseOublie(String email) =>
      _executer(() => auth.sendPasswordResetEmail(email: email.trim()));

  /// Recharge le jeton pour voir un rôle attribué par le serveur (coach).
  Future<void> rafraichirJeton() async {
    await auth.currentUser?.getIdToken(true);
  }

  Future<void> deconnexion() => auth.signOut();

  Future<void> _executer(Future<void> Function() action) async {
    try {
      await action();
    } on FirebaseAuthException catch (e) {
      throw ExceptionAuth(ErreurAuth.depuisCode(e.code));
    } on FirebaseException catch (e) {
      throw ExceptionAuth(
        e.code == 'unavailable' ? ErreurAuth.reseau : ErreurAuth.inconnue,
      );
    }
  }
}
