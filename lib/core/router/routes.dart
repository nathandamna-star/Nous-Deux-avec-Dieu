abstract final class Routes {
  static const bienvenue = '/bienvenue';
  static const connexionEmail = '/bienvenue/email';
  static const accueil = '/accueil';
  static const contenus = '/contenus';
  static const messages = '/messages';
  static const seances = '/seances';
  static const profil = '/profil';
  static const coach = '/coach';
  static const demande = '/profil/demande';
  static const rejoindre = '/profil/rejoindre';
  static String ficheAccompagnement(String id) => '/coach/accompagnement/$id';
}
