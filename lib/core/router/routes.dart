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
  static String contenu(String id) => '/contenus/$id';
  static String contenuAccueil(String id) => '/accueil/contenu/$id';
  static const exercices = '/accueil/exercices';
  static String exercice(String id) => '/accueil/exercices/$id';
  static String envoiExercice(String acc) =>
      '/coach/accompagnement/$acc/exercice';
  static String exerciceCoach(String acc, String id) =>
      '/coach/accompagnement/$acc/exercice/$id';
  static const contenusCoach = '/coach/contenus';
  static const nouveauContenu = '/coach/contenus/nouveau';
  static String modifierContenu(String id) => '/coach/contenus/$id';
}
