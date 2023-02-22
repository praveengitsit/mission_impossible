import 'name_model.dart';

class MissionImpossibleHistory {
  final String? firstLetterForNames;
  final NameModel nameForFirstPhase;
  final NameModel nameForSecondPhase;
  final NameModel nameForThirdPhase;

  const MissionImpossibleHistory({
    this.firstLetterForNames,
    required this.nameForFirstPhase,
    required this.nameForSecondPhase,
    required this.nameForThirdPhase,
  });
}
