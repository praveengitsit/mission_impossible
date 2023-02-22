import '../models/mission_impossible_history.dart';

class MissionImpossibleRepository {
  MissionImpossibleHistory? _missionImpossibleHistory;

  Future<MissionImpossibleHistory?> loadMissionImpossibleHistory() {
    if (_missionImpossibleHistory == null) {
      return Future.value(null);
    }

    return Future.value(_missionImpossibleHistory);
  }

  void saveMissionImpossibleData(
      MissionImpossibleHistory missionImpossibleData) {
    _missionImpossibleHistory = missionImpossibleData;
  }
}
