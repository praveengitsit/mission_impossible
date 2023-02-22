part of 'mission_impossible_bloc.dart';

abstract class MissionImpossibleEvent extends Equatable {
  const MissionImpossibleEvent();
}

class LoadHistory extends MissionImpossibleEvent {
  const LoadHistory();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FirstLetterForNamesChanged extends MissionImpossibleEvent {
  final String firstLetterForNames;

  const FirstLetterForNamesChanged({
    required this.firstLetterForNames,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [firstLetterForNames];
}

class NameForFirstPhaseChanged extends MissionImpossibleEvent {
  final NameModel nameForFirstPhase;

  const NameForFirstPhaseChanged({
    required this.nameForFirstPhase,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [nameForFirstPhase];
}

class NameForSecondPhaseChanged extends MissionImpossibleEvent {
  final NameModel nameForSecondPhase;

  const NameForSecondPhaseChanged({
    required this.nameForSecondPhase,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [nameForSecondPhase];
}

class NameForThirdPhaseChanged extends MissionImpossibleEvent {
  final NameModel nameForThirdPhase;

  const NameForThirdPhaseChanged({
    required this.nameForThirdPhase,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [nameForThirdPhase];
}

class StartMission extends MissionImpossibleEvent {
  const StartMission();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Reset extends MissionImpossibleEvent {
  const Reset();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
