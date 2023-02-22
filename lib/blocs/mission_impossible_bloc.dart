import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/mission_impossible_history.dart';
import '../models/name_model.dart';
import '../repositories/mission_impossible_repository.dart';

part 'mission_impossible_event.dart';
part 'mission_impossible_state.dart';

class MissionImpossibleBloc
    extends Bloc<MissionImpossibleEvent, MissionImpossibleState> {
  final MissionImpossibleRepository _missionImpossibleRepository;
  MissionImpossibleBloc(this._missionImpossibleRepository)
      : super(const MissionImpossibleState()) {
    on<LoadHistory>(_onLoadHistory);
    on<FirstLetterForNamesChanged>(_onFirstLetterForNamesChanged);
    on<NameForFirstPhaseChanged>(_onNameForFirstPhaseChanged);
    on<NameForSecondPhaseChanged>(_onNameForSecondPhaseChanged);
    on<NameForThirdPhaseChanged>(_onNameForThirdPhaseChanged);
    on<StartMission>(_onStartMission);
    on<Reset>(_onReset);
  }

  FutureOr<void> _onLoadHistory(
    LoadHistory event,
    Emitter<MissionImpossibleState> emit,
  ) async {
    final historyResponse =
        await _missionImpossibleRepository.loadMissionImpossibleHistory();

    if (historyResponse == null) {
      emit(
        state.copyWith(
          status: MissionImpossibleFormStatus.loadingFailed,
        ),
      );
    } else {
      emit(
        MissionImpossibleState(
          firstLetterForNames: historyResponse.firstLetterForNames,
          nameForFirstPhase: historyResponse.nameForFirstPhase,
          nameForSecondPhase: historyResponse.nameForSecondPhase,
          nameForThirdPhase: historyResponse.nameForThirdPhase,
        ),
      );
    }
  }

  FutureOr<void> _onFirstLetterForNamesChanged(
    FirstLetterForNamesChanged event,
    Emitter<MissionImpossibleState> emit,
  ) {
    emit(
      state.copyWith(
        firstLetterForNames: event.firstLetterForNames,
        status: MissionImpossibleFormStatus.initial,
      ),
    );
  }

  FutureOr<void> _onNameForFirstPhaseChanged(
    NameForFirstPhaseChanged event,
    Emitter<MissionImpossibleState> emit,
  ) {
    emit(
      state.copyWith(
        nameForFirstPhase: event.nameForFirstPhase,
        status: MissionImpossibleFormStatus.initial,
      ),
    );
  }

  FutureOr<void> _onNameForSecondPhaseChanged(
    NameForSecondPhaseChanged event,
    Emitter<MissionImpossibleState> emit,
  ) {
    emit(
      state.copyWith(
        nameForSecondPhase: event.nameForSecondPhase,
        status: MissionImpossibleFormStatus.initial,
      ),
    );
  }

  FutureOr<void> _onNameForThirdPhaseChanged(
    NameForThirdPhaseChanged event,
    Emitter<MissionImpossibleState> emit,
  ) {
    emit(
      state.copyWith(
        nameForThirdPhase: event.nameForThirdPhase,
        status: MissionImpossibleFormStatus.initial,
      ),
    );
  }

  FutureOr<void> _onStartMission(
    StartMission event,
    Emitter<MissionImpossibleState> emit,
  ) async {
    _missionImpossibleRepository.saveMissionImpossibleData(
      MissionImpossibleHistory(
        firstLetterForNames: state.firstLetterForNames,
        nameForFirstPhase: state.nameForFirstPhase!,
        nameForSecondPhase: state.nameForSecondPhase!,
        nameForThirdPhase: state.nameForThirdPhase!,
      ),
    );
    emit(
      state.copyWith(
        status: MissionImpossibleFormStatus.submissionSuccess,
      ),
    );
  }

  FutureOr<void> _onReset(
    Reset event,
    Emitter<MissionImpossibleState> emit,
  ) {
    emit(
      const MissionImpossibleState(),
    );
  }
}
