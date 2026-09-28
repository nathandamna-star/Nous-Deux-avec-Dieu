// Contenus de départ (méditations, questions, parcours) : préparation des
// documents Firestore à partir de functions/depart/*.json. Fonction pure.

/**
 * Documents à créer : { chemin, donnees }. Tout est publié et public ; le
 * coach peut ensuite tout modifier, dépublier ou supprimer dans l'app.
 */
export function documentsDepart(contenus, parcours, horodatage) {
  const docs = contenus.map((c) => ({
    chemin: `contenus/${c.id}`,
    donnees: {
      type: c.type,
      theme: c.theme,
      titre: c.titre,
      texte: c.texte ?? {},
      reference: c.reference ?? '',
      visibilite: 'public',
      publie: true,
      ordre: c.ordre,
      createdAt: horodatage,
      updatedAt: horodatage,
    },
  }));
  for (const p of parcours) {
    docs.push({
      chemin: `parcours/${p.id}`,
      donnees: {
        titre: p.titre,
        description: p.description,
        etapes: p.etapes,
        visibilite: 'public',
        publie: true,
        ordre: p.ordre,
        createdAt: horodatage,
        updatedAt: horodatage,
      },
    });
  }
  return docs;
}
