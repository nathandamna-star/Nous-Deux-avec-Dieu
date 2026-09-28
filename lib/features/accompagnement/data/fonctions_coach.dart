import 'package:cloud_functions/cloud_functions.dart';

/// Cloud Functions réservées au coach.
abstract interface class FonctionsCoach {
  /// Fait du compte configuré au déploiement le coach.
  Future<void> revendiquerCoach();

  /// Charge les contenus de départ ; renvoie le nombre de documents ajoutés.
  Future<int> chargerContenusDeDepart();
}

class FonctionsCoachFirebase implements FonctionsCoach {
  @override
  Future<void> revendiquerCoach() =>
      FirebaseFunctions.instanceFor(region: 'europe-west1')
          .httpsCallable('revendiquerCoach')
          .call<void>();

  @override
  Future<int> chargerContenusDeDepart() async {
    final r = await FirebaseFunctions.instanceFor(region: 'europe-west1')
        .httpsCallable('chargerContenusDeDepart')
        .call<Map<String, dynamic>>();
    return (r.data['ajoutes'] as num? ?? 0).toInt();
  }
}
