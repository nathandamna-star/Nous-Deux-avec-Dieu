import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';
import 'data/paiements_repository.dart';
import 'domain/paiement.dart';

final paiementsRepositoryProvider = Provider<PaiementsRepository>(
  (ref) => PaiementsRepository(ref.watch(firestoreProvider)),
);

final forfaitsActifsProvider = StreamProvider<List<Forfait>>(
  (ref) => ref.watch(paiementsRepositoryProvider).forfaitsActifs(),
);

final tousForfaitsProvider = StreamProvider<List<Forfait>>(
  (ref) => ref.watch(paiementsRepositoryProvider).tousForfaits(),
);

final paiementProvider = StreamProvider.family<Paiement?, String>(
  (ref, id) => ref.watch(paiementsRepositoryProvider).paiement(id),
);

final mesPaiementsProvider = StreamProvider<List<Paiement>>((ref) {
  final uid = ref.watch(utilisateurFirebaseProvider).value?.uid;
  if (uid == null) return Stream.value(const []);
  return ref.watch(paiementsRepositoryProvider).mesPaiements(uid);
});

final tousPaiementsProvider = StreamProvider<List<Paiement>>(
  (ref) => ref.watch(paiementsRepositoryProvider).tousPaiements(),
);

/// Coach : paiements annoncés, à confirmer.
final nbPaiementsEnAttenteProvider = Provider<int>(
  (ref) => (ref.watch(tousPaiementsProvider).value ?? const [])
      .where((p) => p.statut == StatutPaiement.enAttente)
      .length,
);

final parametresCoachProvider = StreamProvider<ParametresCoach>(
  (ref) => ref.watch(paiementsRepositoryProvider).parametres(),
);
