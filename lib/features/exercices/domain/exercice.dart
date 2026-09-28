import 'package:cloud_firestore/cloud_firestore.dart';

/// Chacun répond de son côté, ou une réponse commune écrite à deux.
enum ModeExercice { seul, aDeux }

/// Un exercice envoyé par le coach à un accompagnement.
/// Document `accompagnements/{id}/exercices/{exerciceId}` ; les réponses sont
/// dans la sous-collection `reponses/{uid}` (ou `reponses/couple`).
class Exercice {
  const Exercice({
    required this.id,
    required this.titre,
    required this.consignes,
    required this.mode,
    this.contenuId,
    this.echeance,
    this.repondu = const [],
    this.fait = false,
    this.createdAt,
  });

  final String id;
  final String titre;
  final String consignes;
  final ModeExercice mode;

  /// Contenu de la bibliothèque à lire avant de répondre (facultatif).
  final String? contenuId;
  final DateTime? echeance;

  /// Membres qui ont déjà répondu.
  final List<String> repondu;
  final bool fait;
  final DateTime? createdAt;

  /// Clé du document de réponse de [uid] (commun pour un exercice à deux).
  String cleReponse(String uid) => mode == ModeExercice.aDeux ? 'couple' : uid;

  /// Fait quand la réponse commune existe, ou quand chaque membre a répondu.
  static bool estFait(
    ModeExercice mode,
    List<String> repondu,
    List<String> membres,
  ) => mode == ModeExercice.aDeux
      ? repondu.isNotEmpty
      : membres.every(repondu.contains);

  factory Exercice.depuisFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const {};
    return Exercice(
      id: doc.id,
      titre: d['titre'] as String? ?? '',
      consignes: d['consignes'] as String? ?? '',
      mode: d['mode'] == 'a_deux' ? ModeExercice.aDeux : ModeExercice.seul,
      contenuId: d['contenuId'] as String?,
      echeance: (d['echeance'] as Timestamp?)?.toDate(),
      repondu: List<String>.from(d['repondu'] as List? ?? const []),
      fait: d['statut'] == 'fait',
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}

class Reponse {
  const Reponse({required this.texte, this.auteur, this.le});

  final String texte;
  final String? auteur;
  final DateTime? le;

  factory Reponse.depuisFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Reponse(
        texte: doc.data()?['texte'] as String? ?? '',
        auteur: doc.data()?['auteur'] as String?,
        le: (doc.data()?['updatedAt'] as Timestamp?)?.toDate(),
      );
}
