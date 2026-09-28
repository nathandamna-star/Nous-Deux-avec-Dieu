import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../auth/auth_providers.dart';
import 'data/rendez_vous_repository.dart';
import 'domain/rendez_vous.dart';

final rendezVousRepositoryProvider = Provider<RendezVousRepository>(
  (ref) => RendezVousRepository(ref.watch(firestoreProvider)),
);

/// Heure actuelle (remplaçable dans les tests).
final horlogeProvider = Provider<DateTime Function()>((ref) => DateTime.now);

final rendezVousProvider = StreamProvider.family<List<RendezVous>, String>(
  (ref, accId) =>
      ref.watch(rendezVousRepositoryProvider).deLAccompagnement(accId),
);

/// Agenda du coach : tous les rendez-vous.
final agendaProvider = StreamProvider<List<RendezVous>>(
  (ref) => ref.watch(rendezVousRepositoryProvider).tous(),
);

/// Dernier lien Zoom saisi par le coach, proposé pour le rendez-vous suivant.
const _cleLienZoom = 'dernierLienZoom';

String dernierLienZoom(SharedPreferences prefs) =>
    prefs.getString(_cleLienZoom) ?? '';

Future<void> memoriserLienZoom(SharedPreferences prefs, String lien) =>
    prefs.setString(_cleLienZoom, lien.trim());
