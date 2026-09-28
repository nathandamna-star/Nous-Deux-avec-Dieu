import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';
import 'data/parcours_repository.dart';
import 'domain/parcours.dart';

final parcoursRepositoryProvider = Provider<ParcoursRepository>(
  (ref) => ParcoursRepository(ref.watch(firestoreProvider)),
);

final parcoursPubliesProvider = StreamProvider<List<Parcours>>(
  (ref) => ref
      .watch(parcoursRepositoryProvider)
      .publies(connecte: ref.watch(estConnecteProvider)),
);

final tousParcoursProvider = StreamProvider<List<Parcours>>(
  (ref) => ref.watch(parcoursRepositoryProvider).tous(),
);

final parcoursProvider = StreamProvider.family<Parcours?, String>(
  (ref, id) => ref.watch(parcoursRepositoryProvider).un(id),
);

/// Progression de l'utilisateur connecté (vide sans compte).
final progressionProvider = StreamProvider.family<Progression, String>((
  ref,
  id,
) {
  final uid = ref.watch(utilisateurFirebaseProvider).value?.uid;
  if (uid == null) return Stream.value(const Progression({}));
  return ref.watch(parcoursRepositoryProvider).progression(uid, id);
});
