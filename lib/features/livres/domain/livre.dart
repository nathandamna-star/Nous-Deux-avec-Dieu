import 'package:cloud_firestore/cloud_firestore.dart';

import '../../contenus/domain/contenu.dart';

enum TypeFormat { papier, numerique, audio }

class FormatLivre {
  const FormatLivre({required this.type, required this.prix});

  final TypeFormat type;
  final double prix;

  Map<String, dynamic> versFirestore() => {
    'type': type.name,
    'prix': prix,
    'devise': 'EUR',
  };
}

/// Lien vers une boutique (Amazon, Fnac, site du coach…).
class LienAchat {
  const LienAchat({required this.libelle, required this.url});

  final String libelle;
  final String url;

  Map<String, dynamic> versFirestore() => {'libelle': libelle, 'url': url};
}

Map<String, String> _carte(Object? v) => {
  for (final e in (v as Map? ?? const {}).entries)
    e.key as String: e.value as String? ?? '',
};

/// Un livre du coach. Document `livres/{id}`. Un livre numérique n'est jamais
/// lu dans l'app : on renvoie vers la boutique qui le vend (règles des stores).
class Livre {
  const Livre({
    required this.id,
    this.titres = const {},
    this.sousTitres = const {},
    this.descriptions = const {},
    this.couvertureUrl = '',
    this.langues = const [],
    this.formats = const [],
    this.liens = const [],
    this.commandeDirecte = false,
    this.fraisEnvoi = 0,
    this.extraitUrl = '',
    this.publie = false,
    this.ordre = 0,
  });

  final String id;
  final Map<String, String> titres;
  final Map<String, String> sousTitres;
  final Map<String, String> descriptions;
  final String couvertureUrl;

  /// Langues dans lesquelles le livre existe.
  final List<String> langues;
  final List<FormatLivre> formats;
  final List<LienAchat> liens;

  /// Livre papier commandé directement au coach, payé par virement.
  final bool commandeDirecte;
  final double fraisEnvoi;
  final String extraitUrl;
  final bool publie;
  final int ordre;

  String titre(String langue) => Contenu.traduire(titres, langue);
  String sousTitre(String langue) => Contenu.traduire(sousTitres, langue);
  String description(String langue) => Contenu.traduire(descriptions, langue);

  double? get prixPapier =>
      formats.where((f) => f.type == TypeFormat.papier).firstOrNull?.prix;

  bool get commandable => commandeDirecte && prixPapier != null;

  /// Montant d'une commande directe (même calcul que les règles de sécurité).
  double montantCommande(int quantite) => prixPapier! * quantite + fraisEnvoi;

  factory Livre.depuisFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const {};
    return Livre(
      id: doc.id,
      titres: _carte(d['titre']),
      sousTitres: _carte(d['sousTitre']),
      descriptions: _carte(d['description']),
      couvertureUrl: d['couvertureUrl'] as String? ?? '',
      langues: List<String>.from(d['langues'] as List? ?? const []),
      formats: [
        for (final f in d['formats'] as List? ?? const [])
          if (f is Map)
            FormatLivre(
              type: TypeFormat.values.firstWhere(
                (t) => t.name == f['type'],
                orElse: () => TypeFormat.papier,
              ),
              prix: (f['prix'] as num? ?? 0).toDouble(),
            ),
      ],
      liens: [
        for (final l in d['liensAchat'] as List? ?? const [])
          if (l is Map)
            LienAchat(
              libelle: l['libelle'] as String? ?? '',
              url: l['url'] as String? ?? '',
            ),
      ],
      commandeDirecte: d['commandeDirecte'] as bool? ?? false,
      fraisEnvoi: (d['fraisEnvoi'] as num? ?? 0).toDouble(),
      extraitUrl: d['extraitUrl'] as String? ?? '',
      publie: d['publie'] as bool? ?? false,
      ordre: (d['ordre'] as num? ?? 0).toInt(),
    );
  }
}

class Adresse {
  const Adresse({
    required this.nom,
    required this.rue,
    required this.codePostal,
    required this.ville,
    required this.pays,
  });

  final String nom;
  final String rue;
  final String codePostal;
  final String ville;
  final String pays;

  Map<String, dynamic> versFirestore() => {
    'nom': nom.trim(),
    'rue': rue.trim(),
    'codePostal': codePostal.trim(),
    'ville': ville.trim(),
    'pays': pays.trim(),
  };

  factory Adresse.depuis(Object? v) {
    final d = v as Map? ?? const {};
    String s(String k) => d[k] as String? ?? '';
    return Adresse(
      nom: s('nom'),
      rue: s('rue'),
      codePostal: s('codePostal'),
      ville: s('ville'),
      pays: s('pays'),
    );
  }

  List<String> get lignes => [nom, rue, '$codePostal $ville', pays];
}

enum StatutCommande { enAttente, payee, envoyee, annulee }

StatutCommande _statut(Object? v) => switch (v) {
  'payee' => StatutCommande.payee,
  'envoyee' => StatutCommande.envoyee,
  'annulee' => StatutCommande.annulee,
  _ => StatutCommande.enAttente,
};

String valeurStatutCommande(StatutCommande s) =>
    s == StatutCommande.enAttente ? 'en_attente' : s.name;

/// Commande d'un livre papier au coach. Document `commandesLivres/{communication}`.
class CommandeLivre {
  const CommandeLivre({
    required this.id,
    required this.uid,
    required this.nom,
    required this.livreId,
    required this.livreTitre,
    required this.quantite,
    required this.montant,
    required this.adresse,
    required this.statut,
    this.numeroSuivi = '',
    this.createdAt,
  });

  /// Communication structurée (12 chiffres).
  final String id;
  final String uid;
  final String nom;
  final String livreId;
  final String livreTitre;
  final int quantite;
  final double montant;
  final Adresse adresse;
  final StatutCommande statut;
  final String numeroSuivi;
  final DateTime? createdAt;

  factory CommandeLivre.depuisFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data() ?? const {};
    return CommandeLivre(
      id: doc.id,
      uid: d['uid'] as String? ?? '',
      nom: d['nom'] as String? ?? '',
      livreId: d['livreId'] as String? ?? '',
      livreTitre: d['livreTitre'] as String? ?? '',
      quantite: (d['quantite'] as num? ?? 1).toInt(),
      montant: (d['montant'] as num? ?? 0).toDouble(),
      adresse: Adresse.depuis(d['adresse']),
      statut: _statut(d['statut']),
      numeroSuivi: d['numeroSuivi'] as String? ?? '',
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
