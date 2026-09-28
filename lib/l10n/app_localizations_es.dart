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
  String get accueilAVenir =>
      'Aquí: la meditación del día, tu próxima cita y tus ejercicios.';

  @override
  String get contenusAVenir =>
      'Aquí: meditaciones, preguntas para dos, itinerarios, audios y vídeos.';

  @override
  String get messagesAVenir => 'Aquí: tu conversación con tu coach.';

  @override
  String get seancesAVenir =>
      'Aquí: tus citas, las sesiones restantes y los paquetes.';

  @override
  String get profilAVenir =>
      'Aquí: tu idioma, tu cónyuge, los donativos y tus datos.';

  @override
  String get coachAVenir =>
      'Aquí: tus acompañamientos, tu agenda, tus contenidos y los pagos.';

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
}
