import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/photo_profil_service.dart';

final photoProfilServiceProvider = Provider<PhotoProfilService>(
  (ref) => PhotoProfilFirebase(FirebaseStorage.instance),
);
