import '../../../l10n/app_localizations.dart';
import '../domain/accompagnement.dart';

extension LibellesAccompagnement on AppLocalizations {
  String statutAccompagnement(StatutAccompagnement s) => switch (s) {
    StatutAccompagnement.demande => statutDemande,
    StatutAccompagnement.actif => statutActif,
    StatutAccompagnement.enPause => statutEnPause,
    StatutAccompagnement.termine => statutTermine,
  };
}
