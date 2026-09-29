import 'package:cloud_firestore/cloud_firestore.dart';

import '../../paiements/domain/virement.dart';
import '../domain/livre.dart';

class LivresRepository {
  LivresRepository(this.db);

  final FirebaseFirestore db;

  CollectionReference<Map<String, dynamic>> get _livres =>
      db.collection('livres');
  CollectionReference<Map<String, dynamic>> get _commandes =>
      db.collection('commandesLivres');

  static List<Livre> _tries(QuerySnapshot<Map<String, dynamic>> s) =>
      s.docs.map(Livre.depuisFirestore).toList()
        ..sort((a, b) => a.ordre.compareTo(b.ordre));

  Stream<List<Livre>> publies() =>
      _livres.where('publie', isEqualTo: true).snapshots().map(_tries);

  Stream<List<Livre>> tous() => _livres.snapshots().map(_tries);

  Stream<Livre?> un(String id) => _livres
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? Livre.depuisFirestore(d) : null);

  String nouvelId() => _livres.doc().id;

  Future<void> enregistrer(Livre l, {required bool nouveau}) {
    final donnees = {
      'titre': l.titres,
      'sousTitre': l.sousTitres,
      'description': l.descriptions,
      'couvertureUrl': l.couvertureUrl,
      'langues': l.langues,
      'formats': [for (final f in l.formats) f.versFirestore()],
      'prixPapier': l.prixPapier,
      'liensAchat': [for (final lien in l.liens) lien.versFirestore()],
      'commandeDirecte': l.commandable,
      'fraisEnvoi': l.fraisEnvoi,
      'extraitUrl': l.extraitUrl,
      'publie': l.publie,
      'ordre': l.ordre,
      'categorie': l.categorie.name,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (nouveau) {
      return _livres.doc(l.id).set({
        ...donnees,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    return _livres.doc(l.id).update(donnees);
  }

  Future<void> supprimer(String id) => _livres.doc(id).delete();

  // ----- Commandes directes (livre papier, virement) -----

  /// Crée la commande en attente de paiement ; renvoie la communication.
  Future<String> commander({
    required String uid,
    required String nom,
    required Livre livre,
    required String langue,
    required int quantite,
    required Adresse adresse,
  }) async {
    final communication = genererCommunication();
    await _commandes.doc(communication).set({
      'uid': uid,
      'nom': nom,
      'livreId': livre.id,
      'livreTitre': livre.titre(langue),
      'quantite': quantite,
      'montant': livre.montantCommande(quantite),
      'devise': 'EUR',
      'adresse': adresse.versFirestore(),
      'statut': valeurStatutCommande(StatutCommande.enAttente),
      'createdAt': FieldValue.serverTimestamp(),
    });
    return communication;
  }

  static List<CommandeLivre> _recentes(QuerySnapshot<Map<String, dynamic>> s) =>
      s.docs.map(CommandeLivre.depuisFirestore).toList()..sort(
        (a, b) => (b.createdAt ?? DateTime(2100)).compareTo(
          a.createdAt ?? DateTime(2100),
        ),
      );

  Stream<CommandeLivre?> commande(String id) => _commandes
      .doc(id)
      .snapshots()
      .map((d) => d.exists ? CommandeLivre.depuisFirestore(d) : null);

  Stream<List<CommandeLivre>> mesCommandes(String uid) =>
      _commandes.where('uid', isEqualTo: uid).snapshots().map(_recentes);

  Stream<List<CommandeLivre>> toutesCommandes() =>
      _commandes.snapshots().map(_recentes);

  Future<void> changerStatut(
    String id,
    StatutCommande statut, {
    String? numeroSuivi,
  }) => _commandes.doc(id).update({
    'statut': valeurStatutCommande(statut),
    if (statut == StatutCommande.payee) 'payeeLe': FieldValue.serverTimestamp(),
    if (statut == StatutCommande.envoyee) ...{
      'envoyeeLe': FieldValue.serverTimestamp(),
      if (numeroSuivi != null && numeroSuivi.trim().isNotEmpty)
        'numeroSuivi': numeroSuivi.trim(),
    },
  });
}
