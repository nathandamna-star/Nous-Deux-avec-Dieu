import 'package:flutter/material.dart';

/// Photo de profil ronde, ou initiales si la personne n'en a pas.
class Avatar extends StatelessWidget {
  const Avatar({super.key, this.photoUrl, required this.nom, this.rayon = 24});

  final String? photoUrl;
  final String nom;
  final double rayon;

  static String initiales(String nom) {
    final mots = nom.trim().split(RegExp(r'\s+')).where((m) => m.isNotEmpty);
    return mots.take(2).map((m) => m.characters.first.toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    final couleurs = Theme.of(context).colorScheme;
    final url = photoUrl;
    return CircleAvatar(
      radius: rayon,
      backgroundColor: couleurs.primary.withValues(alpha: 0.15),
      foregroundImage: url == null || url.isEmpty ? null : NetworkImage(url),
      // Photo indisponible (réseau) : on garde les initiales.
      onForegroundImageError: url == null || url.isEmpty ? null : (_, _) {},
      child: Text(
        initiales(nom),
        style: TextStyle(
          color: couleurs.primary,
          fontWeight: FontWeight.w700,
          fontSize: rayon * 0.7,
        ),
      ),
    );
  }
}
