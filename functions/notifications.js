// Construction des notifications push (sans accès à Firebase : testable seul).

const TEXTES = {
  fr: { coach: 'Votre coach', photo: '📷 Photo', vocal: '🎤 Message vocal', exercice: 'Nouvel exercice' },
  en: { coach: 'Your coach', photo: '📷 Photo', vocal: '🎤 Voice message', exercice: 'New exercise' },
  pt: { coach: 'O seu coach', photo: '📷 Foto', vocal: '🎤 Mensagem de voz', exercice: 'Novo exercício' },
  es: { coach: 'Tu coach', photo: '📷 Foto', vocal: '🎤 Mensaje de voz', exercice: 'Nuevo ejercicio' },
  nl: { coach: 'Je coach', photo: '📷 Foto', vocal: '🎤 Spraakbericht', exercice: 'Nieuwe oefening' },
};

const textes = (langue) => TEXTES[langue] ?? TEXTES.fr;

/**
 * Destinataires d'un nouveau message : le coach si un membre écrit ; les
 * membres (sauf l'auteur) si le coach écrit.
 */
export function destinatairesMessage({ accompagnement, message, coachUid }) {
  const membres = accompagnement?.membres ?? [];
  if (!message?.auteur) return [];
  if (membres.includes(message.auteur)) return coachUid ? [coachUid] : [];
  return membres.filter((uid) => uid !== message.auteur);
}

/** Notification d'un message, pour un destinataire dans sa langue. */
export function notificationMessage({ accompagnementId, accompagnement, message, pourCoach, langue }) {
  const t = textes(langue);
  const texte = (message.texte ?? '').trim();
  const corps = texte
    ? (texte.length > 150 ? `${texte.slice(0, 150)}…` : texte)
    : message.audioUrl ? t.vocal : t.photo;
  const auteur = pourCoach
    ? (accompagnement.noms?.[message.auteur] || accompagnement.nom || '')
    : t.coach;
  return {
    notification: { title: auteur, body: corps },
    data: { accompagnementId },
  };
}

/** Notification d'un nouvel exercice envoyé par le coach. */
export function notificationExercice({ exerciceId, exercice, langue }) {
  const t = textes(langue);
  return {
    notification: { title: t.exercice, body: exercice.titre ?? '' },
    data: { exerciceId },
  };
}

/** Jetons à retirer après un envoi (téléphone désinstallé, jeton expiré). */
export function jetonsInvalides(jetons, reponses) {
  const codes = new Set([
    'messaging/registration-token-not-registered',
    'messaging/invalid-registration-token',
    'messaging/invalid-argument',
  ]);
  return jetons.filter((_, i) => !reponses[i]?.success && codes.has(reponses[i]?.error?.code));
}
