// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Nous deux avec Dieu';

  @override
  String get slogan => 'Crecer juntos, con Dios en el centro.';

  @override
  String get navAccueil => 'Inicio';

  @override
  String get navContenus => 'Contenidos';

  @override
  String get navMessages => 'Mensajes';

  @override
  String get navSeances => 'Sesiones';

  @override
  String get navProfil => 'Perfil';

  @override
  String get navCoach => 'Coach';

  @override
  String get bientot => 'Próximamente';

  @override
  String get seancesAVenir =>
      'Aquí: tus citas, las sesiones restantes y los paquetes.';

  @override
  String get profilAVenir =>
      'Aquí: tu idioma, tu cónyuge, los donativos y tus datos.';

  @override
  String get bienvenueQuestion => '¿Qué te trae por aquí?';

  @override
  String get parcoursCouple => 'Venimos en pareja';

  @override
  String get parcoursCoupleAide => 'Casados, prometidos o en pareja';

  @override
  String get parcoursSeul => 'Vengo solo/a';

  @override
  String get parcoursSeulAide =>
      'Para crecer personalmente o preparar el futuro';

  @override
  String get parcoursDecouverte => 'Estoy descubriendo';

  @override
  String get parcoursDecouverteAide =>
      'Meditaciones, preguntas para dos, audios y vídeos';

  @override
  String get continuerEmail => 'Continuar con correo';

  @override
  String get explorerSansCompte => 'Explorar sin cuenta';

  @override
  String get seConnecter => 'Iniciar sesión';

  @override
  String get creerCompte => 'Crear una cuenta';

  @override
  String get seDeconnecter => 'Cerrar sesión';

  @override
  String get champNom => 'Nombre y apellidos';

  @override
  String get champEmail => 'Correo electrónico';

  @override
  String get champMotDePasse => 'Contraseña';

  @override
  String get afficherMotDePasse => 'Mostrar contraseña';

  @override
  String get masquerMotDePasse => 'Ocultar contraseña';

  @override
  String get motDePasseOublie => '¿Has olvidado tu contraseña?';

  @override
  String emailReinitialisationEnvoye(String email) {
    return 'Hemos enviado a $email un correo para elegir una nueva contraseña.';
  }

  @override
  String get validationNomRequis => 'Indica tu nombre.';

  @override
  String get validationEmail => 'Indica un correo válido.';

  @override
  String get validationMotDePasse => 'Al menos 8 caracteres.';

  @override
  String get consentementTexte =>
      'Acepto que mis respuestas y mensajes, que pueden referirse a mi fe y a mi vida en pareja, se guarden en Europa y solo los vea mi coach, para acompañarme. Puedo retirar mi consentimiento y eliminar mi cuenta en cualquier momento.';

  @override
  String get consentementRequis => 'Marca la casilla para crear tu cuenta.';

  @override
  String get chargement => 'Cargando…';

  @override
  String get erreurEmailInvalide => 'Este correo no es válido.';

  @override
  String get erreurMotDePasseFaible =>
      'Esta contraseña es demasiado débil. Usa al menos 8 caracteres.';

  @override
  String get erreurEmailDejaUtilise =>
      'Ya existe una cuenta con este correo. Inicia sesión.';

  @override
  String get erreurIdentifiantsIncorrects => 'Correo o contraseña incorrectos.';

  @override
  String get erreurTropDeTentatives =>
      'Demasiados intentos. Vuelve a intentarlo en unos minutos.';

  @override
  String get erreurReseau =>
      'Sin conexión a internet. Comprueba tu red y vuelve a intentarlo.';

  @override
  String get erreurInconnue => 'Se ha producido un error. Inténtalo de nuevo.';

  @override
  String get connexionRequiseTitre => 'Un espacio solo para ti';

  @override
  String get connexionRequiseTexte =>
      'Inicia sesión para hablar con tu coach, seguir tus sesiones y gestionar tu perfil.';

  @override
  String bonjourNom(String nom) {
    return 'Hola $nom';
  }

  @override
  String get roleCoach => 'Coach';

  @override
  String get monAccompagnement => 'Mi acompañamiento';

  @override
  String get demanderAccompagnement => 'Solicitar acompañamiento';

  @override
  String get demanderAccompagnementAide =>
      'Tu coach te responderá para acordar una primera cita.';

  @override
  String get jAiUnCode => 'Tengo un código de mi cónyuge';

  @override
  String get typeCouple => 'En pareja';

  @override
  String get typeIndividuel => 'Solo/a';

  @override
  String get champNomAccompagnement => 'Nombre visible';

  @override
  String get champNomAccompagnementAide => 'Por ejemplo «Pablo y María»';

  @override
  String get champMessage => 'Tu mensaje al coach (opcional)';

  @override
  String get champMessageAide => 'Lo que estáis viviendo, lo que esperáis…';

  @override
  String get envoyerDemande => 'Enviar mi solicitud';

  @override
  String get demandeEnvoyee =>
      'Solicitud enviada. Tu coach te responderá pronto.';

  @override
  String get champObligatoire => 'Este campo es obligatorio.';

  @override
  String get rejoindreTitre => 'Unirme a mi cónyuge';

  @override
  String get rejoindreAide =>
      'Introduce el código de 6 caracteres que tu cónyuge ve en su perfil.';

  @override
  String get champCode => 'Código de invitación';

  @override
  String get rejoindre => 'Unirme';

  @override
  String get codeInvalide =>
      'Este código no es válido o la pareja ya está completa.';

  @override
  String codePourConjoint(String code) {
    return 'Código para tu cónyuge: $code';
  }

  @override
  String get codePourConjointAide =>
      'Tu cónyuge crea su cuenta y elige «Tengo un código de mi cónyuge».';

  @override
  String get copier => 'Copiar';

  @override
  String get copie => 'Copiado';

  @override
  String get statutDemande => 'Solicitud pendiente';

  @override
  String get statutActif => 'Acompañamiento en curso';

  @override
  String get statutEnPause => 'En pausa';

  @override
  String get statutTermine => 'Terminado';

  @override
  String seancesRestantes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sesiones restantes',
      one: '1 sesión restante',
      zero: 'Ninguna sesión restante',
    );
    return '$_temp0';
  }

  @override
  String get attendConjoint => 'Esperando al cónyuge';

  @override
  String get filtreDemandes => 'Solicitudes';

  @override
  String get filtreActifs => 'En curso';

  @override
  String get filtreTermines => 'Terminados';

  @override
  String get aucunAccompagnement => 'Aún no hay acompañamientos aquí.';

  @override
  String get membres => 'Miembros';

  @override
  String get messageDemande => 'Mensaje de la solicitud';

  @override
  String get accepter => 'Aceptar';

  @override
  String get mettreEnPause => 'Pausar';

  @override
  String get reprendre => 'Reanudar';

  @override
  String get terminer => 'Terminar';

  @override
  String get seances => 'Sesiones';

  @override
  String get retirerSeance => 'Quitar una sesión';

  @override
  String get ajouterSeance => 'Añadir una sesión';

  @override
  String get notesPrivees => 'Notas privadas';

  @override
  String get notesPriveesAide => 'Solo tú las ves.';

  @override
  String get nouvelleNote => 'Nueva nota';

  @override
  String get ajouter => 'Añadir';

  @override
  String get supprimer => 'Eliminar';

  @override
  String get aucuneNote => 'Aún no hay notas.';

  @override
  String get activerCoachTitre => '¿Activar el espacio del coach?';

  @override
  String get activerCoachTexte =>
      'Reservado al coach: solo la cuenta designada en la puesta en marcha puede activarlo.';

  @override
  String get coachActive => 'Espacio del coach activado.';

  @override
  String get coachRefuse => 'Esta cuenta no puede ser coach.';

  @override
  String get annuler => 'Cancelar';

  @override
  String get valider => 'Confirmar';

  @override
  String get typeMeditation => 'Meditación';

  @override
  String get typeQuestion => 'Pregunta para dos';

  @override
  String get typeExercice => 'Ejercicio';

  @override
  String get typeArticle => 'Artículo';

  @override
  String get tous => 'Todos';

  @override
  String get themeCommunication => 'Comunicación';

  @override
  String get themePardon => 'Perdón';

  @override
  String get themeFinances => 'Finanzas';

  @override
  String get themeIntimite => 'Intimidad';

  @override
  String get themePriere => 'Oración';

  @override
  String get themeEnfants => 'Hijos';

  @override
  String get themeFiancailles => 'Noviazgo';

  @override
  String get themeGratitude => 'Gratitud';

  @override
  String get meditationDuJour => 'Meditación del día';

  @override
  String get lire => 'Leer';

  @override
  String get decouvrirContenus => 'Descubrir todos los contenidos';

  @override
  String get aucunContenu => 'Aún no hay contenidos. ¡Vuelve pronto!';

  @override
  String get autreLangue => 'Aún no traducido a tu idioma.';

  @override
  String get accueilBienvenue =>
      'Que la paz de Dios guarde vuestros corazones.';

  @override
  String get mesContenus => 'Mis contenidos';

  @override
  String get nouveauContenu => 'Nuevo contenido';

  @override
  String get modifierContenu => 'Editar contenido';

  @override
  String get brouillon => 'Borrador';

  @override
  String get publie => 'Publicado';

  @override
  String get champType => 'Tipo';

  @override
  String get champTheme => 'Tema';

  @override
  String get champTitre => 'Título';

  @override
  String get champTexte => 'Texto';

  @override
  String get champReference => 'Referencia bíblica (opcional)';

  @override
  String get champReferenceAide => 'Ej. Efesios 4:2';

  @override
  String get langueVersion => 'Versión';

  @override
  String get titreFrancaisRequis => 'El título en francés es obligatorio.';

  @override
  String get visiblePourTous => 'Visible sin cuenta';

  @override
  String get visiblePourTousAide =>
      'Si no, solo para personas con sesión iniciada.';

  @override
  String get publier => 'Publicar';

  @override
  String get publierAide => 'Desactivado: borrador, solo tú lo ves.';

  @override
  String get champOrdre => 'Orden de aparición';

  @override
  String get champOrdreAide =>
      'Las meditaciones del día siguen este orden (1, 2, 3…).';

  @override
  String get enregistrer => 'Guardar';

  @override
  String get enregistre => 'Guardado';

  @override
  String get supprimerContenuTitre => '¿Eliminar este contenido?';

  @override
  String get supprimerContenuTexte => 'Desaparecerá para todos. Es definitivo.';

  @override
  String get typeAudio => 'Audio';

  @override
  String get typeVideo => 'Vídeo';

  @override
  String get lecture => 'Reproducir';

  @override
  String get pause => 'Pausa';

  @override
  String get reculer15 => 'Retroceder 15 segundos';

  @override
  String get avancer15 => 'Avanzar 15 segundos';

  @override
  String get vitesse => 'Velocidad';

  @override
  String get pleinEcran => 'Pantalla completa';

  @override
  String get erreurLecture =>
      'No se puede reproducir este archivo. Comprueba tu conexión.';

  @override
  String fichierMedia(String langue) {
    return 'Archivo ($langue)';
  }

  @override
  String get choisirFichier => 'Elegir el archivo';

  @override
  String get remplacerFichier => 'Reemplazar';

  @override
  String get fichierAjoute => 'Archivo añadido';

  @override
  String get aucunFichier => 'Ningún archivo en este idioma.';

  @override
  String envoiEnCours(int pourcent) {
    return 'Enviando… $pourcent %';
  }

  @override
  String get fichierRequis => 'Añade al menos un archivo.';

  @override
  String get envoiEchoue => 'El envío ha fallado. Inténtalo de nuevo.';

  @override
  String get champDescription => 'Descripción';

  @override
  String get changerPhoto => 'Cambiar la foto de perfil';

  @override
  String get prendrePhoto => 'Hacer una foto';

  @override
  String get choisirGalerie => 'Elegir de la galería';

  @override
  String get supprimerPhoto => 'Eliminar la foto';

  @override
  String get photoEnvoiEchoue =>
      'No se ha podido guardar la foto. Inténtalo de nuevo.';

  @override
  String get mesExercices => 'Mis ejercicios';

  @override
  String exercicesAFaire(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ejercicios pendientes',
      one: '1 ejercicio pendiente',
      zero: 'Ningún ejercicio pendiente',
    );
    return '$_temp0';
  }

  @override
  String get aucunExercice => 'Tu coach aún no te ha enviado ejercicios.';

  @override
  String get exerciceFait => 'Hecho';

  @override
  String get exerciceAFaire => 'Pendiente';

  @override
  String get modeSeul => 'Cada uno por su lado';

  @override
  String get modeADeux => 'Para hacer juntos';

  @override
  String get modeSeulAide => 'Tu respuesta solo la ves tú y tu coach.';

  @override
  String get modeADeuxAide =>
      'Una respuesta común, escrita juntos, visible para los dos y vuestro coach.';

  @override
  String aFaireAvant(String date) {
    return 'Para antes del $date';
  }

  @override
  String get lireAvant => 'Leer antes';

  @override
  String get maReponse => 'Mi respuesta';

  @override
  String get notreReponse => 'Nuestra respuesta';

  @override
  String get enregistrerReponse => 'Guardar mi respuesta';

  @override
  String get reponseEnregistree => 'Respuesta guardada. Tu coach podrá leerla.';

  @override
  String get exercices => 'Ejercicios';

  @override
  String get envoyerExercice => 'Enviar un ejercicio';

  @override
  String get apartirContenu => 'A partir de un contenido (opcional)';

  @override
  String get aucunContenuLie => 'Ninguno';

  @override
  String get champConsignes => 'Instrucciones';

  @override
  String get echeance => 'Fecha límite (opcional)';

  @override
  String get choisirDate => 'Elegir una fecha';

  @override
  String get envoyer => 'Enviar';

  @override
  String get exerciceEnvoye => 'Ejercicio enviado.';

  @override
  String reponses(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n respuestas',
      one: '1 respuesta',
      zero: 'Ninguna respuesta',
    );
    return '$_temp0';
  }

  @override
  String get pasEncoreRepondu => 'Aún no ha respondido.';

  @override
  String get reponseCommune => 'Respuesta común';

  @override
  String get supprimerExerciceTitre => '¿Eliminar este ejercicio?';

  @override
  String get parcours => 'Itinerarios';

  @override
  String get aucunParcours => 'Aún no hay itinerarios.';

  @override
  String etapesFaites(int faits, int total) {
    return '$faits / $total etapas';
  }

  @override
  String etapeNumero(int n) {
    return 'Etapa $n';
  }

  @override
  String get continuerParcours => 'Continuar';

  @override
  String get commencerParcours => 'Empezar';

  @override
  String get parcoursTermine => 'Itinerario terminado. ¡Enhorabuena!';

  @override
  String get marquerFait => 'Marcar como hecho';

  @override
  String get etapeFaite => 'Etapa hecha';

  @override
  String get connexionPourSuivre => 'Inicia sesión para seguir tu progreso.';

  @override
  String get mesParcours => 'Mis itinerarios';

  @override
  String get nouveauParcours => 'Nuevo itinerario';

  @override
  String get modifierParcours => 'Editar itinerario';

  @override
  String get etapes => 'Etapas';

  @override
  String get ajouterEtape => 'Añadir una etapa';

  @override
  String get retirerEtape => 'Quitar la etapa';

  @override
  String get etapesRequises => 'Añade al menos una etapa.';

  @override
  String get choisirContenuEtape => 'Elegir un contenido';

  @override
  String get supprimerParcoursTitre => '¿Eliminar este itinerario?';

  @override
  String nbEtapes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n etapas',
      one: '1 etapa',
    );
    return '$_temp0';
  }

  @override
  String get votreCoach => 'Tu coach';

  @override
  String get messagesSansAccompagnement =>
      'Para escribir a tu coach, solicita primero un acompañamiento desde tu perfil.';

  @override
  String get aucunMessage => 'Aún no hay mensajes. ¡Escribe el primero!';

  @override
  String get aucuneConversation => 'Aún no hay conversaciones.';

  @override
  String get ecrireMessage => 'Escribir un mensaje';

  @override
  String get envoyerMessage => 'Enviar';

  @override
  String get envoyerPhoto => 'Enviar una foto';

  @override
  String get messageVocal => 'Mensaje de voz';

  @override
  String enregistrementEnCours(String duree) {
    return 'Grabando… $duree';
  }

  @override
  String get arreterEtEnvoyer => 'Detener y enviar';

  @override
  String get microRefuse =>
      'El acceso al micrófono está denegado. Permítelo en los Ajustes del teléfono.';

  @override
  String get envoiMessageEchoue =>
      'No se ha podido enviar el mensaje. Inténtalo de nuevo.';

  @override
  String nonLus(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n mensajes sin leer',
      one: '1 mensaje sin leer',
    );
    return '$_temp0';
  }

  @override
  String get rendezVous => 'Citas';

  @override
  String get prochainRendezVous => 'Próxima cita';

  @override
  String get aucunRendezVous =>
      'Todavía no hay ninguna cita programada. Tu coach te propondrá una fecha.';

  @override
  String get seancesSansAccompagnement =>
      'Tus citas aparecerán aquí cuando empiece tu acompañamiento.';

  @override
  String get planifierRendezVous => 'Programar una cita';

  @override
  String get modifierRendezVous => 'Modificar la cita';

  @override
  String get champDate => 'Fecha';

  @override
  String get champHeure => 'Hora';

  @override
  String get champDuree => 'Duración';

  @override
  String dureeMinutes(int n) {
    return '$n min';
  }

  @override
  String get champLienZoom => 'Enlace de Zoom';

  @override
  String get champLienZoomAide =>
      'Pega el enlace de la reunión de Zoom (https://…)';

  @override
  String get lienZoomInvalide => 'Enlace no válido: debe empezar por https://';

  @override
  String get rejoindreZoom => 'Unirse en Zoom';

  @override
  String get lienZoomAVenir => 'Tu coach añadirá el enlace de Zoom.';

  @override
  String get lienImpossible => 'No se puede abrir el enlace.';

  @override
  String get rdvEnCours => 'En curso';

  @override
  String get rdvAnnule => 'Cancelada';

  @override
  String get rdvFait => 'Realizada';

  @override
  String get rdvPasse => 'Pasada';

  @override
  String get annulerRendezVous => 'Cancelar la cita';

  @override
  String get confirmerAnnulationRdv =>
      '¿Cancelar esta cita? Se avisará a las personas acompañadas.';

  @override
  String get marquerSeanceFaite => 'Sesión realizada (−1 sesión)';

  @override
  String get historique => 'Historial';

  @override
  String get aVenir => 'Próximas';

  @override
  String get agenda => 'Agenda';

  @override
  String get agendaVide => 'No hay citas próximas.';

  @override
  String get rappelsAutomatiques =>
      'Recordatorio automático el día anterior y 1 hora antes.';

  @override
  String get rendezVousEnregistre => 'Cita guardada';

  @override
  String get dateDansLePasse => 'Elige una fecha futura.';

  @override
  String get nonMerci => 'No';

  @override
  String get forfaits => 'Paquetes de sesiones';

  @override
  String get forfaitsAide =>
      'Paga por transferencia bancaria: las sesiones se añaden en cuanto tu coach recibe el pago.';

  @override
  String nbSeancesForfait(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sesiones',
      one: '1 sesión',
    );
    return '$_temp0';
  }

  @override
  String get choisir => 'Elegir';

  @override
  String get mesPaiements => 'Mis pagos';

  @override
  String get paiementEnAttente => 'Pendiente';

  @override
  String get paiementRecu => 'Recibido';

  @override
  String get paiementAnnule => 'Cancelado';

  @override
  String get virementTitre => 'Pago por transferencia';

  @override
  String get virementAide =>
      'Escanea el código QR con tu aplicación bancaria o copia los datos de abajo. No olvides la referencia: identifica tu pago.';

  @override
  String get montant => 'Importe';

  @override
  String get beneficiaire => 'Beneficiario';

  @override
  String get iban => 'IBAN';

  @override
  String get bic => 'BIC';

  @override
  String get communicationStructuree => 'Referencia estructurada';

  @override
  String get coordonneesIndisponibles =>
      'Los datos bancarios aún no están disponibles. Escribe a tu coach o inténtalo más tarde.';

  @override
  String get paiementRecuMerci => 'Pago recibido. ¡Gracias!';

  @override
  String get paiementAttenteAide =>
      'Tu coach confirmará la recepción de la transferencia (normalmente de 1 a 2 días hábiles).';

  @override
  String get renoncerPaiement => 'Al final no voy a pagar';

  @override
  String get faireUnDon => 'Hacer un donativo';

  @override
  String get donAide =>
      'Tu donativo es libre y apoya este ministerio. No desbloquea nada: todos los contenidos siguen siendo gratuitos para todos.';

  @override
  String get autreMontant => 'Otro importe (€)';

  @override
  String get montantInvalide => 'Entre 1 y 10 000 €';

  @override
  String get continuer => 'Continuar';

  @override
  String get don => 'Donativo';

  @override
  String get paiementsCoach => 'Pagos y donativos';

  @override
  String get aucunPaiement => 'Ningún pago.';

  @override
  String get confirmerReception => 'Pago recibido';

  @override
  String confirmerReceptionTexte(String montant, String communication) {
    return '¿Confirmas que has recibido $montant con la referencia $communication? Las sesiones del paquete se añadirán automáticamente.';
  }

  @override
  String totalRecuMois(String montant) {
    return 'Recibido este mes: $montant';
  }

  @override
  String get nouveauForfait => 'Nuevo paquete';

  @override
  String get modifierForfait => 'Modificar el paquete';

  @override
  String get aucunForfait =>
      'Ningún paquete. Crea uno para que tus clientes puedan pagar sus sesiones.';

  @override
  String get champNomForfait => 'Nombre';

  @override
  String get champNbSeances => 'Número de sesiones';

  @override
  String get champPrix => 'Precio (€)';

  @override
  String get forfaitActif => 'Ofrecido a los clientes';

  @override
  String get nombreInvalide => 'Número no válido';

  @override
  String get parametresCoach => 'Ajustes del coach';

  @override
  String get parametresCoachAide =>
      'Estos datos se muestran a quienes pagan un paquete o hacen un donativo.';

  @override
  String get champNomAffiche => 'Nombre visible';

  @override
  String get champTitulaire => 'Titular de la cuenta';

  @override
  String get champBicAide => 'Opcional';

  @override
  String get ibanInvalide => 'IBAN no válido: revisa los dígitos';

  @override
  String get bicInvalide => 'BIC no válido (8 u 11 caracteres)';

  @override
  String get champMessageDon => 'Mensaje de agradecimiento por los donativos';

  @override
  String get plus => 'Más';

  @override
  String get mesLivres => 'Mis libros';

  @override
  String get mesLivresAide => 'Los libros de tu coach';

  @override
  String get aucunLivre => 'Todavía no hay libros.';

  @override
  String get formatPapier => 'Papel';

  @override
  String get formatNumerique => 'Digital';

  @override
  String get formatAudio => 'Audiolibro';

  @override
  String disponibleEn(String langues) {
    return 'Disponible en: $langues';
  }

  @override
  String acheterSur(String boutique) {
    return 'Comprar en $boutique';
  }

  @override
  String get lireExtrait => 'Leer un fragmento';

  @override
  String get commanderAuCoach => 'Pedir al coach';

  @override
  String get commanderAuCoachAide =>
      'Libro en papel enviado por correo, pagado por transferencia.';

  @override
  String get quantite => 'Cantidad';

  @override
  String get fraisEnvoi => 'Gastos de envío';

  @override
  String get total => 'Total';

  @override
  String get adresseLivraison => 'Dirección de entrega';

  @override
  String get champRue => 'Calle y número';

  @override
  String get champCodePostal => 'Código postal';

  @override
  String get champVille => 'Ciudad';

  @override
  String get champPays => 'País';

  @override
  String get commander => 'Pedir';

  @override
  String get commandeLivre => 'Pedido de libro';

  @override
  String get mesCommandes => 'Mis pedidos';

  @override
  String get commandeEnAttente => 'Pendiente de pago';

  @override
  String get commandePayee => 'Pagado';

  @override
  String get commandeEnvoyee => 'Enviado';

  @override
  String get commandeAnnulee => 'Cancelado';

  @override
  String get commandePayeeAide =>
      'Pago recibido: tu libro se enviará muy pronto.';

  @override
  String get commandeEnvoyeeAide => 'Tu libro está en camino. ¡Buena lectura!';

  @override
  String get numeroSuivi => 'Número de seguimiento';

  @override
  String get renoncerCommande => 'Cancelar el pedido';

  @override
  String get livresCoach => 'Libros';

  @override
  String get commandesLivres => 'Pedidos';

  @override
  String get aucuneCommande => 'Ningún pedido.';

  @override
  String get nouveauLivre => 'Nuevo libro';

  @override
  String get modifierLivre => 'Modificar el libro';

  @override
  String get couverture => 'Portada';

  @override
  String get choisirCouverture => 'Elegir una imagen';

  @override
  String get champSousTitre => 'Subtítulo';

  @override
  String get languesDuLivre => 'Idiomas del libro';

  @override
  String get formatsEtPrix => 'Formatos y precios (€)';

  @override
  String get liensAchat => 'Enlaces de compra';

  @override
  String get nomBoutique => 'Tienda (p. ej. Amazon)';

  @override
  String get adresseLien => 'Dirección (https://…)';

  @override
  String get ajouterLien => 'Añadir un enlace';

  @override
  String get lienInvalide => 'Dirección no válida: debe empezar por https://';

  @override
  String get commandeDirecteOption => 'Pedido directo del libro en papel';

  @override
  String get commandeDirecteAide =>
      'Los lectores te piden el libro y pagan por transferencia; tú lo envías por correo.';

  @override
  String get champExtrait => 'Enlace a un fragmento (opcional)';

  @override
  String get publierLivre => 'Publicado';

  @override
  String get prixPapierRequis => 'Indica el precio del libro en papel';

  @override
  String get marquerPayee => 'Pago recibido';

  @override
  String get marquerEnvoyee => 'Marcar como enviado';

  @override
  String get aTraiter => 'Por gestionar';

  @override
  String get cgu => 'Condiciones de uso';

  @override
  String get confidentialite => 'Privacidad';

  @override
  String get aideContact => 'Ayuda y contacto';

  @override
  String get legalEnFrancais =>
      'Por ahora, esta página solo está disponible en francés.';

  @override
  String get langueApp => 'Idioma de la aplicación';

  @override
  String get langueTelephone => 'Idioma del teléfono';

  @override
  String get mesDonnees => 'Mis datos';

  @override
  String get telechargerMesDonnees => 'Descargar mis datos';

  @override
  String get exportEchoue =>
      'La exportación ha fallado. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get supprimerMonCompte => 'Eliminar mi cuenta';

  @override
  String get supprimerCompteTexte =>
      'Tu cuenta, mensajes, respuestas y progreso se eliminarán definitivamente. Si te acompañan en pareja, tu cónyuge conserva el acompañamiento. Los pagos se conservan sin tu nombre para la contabilidad. Esta acción es irreversible.';

  @override
  String get supprimerDefinitivement => 'Eliminar definitivamente';

  @override
  String get compteSupprime => 'Tu cuenta ha sido eliminada.';

  @override
  String get erreurCommandeEnCours =>
      'Un libro pagado aún no se ha enviado: inténtalo de nuevo cuando lo recibas.';

  @override
  String get erreurCompteCoach =>
      'La cuenta del coach no se puede eliminar desde la aplicación.';

  @override
  String get presentationCoach => 'Mi presentación';

  @override
  String get presentationCoachAide =>
      'Visible para todos en el inicio, con tu nombre y la foto de tu perfil.';

  @override
  String get champBio => 'Presentación';

  @override
  String get informationsLegales => 'Información';

  @override
  String get contenusDepart => 'Contenidos iniciales';

  @override
  String get contenusDepartAide =>
      'Añade 30 meditaciones, 60 preguntas para hablar en pareja y 4 itinerarios, en los 5 idiomas, ya publicados. Podrás modificarlo, despublicarlo o eliminarlo todo. Tus contenidos existentes nunca se reemplazan.';

  @override
  String get charger => 'Cargar';

  @override
  String contenusDepartAjoutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n contenidos añadidos.',
      one: '1 contenido añadido.',
      zero: 'Ya estaba todo: nada que añadir.',
    );
    return '$_temp0';
  }

  @override
  String get boutique => 'Tienda';

  @override
  String get ajouterArticle => 'Añadir un artículo';

  @override
  String get nouvelArticle => 'Nuevo artículo';

  @override
  String get categorieLivre => 'Libro';

  @override
  String get categorieAutre => 'Otro artículo';

  @override
  String get categorieLivres => 'Libros';

  @override
  String get categorieAutres => 'Otros artículos';

  @override
  String get articleAutreAide =>
      'Objeto físico (CD, agenda, tarjeta, ropa…). Un artículo digital solo se vende mediante un enlace a una tienda externa.';

  @override
  String get ajouterAudioVideo => 'Añadir audio o vídeo';
}
