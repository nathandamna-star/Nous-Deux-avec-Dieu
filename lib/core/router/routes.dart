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
  static String parcours(String id) => '/contenus/parcours/$id';
  static String etapeParcours(String parcours, String contenu) =>
      '/contenus/parcours/$parcours/etape/$contenu';
  static const parcoursCoach = '/coach/parcours';
  static const nouveauParcours = '/coach/parcours/nouveau';
  static String modifierParcours(String id) => '/coach/parcours/$id';
  static String contenuAccueil(String id) => '/accueil/contenu/$id';
  static const exercices = '/accueil/exercices';
  static String exercice(String id) => '/accueil/exercices/$id';
  static String envoiExercice(String acc) =>
      '/coach/accompagnement/$acc/exercice';
  static String exerciceCoach(String acc, String id) =>
      '/coach/accompagnement/$acc/exercice/$id';
  static String conversation(String acc) => '/messages/$acc';
  static const contenusCoach = '/coach/contenus';
  static const nouveauContenu = '/coach/contenus/nouveau';
  static String modifierContenu(String id) => '/coach/contenus/$id';
  static const agenda = '/coach/agenda';
  static String nouveauRendezVous(String acc) =>
      '/coach/accompagnement/$acc/rendezvous';
  static String modifierRendezVous(String acc, String id) =>
      '/coach/accompagnement/$acc/rendezvous/$id';
}
