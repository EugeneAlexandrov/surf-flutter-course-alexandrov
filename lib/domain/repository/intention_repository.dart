import 'package:flutter/material.dart';
import 'package:places/data/mock_intentions.dart';
import 'package:places/domain/model/intention.dart';

class IntentionRepository with ChangeNotifier {
  List<Intention> intentionList = mockIntentionsList;

  void add(int sightId) {
    intentionList.add(Intention(
        id: intentionList[intentionList.length - 1].id + 1, sightId: sightId));
    notifyListeners();
  }

  void delete(int sightId) {
    intentionList.remove(findBySightId(sightId));
    notifyListeners();
  }

  void changeDate(DateTime date, int sightId) {
    final index = intentionList.indexOf(findBySightId(sightId));
    intentionList[index].date = date;
    notifyListeners();
  }

  Intention findBySightId(int sightId) {
    return intentionList.firstWhere((element) => element.sightId == sightId);
  }
}
