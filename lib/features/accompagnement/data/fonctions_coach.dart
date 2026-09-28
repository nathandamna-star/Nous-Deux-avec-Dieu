import 'package:cloud_functions/cloud_functions.dart';

/// Appel de la Cloud Function qui fait du compte configuré le coach.
abstract interface class FonctionsCoach {
  Future<void> revendiquerCoach();
}

class FonctionsCoachFirebase implements FonctionsCoach {
  @override
  Future<void> revendiquerCoach() =>
      FirebaseFunctions.instanceFor(region: 'europe-west1')
          .httpsCallable('revendiquerCoach')
          .call<void>();
}
