import 'package:flutter/material.dart';
import 'package:places/data/mock_intentions.dart';
import 'package:places/domain/model/intention.dart';

class IntentionRepository with ChangeNotifier {
  final List<Intention> _intentionList =
      List<Intention>.from(mockIntentionsList);

  void add(int sightId) {
    _intentionList.add(Intention(sightId: sightId));
    notifyListeners();
  }

  void delete(int sightId) {
    _intentionList.remove(findIntentionBySightId(sightId));
    notifyListeners();
  }

  void changeDate(DateTime date, int sightId) {
    final index = _intentionList.indexOf(findIntentionBySightId(sightId));
    _intentionList[index].date = date;
    notifyListeners();
  }

  void changeVisited(int sightId) {
    final index = _intentionList.indexOf(findIntentionBySightId(sightId));
    _intentionList[index].hasVisited = !_intentionList[index].hasVisited;
    notifyListeners();
  }

  List<Intention> get visitedList =>
      _intentionList.where((element) => element.hasVisited).toList();

  List<Intention> get plannedList =>
      _intentionList.where((element) => !element.hasVisited).toList();

  Intention findIntentionBySightId(int sightId) {
    return _intentionList.firstWhere((element) => element.sightId == sightId,
        orElse: () => Intention(sightId: -1));
  }

  bool isFavorite(int sightId) =>
      _intentionList.contains(findIntentionBySightId(sightId));

  void changeFavoriteState(int sightId) {
    isFavorite(sightId) ? delete(sightId) : add(sightId);
  }

  void swapIntention(int fromId, int toId) {
    var fromIntention = findIntentionBySightId(fromId);
    var toIntention = findIntentionBySightId(toId);
    int fromIndex = _intentionList.indexOf(fromIntention);
    int toIndex = _intentionList.indexOf(toIntention);
    _intentionList[fromIndex] = toIntention;
    _intentionList[toIndex] = fromIntention;
    notifyListeners();
  }
}
