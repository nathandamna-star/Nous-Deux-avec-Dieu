import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/message.dart';

class MessagerieRepository {
  MessagerieRepository(this.db);

  final FirebaseFirestore db;

  DocumentReference<Map<String, dynamic>> _acc(String id) =>
      db.doc('accompagnements/$id');

  Stream<List<Message>> messages(String accId) =>
      _acc(accId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .limit(300)
          .snapshots()
          .map((s) => s.docs.map(Message.depuisFirestore).toList());

  /// Envoie un message et met à jour l'aperçu et les compteurs de non-lus :
  /// ceux du coach si un membre écrit, ceux des membres si le coach écrit.
  Future<void> envoyer({
    required String accId,
    required String uid,
    required bool parCoach,
    required List<String> membres,
    String texte = '',
    String? photoUrl,
    String? audioUrl,
  }) async {
    final batch = db.batch()
      ..set(_acc(accId).collection('messages').doc(), {
        'auteur': uid,
        'texte': texte.trim(),
        'photoUrl': ?photoUrl,
        'audioUrl': ?audioUrl,
        'createdAt': FieldValue.serverTimestamp(),
      })
      ..update(_acc(accId), {
        'dernierMessage': apercuMessage(
          texte: texte,
          photo: photoUrl != null,
          vocal: audioUrl != null,
        ),
        'dernierMessageLe': FieldValue.serverTimestamp(),
        if (parCoach)
          for (final m in membres) 'nonLus.$m': FieldValue.increment(1)
        else
          'nonLusCoach': FieldValue.increment(1),
      });
    await batch.commit();
  }

  /// Remet à zéro les non-lus de [uid] (ou du coach).
  Future<void> marquerLu(String accId, String uid, {required bool coach}) =>
      _acc(accId).update({coach ? 'nonLusCoach' : 'nonLus.$uid': 0});
}
