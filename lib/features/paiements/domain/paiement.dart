import 'package:cloud_firestore/cloud_firestore.dart';

import '../../contenus/domain/contenu.dart';

Map<String, String> _carte(Object? v) => {
  for (final e in (v as Map? ?? const {}).entries)
    e.key as String: e.value as String? ?? '',
};

/// Forfait de séances. Document `forfaits/{id}`.
class Forfait {
  const Forfait({
    required this.id,
    required this.noms,
    required this.nbSeances,
    required this.prix,
    this.actif = true,
    this.ordre = 0,
  });

  final String id;

  /// Nom par langue (le français au minimum).
  final Map<String, String> noms;
  final int nbSeances;
  final double prix;
  final bool actif;
  final int ordre;

  String nom(String langue) => Contenu.traduire(noms, langue);

  factory Forfait.depuisFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const {};
    return Forfait(
      id: doc.id,
      noms: _carte(d['nom']),
      nbSeances: (d['nbSeances'] as num? ?? 1).toInt(),
      prix: (d['prix'] as num? ?? 0).toDouble(),
      actif: d['actif'] as bool? ?? false,
      ordre: (d['ordre'] as num? ?? 0).toInt(),
    );
  }
}

enum TypePaiement { forfait, don }

enum StatutPaiement {
  enAttente('en_attente'),
  recu,
  annule;

  const StatutPaiement([this._valeur]);
  final String? _valeur;
  String get valeur => _valeur ?? name;

  static StatutPaiement depuis(Object? v) => values.firstWhere(
    (s) => s.valeur == v,
    orElse: () => StatutPaiement.enAttente,
  );
}

/// Paiement par virement (forfait ou don). Document `paiements/{communication}` :
/// l'identifiant est la communication structurée (12 chiffres).
class Paiement {
  const Paiement({
    required this.id,
    required this.type,
    required this.uid,
    required this.nom,
    required this.montant,
    required this.statut,
    this.accompagnementId,
    this.forfaitId,
    this.forfaitNom = '',
    this.nbSeances = 0,
    this.createdAt,
    this.confirmeLe,
  });

  /// Communication structurée (12 chiffres).
  final String id;
  final TypePaiement type;
  final String uid;

  /// Nom de la personne qui paie (pour le coach).
  final String nom;
  final double montant;
  final StatutPaiement statut;
  final String? accompagnementId;
  final String? forfaitId;
  final String forfaitNom;
  final int nbSeances;
  final DateTime? createdAt;
  final DateTime? confirmeLe;

  String get communication => id;

  factory Paiement.depuisFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const {};
    return Paiement(
      id: doc.id,
      type: d['type'] == 'don' ? TypePaiement.don : TypePaiement.forfait,
      uid: d['uid'] as String? ?? '',
      nom: d['nom'] as String? ?? '',
      montant: (d['montant'] as num? ?? 0).toDouble(),
      statut: StatutPaiement.depuis(d['statut']),
      accompagnementId: d['accompagnementId'] as String?,
      forfaitId: d['forfaitId'] as String?,
      forfaitNom: d['forfaitNom'] as String? ?? '',
      nbSeances: (d['nbSeances'] as num? ?? 0).toInt(),
      createdAt: (d['createdAt'] as Timestamp?)?.toDate(),
      confirmeLe: (d['confirmeLe'] as Timestamp?)?.toDate(),
    );
  }
}

/// Coordonnées bancaires et textes du coach. Document `parametres/coach`.
class ParametresCoach {
  const ParametresCoach({
    this.nomAffiche = '',
    this.titulaire = '',
    this.iban = '',
    this.bic = '',
    this.messagesDon = const {},
  });

  final String nomAffiche;
  final String titulaire;
  final String iban;
  final String bic;

  /// Remerciement affiché sur l'écran de don, par langue.
  final Map<String, String> messagesDon;

  bool get virementPossible => titulaire.isNotEmpty && iban.isNotEmpty;

  String messageDon(String langue) => Contenu.traduire(messagesDon, langue);

  factory ParametresCoach.depuis(Map<String, dynamic>? d) => ParametresCoach(
    nomAffiche: d?['nomAffiche'] as String? ?? '',
    titulaire: d?['titulaire'] as String? ?? '',
    iban: d?['iban'] as String? ?? '',
    bic: d?['bic'] as String? ?? '',
    messagesDon: _carte(d?['messageDon']),
  );
}
