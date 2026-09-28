import 'package:cloud_firestore/cloud_firestore.dart';

enum TypeAccompagnement { couple, individuel }

enum StatutAccompagnement {
  demande,
  actif,
  enPause('en_pause'),
  termine;

  const StatutAccompagnement([this._valeur]);
  final String? _valeur;
  String get valeur => _valeur ?? name;

  static StatutAccompagnement depuis(String? v) => values.firstWhere(
    (s) => s.valeur == v,
    orElse: () => StatutAccompagnement.demande,
  );
}

/// Un accompagnement : un couple (deux membres, reliés par un code
/// d'invitation) ou une personne seule. Document `accompagnements/{id}`.
class Accompagnement {
  const Accompagnement({
    required this.id,
    required this.type,
    required this.nom,
    required this.membres,
    required this.noms,
    required this.statut,
    this.codeInvitation,
    this.message = '',
    this.seancesRestantes = 0,
    this.dernierMessage = '',
    this.dernierMessageLe,
    this.nonLusCoach = 0,
    this.nonLus = const {},
    this.createdAt,
  });

  final String id;
  final TypeAccompagnement type;

  /// Nom affiché, ex. « Paul & Marie ».
  final String nom;
  final List<String> membres;

  /// Prénom et nom de chaque membre (uid → nom), pour l'affichage.
  final Map<String, String> noms;
  final StatutAccompagnement statut;
  final String? codeInvitation;

  /// Ce que la personne a écrit en faisant sa demande.
  final String message;
  final int seancesRestantes;

  /// Messagerie : aperçu du dernier message et non-lus (coach, et par membre).
  final String dernierMessage;
  final DateTime? dernierMessageLe;
  final int nonLusCoach;
  final Map<String, int> nonLus;
  final DateTime? createdAt;

  /// Couple dont le conjoint n'a pas encore rejoint l'accompagnement.
  bool get attendConjoint =>
      type == TypeAccompagnement.couple && membres.length < 2;

  factory Accompagnement.depuisFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data() ?? const {};
    return Accompagnement(
      id: doc.id,
      type: d['type'] == 'couple'
          ? TypeAccompagnement.couple
          : TypeAccompagnement.individuel,
      nom: d['nom'] as String? ?? '',
      membres: List<String>.from(d['membres'] as List? ?? const []),
      noms: Map<String, String>.from(d['noms'] as Map? ?? const {}),
      statut: StatutAccompagnement.depuis(d['statut'] as String?),
      codeInvitation: d['codeInvitation'] as String?,
      message: d['message'] as String? ?? '',
      seancesRestantes: (d['seancesRestantes'] as num? ?? 0).toInt(),
      dernierMessage: d['dernierMessage'] as String? ?? '',
      dernierMessageLe: (d['dernierMessageLe'] as Timestamp?)?.toDate(),
      nonLusCoach: (d['nonLusCoach'] as num? ?? 0).toInt(),
      nonLus: {
        for (final e in (d['nonLus'] as Map? ?? const {}).entries)
          e.key as String: (e.value as num? ?? 0).toInt(),
      },
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}

/// Note privée du coach sur un accompagnement.
class Note {
  const Note({required this.id, required this.texte, this.createdAt});

  final String id;
  final String texte;
  final DateTime? createdAt;

  factory Note.depuisFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      Note(
        id: doc.id,
        texte: doc.data()?['texte'] as String? ?? '',
        createdAt: (doc.data()?['createdAt'] as Timestamp?)?.toDate(),
      );
}
