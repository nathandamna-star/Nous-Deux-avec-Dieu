import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/contenu.dart';

class ContenusRepository {
  ContenusRepository(this.db);

  final FirebaseFirestore db;

  CollectionReference<Map<String, dynamic>> get _contenus =>
      db.collection('contenus');

  List<Contenu> _trier(QuerySnapshot<Map<String, dynamic>> s) =>
      s.docs.map(Contenu.depuisFirestore).toList()..sort(
        (a, b) => (b.createdAt ?? DateTime(9999)).compareTo(
          a.createdAt ?? DateTime(9999),
        ),
      );

  /// Contenus publiés. Sans compte, seulement les contenus publics (les règles
  /// refusent le reste).
  Stream<List<Contenu>> publies({required bool connecte}) {
    Query<Map<String, dynamic>> q = _contenus.where('publie', isEqualTo: true);
    if (!connecte) q = q.where('visibilite', isEqualTo: Visibilite.public.name);
    return q.snapshots().map(_trier);
  }

  /// Tous les contenus, brouillons compris (coach).
  Stream<List<Contenu>> tous() => _contenus.snapshots().map(_trier);

  Stream<Contenu?> un(String id) => _contenus
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? Contenu.depuisFirestore(d) : null);

  /// Identifiant réservé pour un nouveau contenu (les fichiers audio ou vidéo
  /// sont envoyés avant le premier enregistrement).
  String nouvelId() => _contenus.doc().id;

  Future<String> enregistrer(Contenu c, {bool nouveau = false}) async {
    if (nouveau) {
      await _contenus.doc(c.id).set({
        ...c.versFirestore(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return c.id;
    }
    await _contenus.doc(c.id).set({
      ...c.versFirestore(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    return c.id;
  }

  Future<void> supprimer(String id) => _contenus.doc(id).delete();
}
