import 'package:flutter/material.dart';

/// Palette provisoire (voir CLAUDE.md, section 3).
abstract final class AppColors {
  static const bordeaux = Color(0xFF7A2E3A);
  static const or = Color(0xFFC8963E);
  static const ivoire = Color(0xFFFBF6F1);
  static const carte = Color(0xFFFFFFFF);
  static const texte = Color(0xFF2A1F1D);
  static const texteSecondaire = Color(0xFF6B5E58);
  static const bordure = Color(0xFFE8DDD4);

  // Mode sombre (dérivé de la palette claire)
  static const sombreFond = Color(0xFF191413);
  static const sombreCarte = Color(0xFF241C1B);
  static const sombreTexte = Color(0xFFF3ECE6);
  static const sombreTexteSecondaire = Color(0xFFBBAEA7);
  static const sombreBordure = Color(0xFF3D3230);
  static const bordeauxClair = Color(0xFFE39AA6);
  static const orClair = Color(0xFFE2BE7A);
}
