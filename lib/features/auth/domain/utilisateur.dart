import 'package:cloud_firestore/cloud_firestore.dart';

import 'parcours.dart';

/// Profil `users/{uid}`.
class Utilisateur {
  const Utilisateur({
    required this.uid,
    required this.nom,
    required this.email,
    required this.langue,
    required this.parcours,
    this.consentementLe,
  });

  final String uid;
  final String nom;
  final String email;
  final String langue;
  final Parcours parcours;

  /// Date du consentement au traitement des données sensibles (RGPD).
  final DateTime? consentementLe;

  factory Utilisateur.depuisFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data() ?? const {};
    return Utilisateur(
      uid: doc.id,
      nom: d['nom'] as String? ?? '',
      email: d['email'] as String? ?? '',
      langue: d['langue'] as String? ?? 'fr',
      parcours: Parcours.depuis(d['parcours'] as String?),
      consentementLe: (d['consentementLe'] as Timestamp?)?.toDate(),
    );
  }
}
