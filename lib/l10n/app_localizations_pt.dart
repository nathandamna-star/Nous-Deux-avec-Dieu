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

  @override
  String get typeMeditation => 'Meditação';

  @override
  String get typeQuestion => 'Pergunta a dois';

  @override
  String get typeExercice => 'Exercício';

  @override
  String get typeArticle => 'Artigo';

  @override
  String get tous => 'Todos';

  @override
  String get themeCommunication => 'Comunicação';

  @override
  String get themePardon => 'Perdão';

  @override
  String get themeFinances => 'Finanças';

  @override
  String get themeIntimite => 'Intimidade';

  @override
  String get themePriere => 'Oração';

  @override
  String get themeEnfants => 'Filhos';

  @override
  String get themeFiancailles => 'Noivado';

  @override
  String get themeGratitude => 'Gratidão';

  @override
  String get meditationDuJour => 'Meditação do dia';

  @override
  String get lire => 'Ler';

  @override
  String get decouvrirContenus => 'Descobrir todos os conteúdos';

  @override
  String get aucunContenu => 'Ainda sem conteúdos. Volte em breve!';

  @override
  String get autreLangue => 'Ainda não traduzido para o seu idioma.';

  @override
  String get accueilBienvenue => 'Que a paz de Deus guarde os vossos corações.';

  @override
  String get mesContenus => 'Os meus conteúdos';

  @override
  String get nouveauContenu => 'Novo conteúdo';

  @override
  String get modifierContenu => 'Editar conteúdo';

  @override
  String get brouillon => 'Rascunho';

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
  String get champReference => 'Referência bíblica (opcional)';

  @override
  String get champReferenceAide => 'Ex. Efésios 4:2';

  @override
  String get langueVersion => 'Versão';

  @override
  String get titreFrancaisRequis => 'O título em francês é obrigatório.';

  @override
  String get visiblePourTous => 'Visível sem conta';

  @override
  String get visiblePourTousAide =>
      'Caso contrário, apenas para quem tem sessão iniciada.';

  @override
  String get publier => 'Publicar';

  @override
  String get publierAide => 'Desativado: rascunho, visível só para si.';

  @override
  String get champOrdre => 'Ordem de apresentação';

  @override
  String get champOrdreAide =>
      'As meditações do dia seguem esta ordem (1, 2, 3…).';

  @override
  String get enregistrer => 'Guardar';

  @override
  String get enregistre => 'Guardado';

  @override
  String get supprimerContenuTitre => 'Apagar este conteúdo?';

  @override
  String get supprimerContenuTexte => 'Desaparecerá para todos. É definitivo.';

  @override
  String get typeAudio => 'Áudio';

  @override
  String get typeVideo => 'Vídeo';

  @override
  String get lecture => 'Reproduzir';

  @override
  String get pause => 'Pausa';

  @override
  String get reculer15 => 'Recuar 15 segundos';

  @override
  String get avancer15 => 'Avançar 15 segundos';

  @override
  String get vitesse => 'Velocidade';

  @override
  String get pleinEcran => 'Ecrã inteiro';

  @override
  String get erreurLecture =>
      'Não é possível reproduzir este ficheiro. Verifique a ligação.';

  @override
  String fichierMedia(String langue) {
    return 'Ficheiro ($langue)';
  }

  @override
  String get choisirFichier => 'Escolher o ficheiro';

  @override
  String get remplacerFichier => 'Substituir';

  @override
  String get fichierAjoute => 'Ficheiro adicionado';

  @override
  String get aucunFichier => 'Nenhum ficheiro neste idioma.';

  @override
  String envoiEnCours(int pourcent) {
    return 'A enviar… $pourcent %';
  }

  @override
  String get fichierRequis => 'Adicione pelo menos um ficheiro.';

  @override
  String get envoiEchoue => 'O envio falhou. Tente novamente.';

  @override
  String get champDescription => 'Descrição';

  @override
  String get changerPhoto => 'Alterar a foto de perfil';

  @override
  String get prendrePhoto => 'Tirar uma foto';

  @override
  String get choisirGalerie => 'Escolher da galeria';

  @override
  String get supprimerPhoto => 'Remover a foto';

  @override
  String get photoEnvoiEchoue =>
      'Não foi possível guardar a foto. Tente novamente.';

  @override
  String get mesExercices => 'Os meus exercícios';

  @override
  String exercicesAFaire(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n exercícios por fazer',
      one: '1 exercício por fazer',
      zero: 'Nenhum exercício por fazer',
    );
    return '$_temp0';
  }

  @override
  String get aucunExercice => 'O seu coach ainda não lhe enviou exercícios.';

  @override
  String get exerciceFait => 'Feito';

  @override
  String get exerciceAFaire => 'Por fazer';

  @override
  String get modeSeul => 'Cada um por si';

  @override
  String get modeADeux => 'A fazer a dois';

  @override
  String get modeSeulAide =>
      'A sua resposta só é vista por si e pelo seu coach.';

  @override
  String get modeADeuxAide =>
      'Uma resposta comum, escrita em conjunto, visível para os dois e para o coach.';

  @override
  String aFaireAvant(String date) {
    return 'A fazer até $date';
  }

  @override
  String get lireAvant => 'Ler antes';

  @override
  String get maReponse => 'A minha resposta';

  @override
  String get notreReponse => 'A nossa resposta';

  @override
  String get enregistrerReponse => 'Guardar a minha resposta';

  @override
  String get reponseEnregistree =>
      'Resposta guardada. O seu coach poderá lê-la.';

  @override
  String get exercices => 'Exercícios';

  @override
  String get envoyerExercice => 'Enviar um exercício';

  @override
  String get apartirContenu => 'A partir de um conteúdo (opcional)';

  @override
  String get aucunContenuLie => 'Nenhum';

  @override
  String get champConsignes => 'Instruções';

  @override
  String get echeance => 'Data limite (opcional)';

  @override
  String get choisirDate => 'Escolher uma data';

  @override
  String get envoyer => 'Enviar';

  @override
  String get exerciceEnvoye => 'Exercício enviado.';

  @override
  String reponses(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n respostas',
      one: '1 resposta',
      zero: 'Nenhuma resposta',
    );
    return '$_temp0';
  }

  @override
  String get pasEncoreRepondu => 'Ainda não respondeu.';

  @override
  String get reponseCommune => 'Resposta comum';

  @override
  String get supprimerExerciceTitre => 'Apagar este exercício?';

  @override
  String get parcours => 'Percursos';

  @override
  String get aucunParcours => 'Ainda não há percursos.';

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
  String get commencerParcours => 'Começar';

  @override
  String get parcoursTermine => 'Percurso concluído. Parabéns!';

  @override
  String get marquerFait => 'Marcar como feito';

  @override
  String get etapeFaite => 'Etapa feita';

  @override
  String get connexionPourSuivre => 'Entre para acompanhar o seu progresso.';

  @override
  String get mesParcours => 'Os meus percursos';

  @override
  String get nouveauParcours => 'Novo percurso';

  @override
  String get modifierParcours => 'Editar percurso';

  @override
  String get etapes => 'Etapas';

  @override
  String get ajouterEtape => 'Adicionar uma etapa';

  @override
  String get retirerEtape => 'Retirar a etapa';

  @override
  String get etapesRequises => 'Adicione pelo menos uma etapa.';

  @override
  String get choisirContenuEtape => 'Escolher um conteúdo';

  @override
  String get supprimerParcoursTitre => 'Apagar este percurso?';

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
  String get votreCoach => 'O seu coach';

  @override
  String get messagesSansAccompagnement =>
      'Para escrever ao seu coach, peça primeiro um acompanhamento no seu perfil.';

  @override
  String get aucunMessage => 'Ainda sem mensagens. Escreva a primeira!';

  @override
  String get aucuneConversation => 'Ainda sem conversas.';

  @override
  String get ecrireMessage => 'Escrever uma mensagem';

  @override
  String get envoyerMessage => 'Enviar';

  @override
  String get envoyerPhoto => 'Enviar uma foto';

  @override
  String get messageVocal => 'Mensagem de voz';

  @override
  String enregistrementEnCours(String duree) {
    return 'A gravar… $duree';
  }

  @override
  String get arreterEtEnvoyer => 'Parar e enviar';

  @override
  String get microRefuse =>
      'O acesso ao microfone foi recusado. Autorize-o nas Definições do telefone.';

  @override
  String get envoiMessageEchoue =>
      'Não foi possível enviar a mensagem. Tente novamente.';

  @override
  String nonLus(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n mensagens não lidas',
      one: '1 mensagem não lida',
    );
    return '$_temp0';
  }

  @override
  String get rendezVous => 'Consultas';

  @override
  String get prochainRendezVous => 'Próxima consulta';

  @override
  String get aucunRendezVous =>
      'Ainda não há nenhuma consulta marcada. O seu coach vai propor uma data.';

  @override
  String get seancesSansAccompagnement =>
      'As suas consultas aparecerão aqui quando o acompanhamento começar.';

  @override
  String get planifierRendezVous => 'Marcar uma consulta';

  @override
  String get modifierRendezVous => 'Alterar a consulta';

  @override
  String get champDate => 'Data';

  @override
  String get champHeure => 'Hora';

  @override
  String get champDuree => 'Duração';

  @override
  String dureeMinutes(int n) {
    return '$n min';
  }

  @override
  String get champLienZoom => 'Link do Zoom';

  @override
  String get champLienZoomAide => 'Cole o link da reunião Zoom (https://…)';

  @override
  String get lienZoomInvalide => 'Link inválido: deve começar por https://';

  @override
  String get rejoindreZoom => 'Entrar no Zoom';

  @override
  String get lienZoomAVenir => 'O link do Zoom será adicionado pelo seu coach.';

  @override
  String get lienImpossible => 'Não foi possível abrir o link.';

  @override
  String get rdvEnCours => 'Em curso';

  @override
  String get rdvAnnule => 'Cancelada';

  @override
  String get rdvFait => 'Realizada';

  @override
  String get rdvPasse => 'Passada';

  @override
  String get annulerRendezVous => 'Cancelar a consulta';

  @override
  String get confirmerAnnulationRdv =>
      'Cancelar esta consulta? As pessoas acompanhadas serão avisadas.';

  @override
  String get marquerSeanceFaite => 'Sessão realizada (−1 sessão)';

  @override
  String get historique => 'Histórico';

  @override
  String get aVenir => 'Próximas';

  @override
  String get agenda => 'Agenda';

  @override
  String get agendaVide => 'Nenhuma consulta marcada.';

  @override
  String get rappelsAutomatiques =>
      'Lembrete automático na véspera e 1 hora antes.';

  @override
  String get rendezVousEnregistre => 'Consulta guardada';

  @override
  String get dateDansLePasse => 'Escolha uma data futura.';

  @override
  String get nonMerci => 'Não';

  @override
  String get forfaits => 'Pacotes de sessões';

  @override
  String get forfaitsAide =>
      'Pague por transferência bancária: as sessões são adicionadas assim que o seu coach receber o pagamento.';

  @override
  String nbSeancesForfait(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sessões',
      one: '1 sessão',
    );
    return '$_temp0';
  }

  @override
  String get choisir => 'Escolher';

  @override
  String get mesPaiements => 'Os meus pagamentos';

  @override
  String get paiementEnAttente => 'Pendente';

  @override
  String get paiementRecu => 'Recebido';

  @override
  String get paiementAnnule => 'Cancelado';

  @override
  String get virementTitre => 'Pagamento por transferência';

  @override
  String get virementAide =>
      'Leia o código QR com a sua aplicação bancária, ou copie os dados abaixo. Não se esqueça da referência: ela identifica o seu pagamento.';

  @override
  String get montant => 'Montante';

  @override
  String get beneficiaire => 'Beneficiário';

  @override
  String get iban => 'IBAN';

  @override
  String get bic => 'BIC';

  @override
  String get communicationStructuree => 'Referência estruturada';

  @override
  String get coordonneesIndisponibles =>
      'Os dados bancários ainda não estão disponíveis. Escreva ao seu coach ou tente mais tarde.';

  @override
  String get paiementRecuMerci => 'Pagamento recebido. Obrigado!';

  @override
  String get paiementAttenteAide =>
      'O seu coach confirmará a receção da transferência (normalmente 1 a 2 dias úteis).';

  @override
  String get renoncerPaiement => 'Afinal não vou pagar';

  @override
  String get faireUnDon => 'Fazer um donativo';

  @override
  String get donAide =>
      'O seu donativo é livre e apoia este ministério. Não dá acesso a nada extra: todos os conteúdos continuam gratuitos para todos.';

  @override
  String get autreMontant => 'Outro montante (€)';

  @override
  String get montantInvalide => 'Entre 1 e 10 000 €';

  @override
  String get continuer => 'Continuar';

  @override
  String get don => 'Donativo';

  @override
  String get paiementsCoach => 'Pagamentos e donativos';

  @override
  String get aucunPaiement => 'Nenhum pagamento.';

  @override
  String get confirmerReception => 'Pagamento recebido';

  @override
  String confirmerReceptionTexte(String montant, String communication) {
    return 'Confirma que recebeu $montant com a referência $communication? As sessões do pacote serão adicionadas automaticamente.';
  }

  @override
  String totalRecuMois(String montant) {
    return 'Recebido este mês: $montant';
  }

  @override
  String get nouveauForfait => 'Novo pacote';

  @override
  String get modifierForfait => 'Alterar o pacote';

  @override
  String get aucunForfait =>
      'Nenhum pacote. Crie um para que os seus clientes possam pagar as sessões.';

  @override
  String get champNomForfait => 'Nome';

  @override
  String get champNbSeances => 'Número de sessões';

  @override
  String get champPrix => 'Preço (€)';

  @override
  String get forfaitActif => 'Proposto aos clientes';

  @override
  String get nombreInvalide => 'Número inválido';

  @override
  String get parametresCoach => 'Definições do coach';

  @override
  String get parametresCoachAide =>
      'Estes dados são mostrados a quem paga um pacote ou faz um donativo.';

  @override
  String get champNomAffiche => 'Nome apresentado';

  @override
  String get champTitulaire => 'Titular da conta';

  @override
  String get champBicAide => 'Opcional';

  @override
  String get ibanInvalide => 'IBAN inválido: verifique os dígitos';

  @override
  String get bicInvalide => 'BIC inválido (8 ou 11 caracteres)';

  @override
  String get champMessageDon => 'Mensagem de agradecimento pelos donativos';

  @override
  String get plus => 'Mais';
}
