import 'package:cloud_firestore/cloud_firestore.dart';

import '../../contenus/domain/contenu.dart';

/// Un parcours : une suite de contenus à suivre dans l'ordre
/// (ex. « 30 jours pour mieux communiquer »). Document `parcours/{id}`.
class Parcours {
  const Parcours({
    required this.id,
    required this.titres,
    required this.descriptions,
    required this.etapes,
    this.visibilite = Visibilite.public,
    this.publie = false,
    this.ordre = 0,
    this.createdAt,
  });

  final String id;
  final Map<String, String> titres;
  final Map<String, String> descriptions;

  /// Identifiants des contenus, dans l'ordre.
  final List<String> etapes;
  final Visibilite visibilite;
  final bool publie;
  final int ordre;
  final DateTime? createdAt;

  String titre(String langue) => Contenu.traduire(titres, langue);
  String description(String langue) => Contenu.traduire(descriptions, langue);

  static Map<String, String> _carte(Object? v) => {
    for (final e in (v as Map? ?? const {}).entries)
      e.key as String: e.value as String? ?? '',
  };

  factory Parcours.depuisFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const {};
    return Parcours(
      id: doc.id,
      titres: _carte(d['titre']),
      descriptions: _carte(d['description']),
      etapes: List<String>.from(d['etapes'] as List? ?? const []),
      visibilite: d['visibilite'] == 'connectes'
          ? Visibilite.connectes
          : Visibilite.public,
      publie: d['publie'] as bool? ?? false,
      ordre: (d['ordre'] as num? ?? 0).toInt(),
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> versFirestore() {
    Map<String, String> propre(Map<String, String> m) => {
      for (final e in m.entries)
        if (e.value.trim().isNotEmpty) e.key: e.value.trim(),
    };
    return {
      'titre': propre(titres),
      'description': propre(descriptions),
      'etapes': etapes,
      'visibilite': visibilite.name,
      'publie': publie,
      'ordre': ordre,
    };
  }
}

/// Progression d'un utilisateur : étapes terminées.
/// Document `users/{uid}/progression/{parcoursId}`.
class Progression {
  const Progression(this.faits);

  final Set<String> faits;

  /// Étapes faites parmi celles qui existent encore dans le parcours.
  int nbFaits(Parcours p) => p.etapes.where(faits.contains).length;

  /// Première étape pas encore faite (null si tout est fait).
  String? prochaine(Parcours p) =>
      p.etapes.where((e) => !faits.contains(e)).firstOrNull;
}
