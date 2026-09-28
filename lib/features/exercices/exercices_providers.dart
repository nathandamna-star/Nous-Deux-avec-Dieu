import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';
import 'data/exercices_repository.dart';
import 'domain/exercice.dart';

final exercicesRepositoryProvider = Provider<ExercicesRepository>(
  (ref) => ExercicesRepository(ref.watch(firestoreProvider)),
);

final exercicesProvider = StreamProvider.family<List<Exercice>, String>(
  (ref, accId) => ref.watch(exercicesRepositoryProvider).exercices(accId),
);

final exerciceProvider =
    StreamProvider.family<Exercice?, ({String acc, String id})>(
      (ref, cle) => ref.watch(exercicesRepositoryProvider).un(cle.acc, cle.id),
    );

final reponseProvider =
    StreamProvider.family<Reponse?, ({String acc, String id, String cle})>(
      (ref, c) =>
          ref.watch(exercicesRepositoryProvider).reponse(c.acc, c.id, c.cle),
    );
