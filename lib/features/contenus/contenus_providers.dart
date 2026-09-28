import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';
import 'data/contenus_repository.dart';
import 'data/medias_service.dart';
import 'domain/contenu.dart';

final contenusRepositoryProvider = Provider<ContenusRepository>(
  (ref) => ContenusRepository(ref.watch(firestoreProvider)),
);

final contenusPubliesProvider = StreamProvider<List<Contenu>>(
  (ref) => ref
      .watch(contenusRepositoryProvider)
      .publies(connecte: ref.watch(estConnecteProvider)),
);

final tousContenusProvider = StreamProvider<List<Contenu>>(
  (ref) => ref.watch(contenusRepositoryProvider).tous(),
);

final contenuProvider = StreamProvider.family<Contenu?, String>(
  (ref, id) => ref.watch(contenusRepositoryProvider).un(id),
);

final mediasServiceProvider = Provider<MediasService>(
  (ref) => MediasFirebase(FirebaseStorage.instance),
);
