import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import {
  changementRendezVous, formaterDate, notificationRendezVous, rappelsDus,
} from '../rendezvous.js';

const H = 60 * 60 * 1000;
const maintenant = new Date('2030-01-10T08:00:00Z');
const dans = (heures) => new Date(maintenant.getTime() + heures * H);
const rdv = (extra = {}) => ({
  statut: 'prevu', debut: dans(10), rappelVeille: false, rappelHeure: false, ...extra,
});

describe('rendez-vous', () => {
  it('date locale dans la langue de la personne', () => {
    const d = new Date('2030-01-14T18:00:00Z'); // lundi
    assert.match(formaterDate(d, 'fr', 60), /lundi 14 janvier.*19:00/);
    assert.match(formaterDate(d, 'nl', 0), /maandag 14 januari.*18:00/);
    assert.match(formaterDate(d, 'fr'), /19:00/); // Bruxelles par défaut
  });

  it('changements signalés', () => {
    assert.equal(changementRendezVous(null, rdv()), 'nouveau');
    assert.equal(changementRendezVous(rdv(), rdv({ statut: 'annule' })), 'annule');
    assert.equal(changementRendezVous(rdv(), rdv({ debut: dans(20) })), 'deplace');
    assert.equal(changementRendezVous(rdv(), rdv({ rappelVeille: true })), null);
    assert.equal(changementRendezVous(rdv(), rdv({ statut: 'fait' })), null);
    assert.equal(changementRendezVous(rdv(), null), null);
  });

  it('rappel de la veille entre 24 h et 3 h avant', () => {
    assert.deepEqual(rappelsDus(rdv({ debut: dans(30) }), maintenant).envoyer, []);
    assert.deepEqual(rappelsDus(rdv({ debut: dans(20) }), maintenant),
      { envoyer: ['veille'], marquer: { rappelVeille: true } });
    assert.deepEqual(rappelsDus(rdv({ debut: dans(20), rappelVeille: true }), maintenant).envoyer, []);
    // Rendez-vous pris 2 h avant : pas de rappel « veille », seulement marqué.
    assert.deepEqual(rappelsDus(rdv({ debut: dans(2) }), maintenant),
      { envoyer: [], marquer: { rappelVeille: true } });
  });

  it('rappel 1 h avant, une seule fois ; rien si annulé ou passé', () => {
    assert.deepEqual(rappelsDus(rdv({ debut: dans(0.75), rappelVeille: true }), maintenant),
      { envoyer: ['heure'], marquer: { rappelHeure: true } });
    assert.deepEqual(rappelsDus(rdv({ debut: dans(0.5), rappelVeille: true, rappelHeure: true }), maintenant).envoyer, []);
    assert.deepEqual(rappelsDus(rdv({ debut: dans(0.5), statut: 'annule' }), maintenant).envoyer, []);
    assert.deepEqual(rappelsDus(rdv({ debut: dans(-1) }), maintenant).envoyer, []);
  });

  it('notification : titre traduit, date et données', () => {
    const n = notificationRendezVous({
      type: 'heure', accompagnementId: 'a1', rendezVousId: 'r1',
      rdv: rdv({ debut: new Date('2030-01-14T18:00:00Z') }), langue: 'es', decalageMin: 60,
    });
    assert.equal(n.notification.title, 'Tu sesión empieza pronto');
    assert.match(n.notification.body, /19:00 en Zoom$/);
    assert.deepEqual(n.data, { accompagnementId: 'a1', rendezVousId: 'r1' });
  });
});
