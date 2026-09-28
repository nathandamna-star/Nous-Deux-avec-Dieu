// Export et suppression du compte (RGPD) : fonctions pures, testables seules.

/** Rend un document Firestore lisible en JSON (dates en ISO, références en chemin). */
export function versJson(valeur) {
  if (valeur === null || valeur === undefined) return null;
  if (typeof valeur?.toDate === 'function') return valeur.toDate().toISOString();
  if (valeur instanceof Date) return valeur.toISOString();
  if (typeof valeur?.path === 'string' && typeof valeur?.id === 'string') return valeur.path;
  if (typeof valeur?.latitude === 'number' && typeof valeur?.longitude === 'number') {
    return { latitude: valeur.latitude, longitude: valeur.longitude };
  }
  if (Array.isArray(valeur)) return valeur.map(versJson);
  if (typeof valeur === 'object') {
    return Object.fromEntries(Object.entries(valeur).map(([k, v]) => [k, versJson(v)]));
  }
  return valeur;
}

/** Profil exporté : sans les jetons techniques de notification. */
export function profilExporte(profil) {
  if (!profil) return null;
  const { jetonsNotif: _jetons, ...reste } = profil;
  return versJson(reste);
}

/**
 * Ce que devient l'accompagnement quand un membre supprime son compte :
 * - seul membre : tout est supprimé ;
 * - couple : le membre est retiré, le conjoint garde l'accompagnement.
 */
export function departMembre(accompagnement, uid) {
  const membres = (accompagnement.membres ?? []).filter((m) => m !== uid);
  if (membres.length === 0) return { supprimer: true };
  const noms = { ...(accompagnement.noms ?? {}) };
  delete noms[uid];
  const nonLus = { ...(accompagnement.nonLus ?? {}) };
  delete nonLus[uid];
  return { supprimer: false, maj: { membres, noms, nonLus } };
}

/** Une commande de livre payée mais pas encore envoyée empêche la suppression. */
export function commandeEnCours(commandes) {
  return commandes.some((c) => c.statut === 'payee');
}

export const ANONYME = 'compte-supprime';
