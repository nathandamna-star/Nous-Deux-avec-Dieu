import assert from 'node:assert/strict';
import { describe, it } from 'node:test';
import {
  destinatairesMessage, jetonsInvalides, notificationExercice, notificationMessage,
} from '../notifications.js';

const acc = { nom: 'Paul & Marie', membres: ['marie', 'paul'], noms: { marie: 'Marie', paul: 'Paul' } };

describe('notifications', () => {
  it('destinataires : le coach si un membre écrit, les membres si le coach écrit', () => {
    assert.deepEqual(destinatairesMessage({ accompagnement: acc, message: { auteur: 'marie' }, coachUid: 'c' }), ['c']);
    assert.deepEqual(destinatairesMessage({ accompagnement: acc, message: { auteur: 'c' }, coachUid: 'c' }), ['marie', 'paul']);
    assert.deepEqual(destinatairesMessage({ accompagnement: acc, message: { auteur: 'marie' }, coachUid: null }), []);
  });

  it('message : nom de l\'auteur pour le coach, « Votre coach » pour les membres, langue', () => {
    const pourCoach = notificationMessage({
      accompagnementId: 'a1', accompagnement: acc, message: { auteur: 'paul', texte: 'Merci !' }, pourCoach: true, langue: 'fr',
    });
    assert.equal(pourCoach.notification.title, 'Paul');
    assert.equal(pourCoach.notification.body, 'Merci !');
    assert.deepEqual(pourCoach.data, { accompagnementId: 'a1' });
    const pourMembre = notificationMessage({
      accompagnementId: 'a1', accompagnement: acc, message: { auteur: 'c', texte: '', audioUrl: 'x' }, pourCoach: false, langue: 'nl',
    });
    assert.equal(pourMembre.notification.title, 'Je coach');
    assert.equal(pourMembre.notification.body, '🎤 Spraakbericht');
  });

  it('exercice et jetons invalides', () => {
    const n = notificationExercice({ exerciceId: 'e1', exercice: { titre: 'Trois qualités' }, langue: 'es' });
    assert.equal(n.notification.title, 'Nuevo ejercicio');
    assert.deepEqual(n.data, { exerciceId: 'e1' });
    assert.deepEqual(jetonsInvalides(['a', 'b'], [
      { success: true }, { success: false, error: { code: 'messaging/registration-token-not-registered' } },
    ]), ['b']);
  });
});
