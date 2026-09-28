import 'package:cloud_firestore/cloud_firestore.dart';

import '../../contenus/domain/contenu.dart';
import '../domain/parcours.dart';

class ParcoursRepository {
  ParcoursRepository(this.db);

  final FirebaseFirestore db;

  CollectionReference<Map<String, dynamic>> get _parcours =>
      db.collection('parcours');

  List<Parcours> _trier(QuerySnapshot<Map<String, dynamic>> s) =>
      s.docs.map(Parcours.depuisFirestore).toList()
        ..sort((a, b) => a.ordre.compareTo(b.ordre));

  Stream<List<Parcours>> publies({required bool connecte}) {
    Query<Map<String, dynamic>> q = _parcours.where('publie', isEqualTo: true);
    if (!connecte) q = q.where('visibilite', isEqualTo: Visibilite.public.name);
    return q.snapshots().map(_trier);
  }

  Stream<List<Parcours>> tous() => _parcours.snapshots().map(_trier);

  Stream<Parcours?> un(String id) => _parcours
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? Parcours.depuisFirestore(d) : null);

  Future<void> enregistrer(Parcours p) async {
    if (p.id.isEmpty) {
      await _parcours.add({
        ...p.versFirestore(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await _parcours.doc(p.id).set({
        ...p.versFirestore(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }

  Future<void> supprimer(String id) => _parcours.doc(id).delete();

  // ----- Progression -----

  DocumentReference<Map<String, dynamic>> _progression(String uid, String id) =>
      db.doc('users/$uid/progression/$id');

  Stream<Progression> progression(String uid, String id) =>
      _progression(uid, id).snapshots().map(
        (d) => Progression({
          ...List<String>.from(d.data()?['faits'] as List? ?? const []),
        }),
      );

  Future<void> marquer(
    String uid,
    String parcoursId,
    String contenuId,
    bool fait,
  ) => _progression(uid, parcoursId).set({
    'faits': fait
        ? FieldValue.arrayUnion([contenuId])
        : FieldValue.arrayRemove([contenuId]),
    'updatedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}
