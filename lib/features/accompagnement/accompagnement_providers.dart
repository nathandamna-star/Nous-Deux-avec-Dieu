import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';
import 'data/accompagnement_repository.dart';
import 'data/fonctions_coach.dart';
import 'domain/accompagnement.dart';

final accompagnementRepositoryProvider = Provider<AccompagnementRepository>(
  (ref) => AccompagnementRepository(ref.watch(firestoreProvider)),
);

final fonctionsCoachProvider = Provider<FonctionsCoach>(
  (ref) => FonctionsCoachFirebase(),
);

/// Accompagnement de l'utilisateur connecté (null s'il n'en a pas).
final monAccompagnementProvider = StreamProvider<Accompagnement?>((ref) {
  final uid = ref.watch(utilisateurFirebaseProvider).value?.uid;
  if (uid == null) return Stream.value(null);
  return ref.watch(accompagnementRepositoryProvider).monAccompagnement(uid);
});

final tousAccompagnementsProvider = StreamProvider<List<Accompagnement>>(
  (ref) => ref.watch(accompagnementRepositoryProvider).tous(),
);

final accompagnementProvider = StreamProvider.family<Accompagnement?, String>(
  (ref, id) => ref.watch(accompagnementRepositoryProvider).un(id),
);

final notesProvider = StreamProvider.family<List<Note>, String>(
  (ref, id) => ref.watch(accompagnementRepositoryProvider).notes(id),
);
