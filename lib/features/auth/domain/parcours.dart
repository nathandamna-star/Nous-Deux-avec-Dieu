/// Ce que la personne vient chercher (choisi sur l'écran de bienvenue).
enum Parcours {
  couple,
  seul,
  decouverte;

  static Parcours depuis(String? v) =>
      values.firstWhere((p) => p.name == v, orElse: () => decouverte);
}
