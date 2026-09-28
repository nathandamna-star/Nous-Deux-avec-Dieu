import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../accompagnement/accompagnement_providers.dart';
import '../auth/auth_providers.dart';
import 'data/messagerie_repository.dart';
import 'data/pieces_jointes.dart';
import 'domain/message.dart';

final messagerieRepositoryProvider = Provider<MessagerieRepository>(
  (ref) => MessagerieRepository(ref.watch(firestoreProvider)),
);

final piecesJointesProvider = Provider<PiecesJointes>(
  (ref) => PiecesJointesFirebase(FirebaseStorage.instance),
);

final messagesProvider = StreamProvider.family<List<Message>, String>(
  (ref, accId) => ref.watch(messagerieRepositoryProvider).messages(accId),
);

/// Pastille de l'onglet Messages : messages non lus.
final nbNonLusProvider = Provider<int>((ref) {
  final uid = ref.watch(utilisateurFirebaseProvider).value?.uid;
  if (uid == null) return 0;
  if (ref.watch(estCoachProvider)) {
    return (ref.watch(tousAccompagnementsProvider).value ?? const []).fold(
      0,
      (n, a) => n + a.nonLusCoach,
    );
  }
  return ref.watch(monAccompagnementProvider).value?.nonLus[uid] ?? 0;
});
