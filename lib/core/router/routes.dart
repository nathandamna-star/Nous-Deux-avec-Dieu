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
  static String paiementSeances(String id) => '/seances/paiement/$id';
  static const don = '/profil/don';
  static String paiementProfil(String id) => '/profil/paiement/$id';
  static const paiementsCoach = '/coach/paiements';
  static const forfaitsCoach = '/coach/forfaits';
  static const nouveauForfait = '/coach/forfaits/nouveau';
  static String modifierForfait(String id) => '/coach/forfaits/$id';
  static const parametresCoach = '/coach/parametres';
  static const livresAccueil = '/accueil/livres';
  static const livresContenus = '/contenus/livres';
  static String commandeLivre(String id) => '/accueil/livres/commande/$id';
  static const livresCoach = '/coach/livres';
  static const nouveauLivre = '/coach/livres/nouveau';
  static String modifierLivre(String id) => '/coach/livres/$id';
}
