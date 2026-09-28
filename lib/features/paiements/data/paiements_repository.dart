import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/paiement.dart';
import '../domain/virement.dart';

class PaiementsRepository {
  PaiementsRepository(this.db);

  final FirebaseFirestore db;

  CollectionReference<Map<String, dynamic>> get _forfaits =>
      db.collection('forfaits');
  CollectionReference<Map<String, dynamic>> get _paiements =>
      db.collection('paiements');
  DocumentReference<Map<String, dynamic>> get _parametres =>
      db.doc('parametres/coach');
  DocumentReference<Map<String, dynamic>> get _presentation =>
      db.doc('parametres/presentation');

  static List<Forfait> _forfaitsTries(QuerySnapshot<Map<String, dynamic>> s) =>
      s.docs.map(Forfait.depuisFirestore).toList()
        ..sort((a, b) => a.ordre.compareTo(b.ordre));

  // ----- Forfaits -----

  Stream<List<Forfait>> forfaitsActifs() =>
      _forfaits.where('actif', isEqualTo: true).snapshots().map(_forfaitsTries);

  Stream<List<Forfait>> tousForfaits() =>
      _forfaits.snapshots().map(_forfaitsTries);

  Future<void> enregistrerForfait(Forfait f) {
    final donnees = {
      'nom': f.noms,
      'nbSeances': f.nbSeances,
      'prix': f.prix,
      'devise': 'EUR',
      'actif': f.actif,
      'ordre': f.ordre,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (f.id.isEmpty) {
      return _forfaits.add({
        ...donnees,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    return _forfaits.doc(f.id).update(donnees);
  }

  Future<void> supprimerForfait(String id) => _forfaits.doc(id).delete();

  // ----- Paiements -----

  Future<String> _creer(Map<String, dynamic> donnees) async {
    final communication = genererCommunication();
    await _paiements.doc(communication).set({
      ...donnees,
      'devise': 'EUR',
      'statut': StatutPaiement.enAttente.valeur,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return communication;
  }

  /// Achat d'un forfait : paiement en attente ; renvoie la communication.
  Future<String> acheterForfait({
    required String uid,
    required String nom,
    required String accompagnementId,
    required Forfait forfait,
    required String langue,
  }) => _creer({
    'type': TypePaiement.forfait.name,
    'uid': uid,
    'nom': nom,
    'accompagnementId': accompagnementId,
    'forfaitId': forfait.id,
    'forfaitNom': forfait.nom(langue),
    'nbSeances': forfait.nbSeances,
    'montant': forfait.prix,
  });

  /// Don libre : il ne débloque rien.
  Future<String> faireUnDon({
    required String uid,
    required String nom,
    required double montant,
  }) => _creer({
    'type': TypePaiement.don.name,
    'uid': uid,
    'nom': nom,
    'montant': montant,
  });

  Stream<Paiement?> paiement(String id) => _paiements
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? Paiement.depuisFirestore(d) : null);

  static List<Paiement> _recents(QuerySnapshot<Map<String, dynamic>> s) =>
      s.docs.map(Paiement.depuisFirestore).toList()..sort(
        (a, b) => (b.createdAt ?? DateTime(2100)).compareTo(
          a.createdAt ?? DateTime(2100),
        ),
      );

  Stream<List<Paiement>> mesPaiements(String uid) =>
      _paiements.where('uid', isEqualTo: uid).snapshots().map(_recents);

  Stream<List<Paiement>> tousPaiements() =>
      _paiements.snapshots().map(_recents);

  /// Coach : virement reçu. Les séances sont créditées par le serveur.
  Future<void> confirmer(String id) => _paiements.doc(id).update({
    'statut': StatutPaiement.recu.valeur,
    'confirmeLe': FieldValue.serverTimestamp(),
  });

  /// Le coach, ou la personne tant que le paiement est en attente.
  Future<void> annuler(String id) =>
      _paiements.doc(id).update({'statut': StatutPaiement.annule.valeur});

  // ----- Paramètres du coach -----

  /// Coordonnées bancaires et présentation (pour l'écran du coach).
  Stream<ParametresCoach> parametres() => _parametres.snapshots().asyncMap(
    (d) async =>
        ParametresCoach.depuis(d.data())
            .avecPresentation((await _presentation.get()).data()),
  );

  Stream<PresentationCoach> presentation() =>
      _presentation.snapshots().map((d) => PresentationCoach.depuis(d.data()));

  Future<void> enregistrerParametres(ParametresCoach p) async {
    await _presentation.set({
      'nomAffiche': p.nomAffiche.trim(),
      'bio': p.bios,
      'photoUrl': p.photoUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await _parametresBancaires(p);
  }

  Future<void> _parametresBancaires(ParametresCoach p) => _parametres.set({
    'nomAffiche': p.nomAffiche.trim(),
    'titulaire': p.titulaire.trim(),
    'iban': nettoyerIban(p.iban),
    'bic': p.bic.trim().toUpperCase(),
    'messageDon': p.messagesDon,
    'updatedAt': FieldValue.serverTimestamp(),
  });
}
