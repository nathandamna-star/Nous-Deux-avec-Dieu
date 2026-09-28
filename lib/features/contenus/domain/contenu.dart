import 'package:cloud_firestore/cloud_firestore.dart';

enum TypeContenu { meditation, question, exercice, article }

enum ThemeContenu {
  communication,
  pardon,
  finances,
  intimite,
  priere,
  enfants,
  fiancailles,
  gratitude,
}

/// Qui peut voir un contenu publié.
enum Visibilite {
  /// Tout le monde, même sans compte.
  public,

  /// Les personnes connectées seulement.
  connectes,
}

/// Langues de l'app, dans l'ordre de l'éditeur.
const languesContenu = ['fr', 'en', 'pt', 'es', 'nl'];

/// Un contenu écrit par le coach, avec une version par langue.
/// Document `contenus/{id}`.
class Contenu {
  const Contenu({
    required this.id,
    required this.type,
    required this.theme,
    required this.titres,
    required this.textes,
    this.reference = '',
    this.visibilite = Visibilite.public,
    this.publie = false,
    this.ordre = 0,
    this.createdAt,
  });

  final String id;
  final TypeContenu type;
  final ThemeContenu theme;

  /// Langue → titre / texte. Le français sert de secours.
  final Map<String, String> titres;
  final Map<String, String> textes;

  /// Référence biblique, ex. « Éphésiens 4:2 ».
  final String reference;
  final Visibilite visibilite;
  final bool publie;
  final int ordre;
  final DateTime? createdAt;

  /// Texte dans [langue], sinon en français, sinon dans la première langue
  /// disponible.
  static String traduire(Map<String, String> valeurs, String langue) {
    for (final l in [langue, 'fr', ...languesContenu]) {
      final v = valeurs[l]?.trim() ?? '';
      if (v.isNotEmpty) return v;
    }
    return '';
  }

  String titre(String langue) => traduire(titres, langue);
  String texte(String langue) => traduire(textes, langue);

  /// Vrai si le texte n'existe pas dans [langue] (on affiche une autre langue).
  bool manque(String langue) => (titres[langue]?.trim() ?? '').isEmpty;

  static T _enum<T extends Enum>(List<T> valeurs, Object? v, T defaut) =>
      valeurs.firstWhere((e) => e.name == v, orElse: () => defaut);

  static Map<String, String> _carte(Object? v) => {
    for (final e in (v as Map? ?? const {}).entries)
      e.key as String: e.value as String? ?? '',
  };

  factory Contenu.depuisFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const {};
    return Contenu(
      id: doc.id,
      type: _enum(TypeContenu.values, d['type'], TypeContenu.meditation),
      theme: _enum(ThemeContenu.values, d['theme'], ThemeContenu.communication),
      titres: _carte(d['titre']),
      textes: _carte(d['texte']),
      reference: d['reference'] as String? ?? '',
      visibilite: _enum(Visibilite.values, d['visibilite'], Visibilite.public),
      publie: d['publie'] as bool? ?? false,
      ordre: (d['ordre'] as num? ?? 0).toInt(),
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> versFirestore() => {
    'type': type.name,
    'theme': theme.name,
    'titre': {
      for (final e in titres.entries)
        if (e.value.trim().isNotEmpty) e.key: e.value.trim(),
    },
    'texte': {
      for (final e in textes.entries)
        if (e.value.trim().isNotEmpty) e.key: e.value.trim(),
    },
    'reference': reference.trim(),
    'visibilite': visibilite.name,
    'publie': publie,
    'ordre': ordre,
  };
}

/// Méditation du jour : une méditation différente chaque jour, dans l'ordre
/// choisi par le coach, puis on recommence.
Contenu? meditationDuJour(List<Contenu> contenus, DateTime jour) {
  final meditations =
      contenus.where((c) => c.type == TypeContenu.meditation).toList()..sort(
        (a, b) => a.ordre != b.ordre
            ? a.ordre.compareTo(b.ordre)
            : (a.createdAt ?? DateTime(0)).compareTo(
                b.createdAt ?? DateTime(0),
              ),
      );
  if (meditations.isEmpty) return null;
  final numero = DateTime.utc(
    jour.year,
    jour.month,
    jour.day,
  ).difference(DateTime.utc(2026)).inDays;
  return meditations[numero % meditations.length];
}
