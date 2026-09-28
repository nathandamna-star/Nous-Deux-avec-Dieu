import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Partage d'un fichier (feuille de partage du téléphone : e-mail, Fichiers…).
abstract interface class Partage {
  Future<void> partagerFichier({
    required String nom,
    required String contenu,
    required String typeMime,
  });
}

class PartageNatif implements Partage {
  const PartageNatif();

  @override
  Future<void> partagerFichier({
    required String nom,
    required String contenu,
    required String typeMime,
  }) async {
    final dossier = await getTemporaryDirectory();
    final fichier = File('${dossier.path}/$nom');
    await fichier.writeAsString(contenu);
    await SharePlus.instance.share(
      ShareParams(files: [XFile(fichier.path, mimeType: typeMime)]),
    );
  }
}

final partageProvider = Provider<Partage>((ref) => const PartageNatif());
