import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

/// Couverture d'un livre : image choisie sur le téléphone, envoyée dans
/// Storage (`livres/{id}/couverture.jpg`).
abstract interface class CouverturesService {
  /// Renvoie l'adresse de l'image envoyée, ou null si le coach annule.
  Future<String?> choisirEtEnvoyer(String livreId);
}

class CouverturesFirebase implements CouverturesService {
  CouverturesFirebase(this.storage);

  final FirebaseStorage storage;

  @override
  Future<String?> choisirEtEnvoyer(String livreId) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1600,
      imageQuality: 85,
    );
    if (image == null) return null;
    final ref = storage.ref(
      'livres/$livreId/couverture-${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await ref.putData(
      await image.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return ref.getDownloadURL();
  }
}
