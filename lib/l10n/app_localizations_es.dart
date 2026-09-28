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
  String get messagesAVenir => 'Aquí: tu conversación con tu coach.';

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
}
