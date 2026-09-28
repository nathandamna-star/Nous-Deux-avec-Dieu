import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/exercice.dart';

class ExercicesRepository {
  ExercicesRepository(this.db);

  final FirebaseFirestore db;

  CollectionReference<Map<String, dynamic>> _exercices(String accId) =>
      db.collection('accompagnements/$accId/exercices');

  Stream<List<Exercice>> exercices(String accId) =>
      _exercices(accId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((s) => s.docs.map(Exercice.depuisFirestore).toList());

  Stream<Exercice?> un(String accId, String id) =>
      _exercices(accId)
          .doc(id)
          .snapshots()
          .map((d) => d.exists ? Exercice.depuisFirestore(d) : null);

  /// Réponse lisible par l'utilisateur (ou null s'il n'y en a pas, ou s'il
  /// n'a pas le droit de la lire).
  Stream<Reponse?> reponse(String accId, String id, String cle) =>
      _exercices(accId)
          .doc(id)
          .collection('reponses')
          .doc(cle)
          .snapshots()
          .map((d) => d.exists ? Reponse.depuisFirestore(d) : null);

  // ----- Coach -----

  Future<void> envoyer(
    String accId, {
    required String titre,
    required String consignes,
    required ModeExercice mode,
    String? contenuId,
    DateTime? echeance,
  }) => _exercices(accId).add({
    'titre': titre.trim(),
    'consignes': consignes.trim(),
    'mode': mode == ModeExercice.aDeux ? 'a_deux' : 'seul',
    'contenuId': ?contenuId,
    'echeance': ?(echeance == null ? null : Timestamp.fromDate(echeance)),
    'repondu': <String>[],
    'statut': 'a_faire',
    'createdAt': FieldValue.serverTimestamp(),
  });

  Future<void> supprimer(String accId, String id) =>
      _exercices(accId).doc(id).delete();

  // ----- Membres -----

  /// Enregistre la réponse de [uid] et met à jour l'état de l'exercice.
  Future<void> repondre({
    required String accId,
    required Exercice exercice,
    required String uid,
    required List<String> membres,
    required String texte,
  }) async {
    final ref = _exercices(accId).doc(exercice.id);
    final repondu = {...exercice.repondu, uid}.toList();
    final batch = db.batch()
      ..set(ref.collection('reponses').doc(exercice.cleReponse(uid)), {
        'texte': texte.trim(),
        'auteur': uid,
        'updatedAt': FieldValue.serverTimestamp(),
      })
      ..update(ref, {
        'repondu': FieldValue.arrayUnion([uid]),
        'statut': Exercice.estFait(exercice.mode, repondu, membres)
            ? 'fait'
            : 'a_faire',
      });
    await batch.commit();
  }
}
