import '../../../l10n/app_localizations.dart';
import '../domain/contenu.dart';

extension LibellesContenu on AppLocalizations {
  String typeContenu(TypeContenu t) => switch (t) {
    TypeContenu.meditation => typeMeditation,
    TypeContenu.question => typeQuestion,
    TypeContenu.exercice => typeExercice,
    TypeContenu.article => typeArticle,
    TypeContenu.audio => typeAudio,
    TypeContenu.video => typeVideo,
  };

  String themeContenu(ThemeContenu t) => switch (t) {
    ThemeContenu.communication => themeCommunication,
    ThemeContenu.pardon => themePardon,
    ThemeContenu.finances => themeFinances,
    ThemeContenu.intimite => themeIntimite,
    ThemeContenu.priere => themePriere,
    ThemeContenu.enfants => themeEnfants,
    ThemeContenu.fiancailles => themeFiancailles,
    ThemeContenu.gratitude => themeGratitude,
  };
}
