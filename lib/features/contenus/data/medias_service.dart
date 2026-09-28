import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../domain/contenu.dart';

/// Choix d'un fichier audio ou vidéo sur le téléphone du coach, puis envoi
/// dans Firebase Storage (`contenus/{id}/…`).
abstract interface class MediasService {
  /// Renvoie l'adresse du fichier envoyé, ou null si le coach annule.
  /// [progression] reçoit une valeur entre 0 et 1.
  Future<String?> choisirEtEnvoyer({
    required String contenuId,
    required String langue,
    required TypeContenu type,
    void Function(double)? progression,
  });
}

class MediasFirebase implements MediasService {
  MediasFirebase(this.storage);

  final FirebaseStorage storage;

  @override
  Future<String?> choisirEtEnvoyer({
    required String contenuId,
    required String langue,
    required TypeContenu type,
    void Function(double)? progression,
  }) async {
    final video = type == TypeContenu.video;
    final fichier = await FilePicker.pickFile(
      type: video ? FileType.video : FileType.audio,
      // Vidéos recompressées par le téléphone : envoi plus rapide, moins
      // d'espace et de bande passante.
      compressionQuality: video ? 60 : 0,
    );
    final chemin = fichier?.path;
    if (fichier == null || chemin == null) return null;
    final extension = (fichier.extension ?? (video ? 'mp4' : 'm4a'))
        .toLowerCase();
    final ref = storage.ref(
      'contenus/$contenuId/$langue-${DateTime.now().millisecondsSinceEpoch}'
      '.$extension',
    );
    final envoi = ref.putFile(
      File(chemin),
      SettableMetadata(contentType: _typeMime(extension, video)),
    );
    envoi.snapshotEvents.listen((s) {
      if (s.totalBytes > 0) {
        progression?.call(s.bytesTransferred / s.totalBytes);
      }
    });
    await envoi;
    return ref.getDownloadURL();
  }

  static String _typeMime(String extension, bool video) => switch (extension) {
    'mp3' => 'audio/mpeg',
    'm4a' || 'aac' => 'audio/mp4',
    'wav' => 'audio/wav',
    'mov' => 'video/quicktime',
    'mp4' || 'm4v' => 'video/mp4',
    _ => video ? 'video/mp4' : 'audio/mp4',
  };
}
