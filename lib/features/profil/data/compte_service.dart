import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';

class ErreurCompte implements Exception {
  const ErreurCompte(this.code);

  /// « commande-en-cours », « compte-coach », « reseau » ou « inconnue ».
  final String code;
}

/// Export et suppression du compte, faits par le serveur (Cloud Functions
/// `exporterMesDonnees` et `supprimerMonCompte`).
abstract interface class CompteService {
  /// Toutes les données de la personne, en JSON lisible.
  Future<String> exporterMesDonnees();

  Future<void> supprimerMonCompte();
}

class CompteServiceFirebase implements CompteService {
  CompteServiceFirebase(this.fonctions);

  final FirebaseFunctions fonctions;

  Future<Object?> _appeler(String nom) async {
    try {
      return (await fonctions.httpsCallable(nom).call<Object?>()).data;
    } on FirebaseFunctionsException catch (e) {
      final details = e.details;
      final code = details is Map ? details['code'] as String? : null;
      throw ErreurCompte(
        code ??
            (e.code == 'unavailable' || e.code == 'deadline-exceeded'
                ? 'reseau'
                : 'inconnue'),
      );
    }
  }

  @override
  Future<String> exporterMesDonnees() async =>
      const JsonEncoder.withIndent('  ')
          .convert(await _appeler('exporterMesDonnees'));

  @override
  Future<void> supprimerMonCompte() => _appeler('supprimerMonCompte');
}
