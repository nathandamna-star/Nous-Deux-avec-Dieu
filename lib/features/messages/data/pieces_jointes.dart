import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// Photos et messages vocaux : prise, enregistrement et envoi dans Storage
/// (`messages/{accompagnementId}/…`).
abstract interface class PiecesJointes {
  /// Photo réduite, ou null si l'utilisateur annule.
  Future<Uint8List?> choisirPhoto({required bool camera});

  Future<String> envoyerPhoto(String accId, Uint8List octets);

  /// Démarre l'enregistrement ; false si le micro est refusé.
  Future<bool> demarrerVocal();

  /// Arrête l'enregistrement et renvoie le fichier (null si rien).
  Future<String?> arreterVocal();

  Future<void> annulerVocal();

  Future<String> envoyerVocal(String accId, String chemin);
}

class PiecesJointesFirebase implements PiecesJointes {
  PiecesJointesFirebase(this.storage);

  final FirebaseStorage storage;
  final _enregistreur = AudioRecorder();

  String _nom(String accId, String extension) =>
      'messages/$accId/${DateTime.now().millisecondsSinceEpoch}.$extension';

  @override
  Future<Uint8List?> choisirPhoto({required bool camera}) async {
    final image = await ImagePicker().pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 80,
    );
    return image?.readAsBytes();
  }

  @override
  Future<String> envoyerPhoto(String accId, Uint8List octets) async {
    final ref = storage.ref(_nom(accId, 'jpg'));
    await ref.putData(octets, SettableMetadata(contentType: 'image/jpeg'));
    return ref.getDownloadURL();
  }

  @override
  Future<bool> demarrerVocal() async {
    if (!await _enregistreur.hasPermission()) return false;
    final dossier = await getTemporaryDirectory();
    await _enregistreur.start(
      const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 64000),
      path:
          '${dossier.path}/vocal-${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
    return true;
  }

  @override
  Future<String?> arreterVocal() => _enregistreur.stop();

  @override
  Future<void> annulerVocal() => _enregistreur.cancel();

  @override
  Future<String> envoyerVocal(String accId, String chemin) async {
    final ref = storage.ref(_nom(accId, 'm4a'));
    await ref.putFile(File(chemin), SettableMetadata(contentType: 'audio/mp4'));
    return ref.getDownloadURL();
  }
}
