// Rendez-vous : rappels et notifications (sans accès à Firebase : testable seul).

const HEURE = 60 * 60 * 1000;

const LOCALES = { fr: 'fr-FR', en: 'en-GB', pt: 'pt-PT', es: 'es-ES', nl: 'nl-NL' };

const TEXTES = {
  fr: {
    nouveau: 'Nouveau rendez-vous', deplace: 'Rendez-vous déplacé', annule: 'Rendez-vous annulé',
    veille: 'Rappel : votre séance', heure: 'Votre séance commence bientôt', zoom: 'sur Zoom',
  },
  en: {
    nouveau: 'New appointment', deplace: 'Appointment moved', annule: 'Appointment cancelled',
    veille: 'Reminder: your session', heure: 'Your session starts soon', zoom: 'on Zoom',
  },
  pt: {
    nouveau: 'Nova consulta', deplace: 'Consulta alterada', annule: 'Consulta cancelada',
    veille: 'Lembrete: a sua sessão', heure: 'A sua sessão começa em breve', zoom: 'no Zoom',
  },
  es: {
    nouveau: 'Nueva cita', deplace: 'Cita modificada', annule: 'Cita cancelada',
    veille: 'Recordatorio: tu sesión', heure: 'Tu sesión empieza pronto', zoom: 'en Zoom',
  },
  nl: {
    nouveau: 'Nieuwe afspraak', deplace: 'Afspraak verplaatst', annule: 'Afspraak geannuleerd',
    veille: 'Herinnering: je sessie', heure: 'Je sessie begint binnenkort', zoom: 'via Zoom',
  },
};

const textes = (langue) => TEXTES[langue] ?? TEXTES.fr;

/**
 * « lundi 12 octobre à 19:00 » dans la langue et à l'heure locale de la
 * personne ([decalageMin] : minutes par rapport à UTC ; absent = Bruxelles).
 */
export function formaterDate(date, langue, decalageMin) {
  const locale = LOCALES[langue] ?? LOCALES.fr;
  const options = {
    weekday: 'long', day: 'numeric', month: 'long', hour: '2-digit', minute: '2-digit',
  };
  if (typeof decalageMin === 'number') {
    const decale = new Date(date.getTime() + decalageMin * 60 * 1000);
    return new Intl.DateTimeFormat(locale, { ...options, timeZone: 'UTC' }).format(decale);
  }
  return new Intl.DateTimeFormat(locale, { ...options, timeZone: 'Europe/Brussels' }).format(date);
}

const millis = (d) => (d instanceof Date ? d.getTime() : d?.toMillis?.() ?? null);

/**
 * Ce qui a changé entre deux versions d'un rendez-vous : 'nouveau',
 * 'deplace', 'annule', ou null (rien à signaler, ex. rappel coché).
 */
export function changementRendezVous(avant, apres) {
  if (!apres) return null;
  if (!avant) return apres.statut === 'prevu' ? 'nouveau' : null;
  if (avant.statut !== 'annule' && apres.statut === 'annule') return 'annule';
  if (apres.statut === 'prevu' && avant.statut !== 'prevu') return 'nouveau';
  if (apres.statut === 'prevu' && millis(avant.debut) !== millis(apres.debut)) return 'deplace';
  return null;
}

/**
 * Rappels à envoyer maintenant pour un rendez-vous.
 * - veille : entre 24 h et 3 h avant (sinon le rappel d'1 h suffit) ;
 * - heure : dans la dernière heure.
 * Renvoie { envoyer: ['veille'|'heure'], marquer: { rappelVeille?, rappelHeure? } }.
 */
export function rappelsDus(rdv, maintenant) {
  const envoyer = [];
  const marquer = {};
  const debut = millis(rdv.debut);
  if (rdv.statut !== 'prevu' || debut == null) return { envoyer, marquer };
  const reste = debut - maintenant.getTime();
  if (reste <= 0) return { envoyer, marquer };
  if (!rdv.rappelVeille && reste <= 24 * HEURE) {
    if (reste > 3 * HEURE) envoyer.push('veille');
    marquer.rappelVeille = true;
  }
  if (!rdv.rappelHeure && reste <= HEURE) {
    envoyer.push('heure');
    marquer.rappelHeure = true;
  }
  return { envoyer, marquer };
}

/** Notification d'un rendez-vous ([type] : nouveau, deplace, annule, veille, heure). */
export function notificationRendezVous({
  type, accompagnementId, rendezVousId, rdv, langue, decalageMin,
}) {
  const t = textes(langue);
  const debut = new Date(millis(rdv.debut));
  const quand = formaterDate(debut, langue, decalageMin);
  return {
    notification: {
      title: t[type],
      body: type === 'annule' ? quand : `${quand} ${t.zoom}`,
    },
    data: { accompagnementId, rendezVousId },
  };
}
