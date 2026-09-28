// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Nous deux avec Dieu';

  @override
  String get slogan => 'Crescer a dois, com Deus no centro.';

  @override
  String get navAccueil => 'Início';

  @override
  String get navContenus => 'Conteúdos';

  @override
  String get navMessages => 'Mensagens';

  @override
  String get navSeances => 'Sessões';

  @override
  String get navProfil => 'Perfil';

  @override
  String get navCoach => 'Coach';

  @override
  String get bientot => 'Em breve';

  @override
  String get accueilAVenir =>
      'Aqui: a meditação do dia, o seu próximo encontro e os seus exercícios.';

  @override
  String get contenusAVenir =>
      'Aqui: meditações, perguntas a dois, percursos, áudios e vídeos.';

  @override
  String get messagesAVenir => 'Aqui: a sua conversa com o seu coach.';

  @override
  String get seancesAVenir =>
      'Aqui: os seus encontros, as sessões restantes e os pacotes.';

  @override
  String get profilAVenir =>
      'Aqui: o seu idioma, o seu cônjuge, os donativos e os seus dados.';

  @override
  String get bienvenueQuestion => 'O que o traz aqui?';

  @override
  String get parcoursCouple => 'Vimos como casal';

  @override
  String get parcoursCoupleAide => 'Casados, noivos ou em casal';

  @override
  String get parcoursSeul => 'Venho sozinho(a)';

  @override
  String get parcoursSeulAide =>
      'Para crescer pessoalmente ou preparar o futuro';

  @override
  String get parcoursDecouverte => 'Estou a descobrir';

  @override
  String get parcoursDecouverteAide =>
      'Meditações, perguntas a dois, áudios e vídeos';

  @override
  String get continuerEmail => 'Continuar com e-mail';

  @override
  String get explorerSansCompte => 'Explorar sem conta';

  @override
  String get seConnecter => 'Entrar';

  @override
  String get creerCompte => 'Criar conta';

  @override
  String get seDeconnecter => 'Terminar sessão';

  @override
  String get champNom => 'Nome e apelido';

  @override
  String get champEmail => 'Endereço de e-mail';

  @override
  String get champMotDePasse => 'Palavra-passe';

  @override
  String get afficherMotDePasse => 'Mostrar palavra-passe';

  @override
  String get masquerMotDePasse => 'Ocultar palavra-passe';

  @override
  String get motDePasseOublie => 'Esqueceu a palavra-passe?';

  @override
  String emailReinitialisationEnvoye(String email) {
    return 'Foi enviado um e-mail para $email para escolher uma nova palavra-passe.';
  }

  @override
  String get validationNomRequis => 'Indique o seu nome.';

  @override
  String get validationEmail => 'Indique um e-mail válido.';

  @override
  String get validationMotDePasse => 'Pelo menos 8 caracteres.';

  @override
  String get consentementTexte =>
      'Aceito que as minhas respostas e mensagens, que podem dizer respeito à minha fé e à minha vida a dois, sejam guardadas na Europa e vistas apenas pelo meu coach, para me acompanhar. Posso retirar o meu consentimento e apagar a minha conta a qualquer momento.';

  @override
  String get consentementRequis => 'Assinale a caixa para criar a sua conta.';

  @override
  String get chargement => 'A carregar…';

  @override
  String get erreurEmailInvalide => 'Este e-mail não é válido.';

  @override
  String get erreurMotDePasseFaible =>
      'Esta palavra-passe é demasiado fraca. Use pelo menos 8 caracteres.';

  @override
  String get erreurEmailDejaUtilise =>
      'Já existe uma conta com este e-mail. Entre antes.';

  @override
  String get erreurIdentifiantsIncorrects =>
      'E-mail ou palavra-passe incorretos.';

  @override
  String get erreurTropDeTentatives =>
      'Demasiadas tentativas. Tente novamente dentro de alguns minutos.';

  @override
  String get erreurReseau =>
      'Sem ligação à internet. Verifique a rede e tente novamente.';

  @override
  String get erreurInconnue => 'Ocorreu um erro. Tente novamente.';

  @override
  String get connexionRequiseTitre => 'Um espaço só seu';

  @override
  String get connexionRequiseTexte =>
      'Entre para falar com o seu coach, acompanhar as sessões e gerir o seu perfil.';

  @override
  String bonjourNom(String nom) {
    return 'Olá $nom';
  }

  @override
  String get roleCoach => 'Coach';

  @override
  String get monAccompagnement => 'O meu acompanhamento';

  @override
  String get demanderAccompagnement => 'Pedir acompanhamento';

  @override
  String get demanderAccompagnementAide =>
      'O seu coach responderá para marcar um primeiro encontro.';

  @override
  String get jAiUnCode => 'Tenho um código do meu cônjuge';

  @override
  String get typeCouple => 'Em casal';

  @override
  String get typeIndividuel => 'Sozinho(a)';

  @override
  String get champNomAccompagnement => 'Nome apresentado';

  @override
  String get champNomAccompagnementAide => 'Por exemplo «Paulo & Maria»';

  @override
  String get champMessage => 'A sua mensagem ao coach (opcional)';

  @override
  String get champMessageAide => 'O que estão a viver, o que esperam…';

  @override
  String get envoyerDemande => 'Enviar o pedido';

  @override
  String get demandeEnvoyee =>
      'Pedido enviado. O seu coach responderá em breve.';

  @override
  String get champObligatoire => 'Este campo é obrigatório.';

  @override
  String get rejoindreTitre => 'Juntar-me ao meu cônjuge';

  @override
  String get rejoindreAide =>
      'Introduza o código de 6 caracteres que o seu cônjuge vê no perfil.';

  @override
  String get champCode => 'Código de convite';

  @override
  String get rejoindre => 'Juntar-me';

  @override
  String get codeInvalide =>
      'Este código não é válido ou o casal já está completo.';

  @override
  String codePourConjoint(String code) {
    return 'Código para o seu cônjuge: $code';
  }

  @override
  String get codePourConjointAide =>
      'O seu cônjuge cria a conta e escolhe «Tenho um código do meu cônjuge».';

  @override
  String get copier => 'Copiar';

  @override
  String get copie => 'Copiado';

  @override
  String get statutDemande => 'Pedido pendente';

  @override
  String get statutActif => 'Acompanhamento em curso';

  @override
  String get statutEnPause => 'Em pausa';

  @override
  String get statutTermine => 'Terminado';

  @override
  String seancesRestantes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessões restantes',
      one: '1 sessão restante',
      zero: 'Nenhuma sessão restante',
    );
    return '$_temp0';
  }

  @override
  String get attendConjoint => 'À espera do cônjuge';

  @override
  String get filtreDemandes => 'Pedidos';

  @override
  String get filtreActifs => 'Em curso';

  @override
  String get filtreTermines => 'Terminados';

  @override
  String get aucunAccompagnement => 'Ainda não há acompanhamentos aqui.';

  @override
  String get membres => 'Membros';

  @override
  String get messageDemande => 'Mensagem do pedido';

  @override
  String get accepter => 'Aceitar';

  @override
  String get mettreEnPause => 'Pausar';

  @override
  String get reprendre => 'Retomar';

  @override
  String get terminer => 'Terminar';

  @override
  String get seances => 'Sessões';

  @override
  String get retirerSeance => 'Retirar uma sessão';

  @override
  String get ajouterSeance => 'Adicionar uma sessão';

  @override
  String get notesPrivees => 'Notas privadas';

  @override
  String get notesPriveesAide => 'Visíveis apenas por si.';

  @override
  String get nouvelleNote => 'Nova nota';

  @override
  String get ajouter => 'Adicionar';

  @override
  String get supprimer => 'Apagar';

  @override
  String get aucuneNote => 'Ainda sem notas.';

  @override
  String get activerCoachTitre => 'Ativar o espaço do coach?';

  @override
  String get activerCoachTexte =>
      'Reservado ao coach: só a conta definida na instalação o pode ativar.';

  @override
  String get coachActive => 'Espaço do coach ativado.';

  @override
  String get coachRefuse => 'Esta conta não pode ser coach.';

  @override
  String get annuler => 'Cancelar';

  @override
  String get valider => 'Confirmar';
}
