// Paiements par virement : notifications (sans accès à Firebase : testable seul).

const LOCALES = { fr: 'fr-BE', en: 'en-GB', pt: 'pt-PT', es: 'es-ES', nl: 'nl-BE' };

const TEXTES = {
  fr: {
    forfait: 'Paiement reçu', don: 'Merci pour votre don !',
    seances: (n) => (n > 1 ? `${n} séances ajoutées à votre accompagnement.` : '1 séance ajoutée à votre accompagnement.'),
    merci: 'Votre don a bien été reçu. Que Dieu vous bénisse.',
    annonce: 'Virement annoncé', annonceDon: 'Don annoncé',
  },
  en: {
    forfait: 'Payment received', don: 'Thank you for your gift!',
    seances: (n) => (n > 1 ? `${n} sessions added to your coaching.` : '1 session added to your coaching.'),
    merci: 'Your gift has been received. God bless you.',
    annonce: 'Transfer announced', annonceDon: 'Gift announced',
  },
  pt: {
    forfait: 'Pagamento recebido', don: 'Obrigado pelo seu donativo!',
    seances: (n) => (n > 1 ? `${n} sessões adicionadas ao seu acompanhamento.` : '1 sessão adicionada ao seu acompanhamento.'),
    merci: 'O seu donativo foi recebido. Que Deus o abençoe.',
    annonce: 'Transferência anunciada', annonceDon: 'Donativo anunciado',
  },
  es: {
    forfait: 'Pago recibido', don: '¡Gracias por tu donativo!',
    seances: (n) => (n > 1 ? `${n} sesiones añadidas a tu acompañamiento.` : '1 sesión añadida a tu acompañamiento.'),
    merci: 'Hemos recibido tu donativo. Que Dios te bendiga.',
    annonce: 'Transferencia anunciada', annonceDon: 'Donativo anunciado',
  },
  nl: {
    forfait: 'Betaling ontvangen', don: 'Bedankt voor je gift!',
    seances: (n) => (n > 1 ? `${n} sessies toegevoegd aan je begeleiding.` : '1 sessie toegevoegd aan je begeleiding.'),
    merci: 'Je gift is goed ontvangen. God zegene je.',
    annonce: 'Overschrijving aangekondigd', annonceDon: 'Gift aangekondigd',
  },
};

const textes = (langue) => TEXTES[langue] ?? TEXTES.fr;

export function formaterMontant(montant, langue) {
  return new Intl.NumberFormat(LOCALES[langue] ?? LOCALES.fr, {
    style: 'currency', currency: 'EUR',
  }).format(montant);
}

/** Vrai quand le coach vient de confirmer la réception. */
export function vientDEtreRecu(avant, apres) {
  return avant?.statut !== 'recu' && apres?.statut === 'recu';
}

/** Séances à créditer pour un paiement confirmé (0 pour un don ou déjà fait). */
export function seancesACrediter(paiement) {
  if (paiement?.type !== 'forfait' || paiement.seancesCreditees) return 0;
  if (!paiement.accompagnementId) return 0;
  const n = Number(paiement.nbSeances ?? 0);
  return Number.isInteger(n) && n > 0 ? n : 0;
}

/** Notification à la personne quand le coach a confirmé son virement. */
export function notificationPaiementRecu({ paiementId, paiement, langue }) {
  const t = textes(langue);
  const don = paiement.type === 'don';
  return {
    notification: {
      title: don ? t.don : t.forfait,
      body: don ? t.merci : t.seances(Number(paiement.nbSeances ?? 0)),
    },
    data: { paiementId },
  };
}

/** Notification au coach quand un virement est annoncé. */
export function notificationPaiementAnnonce({ paiementId, paiement, langue }) {
  const t = textes(langue);
  const quoi = paiement.type === 'don' ? t.annonceDon : t.annonce;
  const detail = paiement.forfaitNom ? ` · ${paiement.forfaitNom}` : '';
  return {
    notification: {
      title: quoi,
      body: `${paiement.nom ?? ''} · ${formaterMontant(paiement.montant, langue)}${detail}`,
    },
    data: { paiementId },
  };
}
