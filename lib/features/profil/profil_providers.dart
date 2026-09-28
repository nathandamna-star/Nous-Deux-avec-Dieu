import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/compte_service.dart';
import 'data/photo_profil_service.dart';

final photoProfilServiceProvider = Provider<PhotoProfilService>(
  (ref) => PhotoProfilFirebase(FirebaseStorage.instance),
);

final compteServiceProvider = Provider<CompteService>(
  (ref) => CompteServiceFirebase(
    FirebaseFunctions.instanceFor(region: 'europe-west1'),
  ),
);
