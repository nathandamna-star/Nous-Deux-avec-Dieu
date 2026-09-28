import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

/// Photo de profil : prise ou choisie sur le téléphone, réduite, puis envoyée
/// dans Storage (`users/{uid}/profil.jpg`).
abstract interface class PhotoProfilService {
  /// Renvoie l'adresse de la photo envoyée, ou null si l'utilisateur annule.
  Future<String?> choisirEtEnvoyer(String uid, {required bool camera});

  Future<void> supprimer(String uid);
}

class PhotoProfilFirebase implements PhotoProfilService {
  PhotoProfilFirebase(this.storage);

  final FirebaseStorage storage;

  Reference _ref(String uid) => storage.ref('users/$uid/profil.jpg');

  @override
  Future<String?> choisirEtEnvoyer(String uid, {required bool camera}) async {
    final image = await ImagePicker().pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      preferredCameraDevice: CameraDevice.front,
      // Petite photo : envoi rapide, même avec une connexion lente.
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );
    if (image == null) return null;
    final ref = _ref(uid);
    await ref.putData(
      await image.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return ref.getDownloadURL();
  }

  @override
  Future<void> supprimer(String uid) async {
    try {
      await _ref(uid).delete();
    } on FirebaseException catch (e) {
      if (e.code != 'object-not-found') rethrow;
    }
  }
}
