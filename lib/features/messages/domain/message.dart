import 'package:cloud_firestore/cloud_firestore.dart';

/// Un message entre le coach et un accompagnement.
/// Document `accompagnements/{id}/messages/{messageId}`.
class Message {
  const Message({
    required this.id,
    required this.auteur,
    this.texte = '',
    this.photoUrl,
    this.audioUrl,
    this.createdAt,
  });

  final String id;
  final String auteur;
  final String texte;
  final String? photoUrl;

  /// Message vocal.
  final String? audioUrl;
  final DateTime? createdAt;

  factory Message.depuisFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const {};
    return Message(
      id: doc.id,
      auteur: d['auteur'] as String? ?? '',
      texte: d['texte'] as String? ?? '',
      photoUrl: d['photoUrl'] as String?,
      audioUrl: d['audioUrl'] as String?,
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}

/// Aperçu affiché dans la liste des conversations.
String apercuMessage({
  required String texte,
  bool photo = false,
  bool vocal = false,
}) {
  final t = texte.trim().replaceAll(RegExp(r'\s+'), ' ');
  if (t.isNotEmpty) return t.length > 80 ? '${t.substring(0, 80)}…' : t;
  if (vocal) return '🎤';
  return photo ? '📷' : '';
}
