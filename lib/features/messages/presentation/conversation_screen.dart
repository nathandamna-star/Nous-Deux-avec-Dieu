import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../accompagnement/accompagnement_providers.dart';
import '../../accompagnement/domain/accompagnement.dart';
import '../../auth/auth_providers.dart';
import '../../contenus/presentation/lecteurs/lecteurs.dart';
import '../messagerie_providers.dart';

/// Conversation entre le coach et un accompagnement (les deux conjoints
/// voient la même conversation).
class ConversationScreen extends ConsumerWidget {
  const ConversationScreen({
    super.key,
    required this.accId,
    this.integree = false,
  });

  final String accId;

  /// Affichée directement dans l'onglet Messages (sans bouton retour).
  final bool integree;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(utilisateurFirebaseProvider).value?.uid;
    final coach = ref.watch(estCoachProvider);
    final acc = coach
        ? ref.watch(accompagnementProvider(accId)).value
        : ref.watch(monAccompagnementProvider).value;
    if (uid == null || acc == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return _Conversation(acc: acc, uid: uid, coach: coach, integree: integree);
  }
}

class _Conversation extends ConsumerStatefulWidget {
  const _Conversation({
    required this.acc,
    required this.uid,
    required this.coach,
    required this.integree,
  });

  final Accompagnement acc;
  final String uid;
  final bool coach;
  final bool integree;

  @override
  ConsumerState<_Conversation> createState() => _ConversationState();
}

class _ConversationState extends ConsumerState<_Conversation> {
  final _texte = TextEditingController();
  var _envoi = false;
  DateTime? _debutVocal;
  Timer? _chrono;

  Accompagnement get a => widget.acc;

  @override
  void initState() {
    super.initState();
    _marquerLu();
  }

  @override
  void didUpdateWidget(covariant _Conversation ancien) {
    super.didUpdateWidget(ancien);
    _marquerLu();
  }

  void _marquerLu() {
    final nonLus = widget.coach ? a.nonLusCoach : (a.nonLus[widget.uid] ?? 0);
    if (nonLus > 0) {
      ref
          .read(messagerieRepositoryProvider)
          .marquerLu(a.id, widget.uid, coach: widget.coach);
    }
  }

  @override
  void dispose() {
    _chrono?.cancel();
    _texte.dispose();
    super.dispose();
  }

  Future<void> _envoyer({String? photoUrl, String? audioUrl}) async {
    await ref
        .read(messagerieRepositoryProvider)
        .envoyer(
          accId: a.id,
          uid: widget.uid,
          parCoach: widget.coach,
          membres: a.membres,
          texte: photoUrl == null && audioUrl == null ? _texte.text : '',
          photoUrl: photoUrl,
          audioUrl: audioUrl,
        );
  }

  Future<void> _avecAttente(Future<void> Function() action) async {
    final l10n = AppLocalizations.of(context);
    final messager = ScaffoldMessenger.of(context);
    setState(() => _envoi = true);
    try {
      await action();
    } catch (_) {
      messager.showSnackBar(SnackBar(content: Text(l10n.envoiMessageEchoue)));
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  Future<void> _envoyerTexte() async {
    if (_texte.text.trim().isEmpty) return;
    await _avecAttente(() async {
      await _envoyer();
      _texte.clear();
    });
  }

  Future<void> _envoyerPhoto() async {
    final l10n = AppLocalizations.of(context);
    final camera = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.prendrePhoto),
              onTap: () => Navigator.pop(context, true),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.choisirGalerie),
              onTap: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
    );
    if (camera == null) return;
    final pj = ref.read(piecesJointesProvider);
    final octets = await pj.choisirPhoto(camera: camera);
    if (octets == null) return;
    await _avecAttente(
      () async => _envoyer(photoUrl: await pj.envoyerPhoto(a.id, octets)),
    );
  }

  Future<void> _basculerVocal() async {
    final l10n = AppLocalizations.of(context);
    final pj = ref.read(piecesJointesProvider);
    if (_debutVocal == null) {
      if (!await pj.demarrerVocal()) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.microRefuse)));
        }
        return;
      }
      setState(() => _debutVocal = DateTime.now());
      _chrono = Timer.periodic(
        const Duration(seconds: 1),
        (_) => setState(() {}),
      );
      return;
    }
    _chrono?.cancel();
    setState(() => _debutVocal = null);
    final chemin = await pj.arreterVocal();
    if (chemin == null) return;
    await _avecAttente(
      () async => _envoyer(audioUrl: await pj.envoyerVocal(a.id, chemin)),
    );
  }

  Future<void> _annulerVocal() async {
    _chrono?.cancel();
    setState(() => _debutVocal = null);
    await ref.read(piecesJointesProvider).annulerVocal();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final messages = ref.watch(messagesProvider(a.id)).value ?? const [];
    final langue = Localizations.localeOf(context).toLanguageTag();
    final heure = DateFormat.MMMd(langue).add_Hm();
    final enregistre = _debutVocal != null;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.integree,
        title: Text(widget.coach ? a.nom : l10n.votreCoach),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        l10n.aucunMessage,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (context, i) {
                      final m = messages[i];
                      final moi = m.auteur == widget.uid;
                      final deCoach = !a.membres.contains(m.auteur);
                      final couleurTexte = moi
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface;
                      // Pour le coach (et dans un couple), on nomme l'auteur.
                      final auteur = moi
                          ? null
                          : deCoach
                          ? l10n.votreCoach
                          : a.noms[m.auteur];
                      return Align(
                        alignment: moi
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.78,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: moi
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.surfaceContainerLowest,
                              border: moi
                                  ? null
                                  : Border.all(
                                      color: theme.colorScheme.outline,
                                    ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (auteur != null &&
                                    (widget.coach || a.membres.length > 1))
                                  Text(
                                    auteur,
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                          color: theme.colorScheme.primary,
                                        ),
                                  ),
                                if (m.photoUrl != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      m.photoUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, _, _) => const Icon(
                                        Icons.broken_image_outlined,
                                      ),
                                    ),
                                  ),
                                if (m.audioUrl != null)
                                  ref
                                      .read(fabriqueLecteursProvider)
                                      .vocal(
                                        url: m.audioUrl!,
                                        couleur: couleurTexte,
                                      ),
                                if (m.texte.isNotEmpty)
                                  SelectableText(
                                    m.texte,
                                    style: TextStyle(color: couleurTexte),
                                  ),
                                if (m.createdAt != null)
                                  Text(
                                    heure.format(m.createdAt!),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: couleurTexte.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (_envoi) const LinearProgressIndicator(),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 8, 8),
              child: enregistre
                  ? Row(
                      children: [
                        IconButton(
                          tooltip: l10n.annuler,
                          icon: const Icon(Icons.delete_outline),
                          onPressed: _annulerVocal,
                        ),
                        const Icon(
                          Icons.fiber_manual_record,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.enregistrementEnCours(
                              formatDuree(
                                DateTime.now().difference(_debutVocal!),
                              ),
                            ),
                          ),
                        ),
                        IconButton.filled(
                          tooltip: l10n.arreterEtEnvoyer,
                          icon: const Icon(Icons.send),
                          onPressed: _basculerVocal,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        IconButton(
                          tooltip: l10n.envoyerPhoto,
                          icon: const Icon(Icons.photo_outlined),
                          onPressed: _envoi ? null : _envoyerPhoto,
                        ),
                        IconButton(
                          tooltip: l10n.messageVocal,
                          icon: const Icon(Icons.mic_none),
                          onPressed: _envoi ? null : _basculerVocal,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _texte,
                            decoration: InputDecoration(
                              hintText: l10n.ecrireMessage,
                              isDense: true,
                            ),
                            minLines: 1,
                            maxLines: 5,
                            maxLength: 5000,
                            buildCounter: (
                              _, {
                              required currentLength,
                              required isFocused,
                              maxLength,
                            }) => null,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        const SizedBox(width: 4),
                        IconButton.filled(
                          tooltip: l10n.envoyerMessage,
                          icon: const Icon(Icons.send),
                          onPressed: _envoi ? null : _envoyerTexte,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
