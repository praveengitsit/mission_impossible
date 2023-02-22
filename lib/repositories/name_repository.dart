import 'package:sample/models/name_list_dummy_data.dart';

import '../models/name_model.dart';

class NameRepository {
  Future<List<NameModel>> getRandomNames() {
    final nameList =
        nameListDummyJson.map((e) => NameModel.fromJson(e)).toList();

    final randomNameList = nameList.map((e) => e).toList()
      ..shuffle()
      ..toList()
      ..take(10)
      ..toList();
    return Future.value(randomNameList);
  }

  Future<List<NameModel>> getNamesStartingFrom({
    required String firstLetter,
  }) {
    final nameList =
        nameListDummyJson.map((e) => NameModel.fromJson(e)).toList();

    final filteredNameList = nameList
        .where(
          (element) => element.firstName!
              .toLowerCase()
              .startsWith(firstLetter.toLowerCase()),
        )
        .toList()
      ..shuffle()
      ..toList()
      ..take(10)
      ..toList();

    return Future.value(filteredNameList);
  }
}
