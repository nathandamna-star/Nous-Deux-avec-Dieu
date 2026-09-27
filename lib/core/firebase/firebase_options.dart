// Configuration Firebase du projet « nous-deux-avec-dieu ».
// Ces identifiants ne sont pas secrets : la sécurité repose sur les règles
// Firestore et Storage (voir CLAUDE.md, section 5).
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

abstract final class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => switch (defaultTargetPlatform) {
    TargetPlatform.iOS => ios,
    TargetPlatform.android => android,
    _ => throw UnsupportedError('Plateforme non prise en charge'),
  };

  static const _projet = 'nous-deux-avec-dieu';
  static const _cle = 'AIzaSyBsVNFiP9zgmDWMqKbW2hNsj5XZedRw2s0';
  static const _expediteur = '585281365575';

  static const android = FirebaseOptions(
    apiKey: _cle,
    appId: '1:585281365575:android:70cb6077ee297e938bf362',
    messagingSenderId: _expediteur,
    projectId: _projet,
    storageBucket: '$_projet.firebasestorage.app',
  );

  static const ios = FirebaseOptions(
    apiKey: _cle,
    appId: '1:585281365575:ios:bc9785f217bfa0c18bf362',
    messagingSenderId: _expediteur,
    projectId: _projet,
    storageBucket: '$_projet.firebasestorage.app',
    iosBundleId: 'com.nousdeuxavecdieu.app',
  );
}
