// Commandes de livres : notifications (sans accès à Firebase : testable seul).
import { formaterMontant } from './paiements.js';

const TEXTES = {
  fr: { nouvelle: 'Commande de livre', payee: 'Paiement reçu', envoyee: 'Votre livre est en route !', payeeCorps: 'Votre livre sera envoyé très bientôt.', suivi: 'Suivi' },
  en: { nouvelle: 'Book order', payee: 'Payment received', envoyee: 'Your book is on its way!', payeeCorps: 'Your book will be sent very soon.', suivi: 'Tracking' },
  pt: { nouvelle: 'Encomenda de livro', payee: 'Pagamento recebido', envoyee: 'O seu livro está a caminho!', payeeCorps: 'O seu livro será enviado muito em breve.', suivi: 'Seguimento' },
  es: { nouvelle: 'Pedido de libro', payee: 'Pago recibido', envoyee: '¡Tu libro está en camino!', payeeCorps: 'Tu libro se enviará muy pronto.', suivi: 'Seguimiento' },
  nl: { nouvelle: 'Boekbestelling', payee: 'Betaling ontvangen', envoyee: 'Je boek is onderweg!', payeeCorps: 'Je boek wordt zeer binnenkort verzonden.', suivi: 'Tracking' },
};

const textes = (langue) => TEXTES[langue] ?? TEXTES.fr;

/** Nouvelle commande : pour le coach. */
export function notificationNouvelleCommande({ commandeId, commande, langue }) {
  const t = textes(langue);
  return {
    notification: {
      title: t.nouvelle,
      body: `${commande.nom ?? ''} · ${commande.quantite ?? 1} × ${commande.livreTitre ?? ''} · ${formaterMontant(commande.montant ?? 0, langue)}`,
    },
    data: { commandeLivreId: commandeId },
  };
}

/** Changement de statut à signaler au client ('payee' ou 'envoyee'), sinon null. */
export function changementCommande(avant, apres) {
  if (!apres || avant?.statut === apres.statut) return null;
  return ['payee', 'envoyee'].includes(apres.statut) ? apres.statut : null;
}

export function notificationSuiviCommande({ commandeId, commande, statut, langue }) {
  const t = textes(langue);
  const corps = statut === 'payee'
    ? t.payeeCorps
    : [commande.livreTitre, commande.numeroSuivi ? `${t.suivi} : ${commande.numeroSuivi}` : '']
      .filter(Boolean).join(' · ');
  return {
    notification: { title: statut === 'payee' ? t.payee : t.envoyee, body: corps },
    data: { commandeLivreId: commandeId },
  };
}
