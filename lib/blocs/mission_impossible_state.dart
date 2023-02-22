part of 'mission_impossible_bloc.dart';

enum MissionImpossibleFormStatus {
  initial,
  loadingFailed,
  submissionSuccess,
}

class MissionImpossibleState extends Equatable {
  final String? firstLetterForNames;
  final NameModel? nameForFirstPhase;
  final NameModel? nameForSecondPhase;
  final NameModel? nameForThirdPhase;
  final MissionImpossibleFormStatus status;

  const MissionImpossibleState({
    this.firstLetterForNames,
    this.nameForFirstPhase,
    this.nameForSecondPhase,
    this.nameForThirdPhase,
    this.status = MissionImpossibleFormStatus.initial,
  });

  MissionImpossibleState copyWith({
    String? firstLetterForNames,
    NameModel? nameForFirstPhase,
    NameModel? nameForSecondPhase,
    NameModel? nameForThirdPhase,
    MissionImpossibleFormStatus? status,
  }) =>
      MissionImpossibleState(
        firstLetterForNames: firstLetterForNames ?? this.firstLetterForNames,
        nameForFirstPhase: nameForFirstPhase ?? this.nameForFirstPhase,
        nameForSecondPhase: nameForSecondPhase ?? this.nameForSecondPhase,
        nameForThirdPhase: nameForThirdPhase ?? this.nameForThirdPhase,
        status: status ?? this.status,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        firstLetterForNames,
        nameForFirstPhase,
        nameForSecondPhase,
        nameForThirdPhase,
        status,
      ];
}
