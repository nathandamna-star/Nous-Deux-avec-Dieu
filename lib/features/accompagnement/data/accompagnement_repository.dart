import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/accompagnement.dart';

/// Code saisi par le conjoint pour rejoindre un accompagnement.
class ExceptionCode implements Exception {
  const ExceptionCode();
}

class AccompagnementRepository {
  AccompagnementRepository(this.db, {Random? hasard})
    : _hasard = hasard ?? Random.secure();

  final FirebaseFirestore db;
  final Random _hasard;

  CollectionReference<Map<String, dynamic>> get _accompagnements =>
      db.collection('accompagnements');

  // Sans lettres ni chiffres qui se confondent (O/0, I/1).
  static const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  String _nouveauCode() => List.generate(
    6,
    (_) => _alphabet[_hasard.nextInt(_alphabet.length)],
  ).join();

  static String normaliserCode(String saisie) =>
      saisie.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

  /// Accompagnements dont l'utilisateur est membre (en pratique un seul).
  Stream<Accompagnement?> monAccompagnement(String uid) => _accompagnements
      .where('membres', arrayContains: uid)
      .snapshots()
      .map(
        (s) => s.docs.isEmpty
            ? null
            : Accompagnement.depuisFirestore(s.docs.first),
      );

  /// Tous les accompagnements (coach), les plus récents d'abord.
  Stream<List<Accompagnement>> tous() => _accompagnements
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map(Accompagnement.depuisFirestore).toList());

  Stream<Accompagnement?> un(String id) => _accompagnements
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? Accompagnement.depuisFirestore(d) : null);

  /// Demande d'accompagnement. Pour un couple, un code d'invitation est créé
  /// (document `invitations/{code}`) pour que le conjoint puisse rejoindre.
  Future<String> demander({
    required String uid,
    required String nomMembre,
    required TypeAccompagnement type,
    required String nom,
    required String message,
  }) async {
    final ref = _accompagnements.doc();
    final batch = db.batch();
    String? code;
    if (type == TypeAccompagnement.couple) {
      code = _nouveauCode();
      batch.set(db.doc('invitations/$code'), {
        'accompagnementId': ref.id,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    batch.set(ref, {
      'type': type.name,
      'nom': nom.trim(),
      'membres': [uid],
      'noms': {uid: nomMembre},
      'codeInvitation': ?code,
      'statut': StatutAccompagnement.demande.valeur,
      'message': message.trim(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await batch.commit();
    return ref.id;
  }

  /// Le conjoint rejoint l'accompagnement grâce au code reçu.
  Future<void> rejoindre({
    required String uid,
    required String nomMembre,
    required String code,
  }) async {
    final propre = normaliserCode(code);
    if (propre.length != 6) throw const ExceptionCode();
    final DocumentSnapshot<Map<String, dynamic>> invitation;
    try {
      invitation = await db.doc('invitations/$propre').get();
    } on FirebaseException {
      throw const ExceptionCode();
    }
    final id = invitation.data()?['accompagnementId'] as String?;
    if (id == null) throw const ExceptionCode();
    try {
      await _accompagnements.doc(id).update({
        'membres': FieldValue.arrayUnion([uid]),
        'noms.$uid': nomMembre,
        'codeUtilise': propre,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException {
      // Couple déjà complet, ou code d'un autre accompagnement.
      throw const ExceptionCode();
    }
  }

  // ----- Coach -----

  Future<void> changerStatut(String id, StatutAccompagnement statut) =>
      _accompagnements.doc(id).update({
        'statut': statut.valeur,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<void> definirSeances(String id, int nombre) =>
      _accompagnements.doc(id).update({
        'seancesRestantes': max(0, nombre),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Stream<List<Note>> notes(String id) => _accompagnements
      .doc(id)
      .collection('notes')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map(Note.depuisFirestore).toList());

  Future<void> ajouterNote(String id, String texte) =>
      _accompagnements.doc(id).collection('notes').add({
        'texte': texte.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<void> supprimerNote(String id, String noteId) =>
      _accompagnements.doc(id).collection('notes').doc(noteId).delete();
}
