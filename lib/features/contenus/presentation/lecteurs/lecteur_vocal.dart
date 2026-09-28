import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../l10n/app_localizations.dart';
import 'lecteurs.dart';

/// Petit lecteur pour un message vocal dans une conversation.
class LecteurVocal extends StatefulWidget {
  const LecteurVocal({super.key, required this.url, this.couleur});

  final String url;
  final Color? couleur;

  @override
  State<LecteurVocal> createState() => _LecteurVocalState();
}

class _LecteurVocalState extends State<LecteurVocal> {
  final _lecteur = AudioPlayer();
  var _pret = false;

  Future<void> _basculer() async {
    if (!_pret) {
      await _lecteur.setUrl(widget.url);
      _pret = true;
    }
    if (_lecteur.playing) {
      await _lecteur.pause();
    } else {
      if (_lecteur.processingState == ProcessingState.completed) {
        await _lecteur.seek(Duration.zero);
      }
      await _lecteur.play();
    }
  }

  @override
  void dispose() {
    _lecteur.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StreamBuilder<PlayerState>(
      stream: _lecteur.playerStateStream,
      builder: (context, etat) {
        final joue =
            (etat.data?.playing ?? false) &&
            etat.data?.processingState != ProcessingState.completed;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: joue ? l10n.pause : l10n.lecture,
              color: widget.couleur,
              icon: Icon(joue ? Icons.pause_circle : Icons.play_circle),
              iconSize: 36,
              onPressed: _basculer,
            ),
            StreamBuilder<Duration>(
              stream: _lecteur.positionStream,
              builder: (context, p) => Text(
                '🎤 ${formatDuree(p.data ?? Duration.zero)}'
                '${_lecteur.duration == null ? '' : ' / ${formatDuree(_lecteur.duration!)}'}',
                style: TextStyle(color: widget.couleur),
              ),
            ),
          ],
        );
      },
    );
  }
}
