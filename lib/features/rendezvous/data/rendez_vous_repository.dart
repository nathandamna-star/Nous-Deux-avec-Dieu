import 'package:cloud_firestore/cloud_firestore.dart';

import '../../accompagnement/domain/accompagnement.dart';
import '../domain/rendez_vous.dart';

class RendezVousRepository {
  RendezVousRepository(this.db);

  final FirebaseFirestore db;

  CollectionReference<Map<String, dynamic>> _rdv(String accId) =>
      db.collection('accompagnements/$accId/rendezVous');

  static List<RendezVous> _trier(QuerySnapshot<Map<String, dynamic>> s) =>
      s.docs.map(RendezVous.depuisFirestore).toList()
        ..sort((a, b) => a.debut.compareTo(b.debut));

  /// Rendez-vous d'un accompagnement (membres et coach).
  Stream<List<RendezVous>> deLAccompagnement(String accId) =>
      _rdv(accId).snapshots().map(_trier);

  /// Tous les rendez-vous, tous accompagnements confondus (coach).
  Stream<List<RendezVous>> tous() =>
      db.collectionGroup('rendezVous').snapshots().map(_trier);

  /// Crée ([existant] nul) ou modifie un rendez-vous. Si la date change,
  /// les rappels repartent.
  Future<void> planifier(
    Accompagnement acc, {
    RendezVous? existant,
    required DateTime debut,
    required int dureeMin,
    required String lienZoom,
  }) {
    final donnees = {
      'nom': acc.nom,
      'debut': Timestamp.fromDate(debut),
      'dureeMin': dureeMin,
      'lienZoom': lienZoom.trim(),
      'statut': StatutRendezVous.prevu.name,
      if (existant == null || existant.debut != debut) ...{
        'rappelVeille': false,
        'rappelHeure': false,
      },
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (existant != null) {
      return _rdv(acc.id).doc(existant.id).update(donnees);
    }
    return _rdv(acc.id)
        .add({...donnees, 'createdAt': FieldValue.serverTimestamp()});
  }

  Future<void> annuler(RendezVous r) => _rdv(r.accompagnementId)
      .doc(r.id)
      .update({
        'statut': StatutRendezVous.annule.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  /// Séance faite : une séance est décomptée du forfait (s'il en reste).
  Future<void> marquerFaite(RendezVous r, int seancesRestantes) {
    final batch = db.batch()
      ..update(_rdv(r.accompagnementId).doc(r.id), {
        'statut': StatutRendezVous.fait.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    if (seancesRestantes > 0) {
      batch.update(db.doc('accompagnements/${r.accompagnementId}'), {
        'seancesRestantes': seancesRestantes - 1,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
    return batch.commit();
  }
}
