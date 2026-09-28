import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';
import 'data/couvertures_service.dart';
import 'data/livres_repository.dart';
import 'domain/livre.dart';

final livresRepositoryProvider = Provider<LivresRepository>(
  (ref) => LivresRepository(ref.watch(firestoreProvider)),
);

final couverturesServiceProvider = Provider<CouverturesService>(
  (ref) => CouverturesFirebase(FirebaseStorage.instance),
);

final livresPubliesProvider = StreamProvider<List<Livre>>(
  (ref) => ref.watch(livresRepositoryProvider).publies(),
);

final tousLivresProvider = StreamProvider<List<Livre>>(
  (ref) => ref.watch(livresRepositoryProvider).tous(),
);

final livreProvider = StreamProvider.family<Livre?, String>(
  (ref, id) => ref.watch(livresRepositoryProvider).un(id),
);

final commandeLivreProvider = StreamProvider.family<CommandeLivre?, String>(
  (ref, id) => ref.watch(livresRepositoryProvider).commande(id),
);

final mesCommandesLivresProvider = StreamProvider<List<CommandeLivre>>((ref) {
  final uid = ref.watch(utilisateurFirebaseProvider).value?.uid;
  if (uid == null) return Stream.value(const []);
  return ref.watch(livresRepositoryProvider).mesCommandes(uid);
});

final toutesCommandesLivresProvider = StreamProvider<List<CommandeLivre>>(
  (ref) => ref.watch(livresRepositoryProvider).toutesCommandes(),
);

/// Coach : commandes à traiter (paiement à confirmer ou livre à envoyer).
final nbCommandesATraiterProvider = Provider<int>(
  (ref) => (ref.watch(toutesCommandesLivresProvider).value ?? const [])
      .where(
        (c) =>
            c.statut == StatutCommande.enAttente ||
            c.statut == StatutCommande.payee,
      )
      .length,
);
