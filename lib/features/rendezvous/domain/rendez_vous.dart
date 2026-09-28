import 'package:cloud_firestore/cloud_firestore.dart';

enum StatutRendezVous { prevu, fait, annule }

/// Un rendez-vous (séance Zoom). Document
/// `accompagnements/{accompagnementId}/rendezVous/{id}`.
class RendezVous {
  const RendezVous({
    required this.id,
    required this.accompagnementId,
    required this.nom,
    required this.debut,
    required this.dureeMin,
    this.lienZoom = '',
    this.statut = StatutRendezVous.prevu,
  });

  final String id;
  final String accompagnementId;

  /// Nom de l'accompagnement (ex. « Paul & Marie »).
  final String nom;
  final DateTime debut;
  final int dureeMin;
  final String lienZoom;
  final StatutRendezVous statut;

  DateTime get fin => debut.add(Duration(minutes: dureeMin));

  /// Encore à venir (ou en cours) et pas annulé.
  bool aVenir(DateTime maintenant) =>
      statut == StatutRendezVous.prevu && fin.isAfter(maintenant);

  /// Dans moins de 15 minutes, ou en cours : le bouton Zoom est mis en avant.
  bool imminent(DateTime maintenant) =>
      aVenir(maintenant) &&
      !maintenant.isBefore(debut.subtract(const Duration(minutes: 15)));

  factory RendezVous.depuisFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final d = doc.data() ?? const {};
    return RendezVous(
      id: doc.id,
      accompagnementId: doc.reference.parent.parent?.id ?? '',
      nom: d['nom'] as String? ?? '',
      debut: (d['debut'] as Timestamp?)?.toDate() ?? DateTime(2000),
      dureeMin: (d['dureeMin'] as num? ?? 60).toInt(),
      lienZoom: d['lienZoom'] as String? ?? '',
      statut: StatutRendezVous.values.firstWhere(
        (s) => s.name == d['statut'],
        orElse: () => StatutRendezVous.prevu,
      ),
    );
  }
}

/// Lien Zoom accepté : une adresse https (zoom.us ou autre outil de visio).
bool lienVisioValide(String lien) {
  final uri = Uri.tryParse(lien.trim());
  return uri != null && uri.scheme == 'https' && uri.host.contains('.');
}
