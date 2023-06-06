import 'dart:developer';

import 'package:places/data/repository/intention_repository/intention_reposotory.dart';
import 'package:places/domain/model/intention.dart';

class IntentionRepositoryImpl implements IntentionRepository {
  List<Intention> _favoriteIntentionList = List.empty(growable: true);
  List<Intention> _visitedIntentionList = List.empty(growable: true);

  @override
  List<Intention> get favoritePlaces => _favoriteIntentionList;

  @override
  set favoritePlaces(List<Intention> list) => _favoriteIntentionList = list;

  @override
  List<Intention> get visitedPlaces => _visitedIntentionList;

  @override
  set visitedPlaces(List<Intention> list) => _visitedIntentionList = list;

  @override
  void addIntentionToFavorite(Intention intention) {
    _favoriteIntentionList.add(intention);
    log('add ${_favoriteIntentionList.toString()}',
        name: 'IntentionRepositoryImpl');
  }

  @override
  void addIntentionToVisited(Intention intention) {
    _favoriteIntentionList.remove(intention);
    _visitedIntentionList.add(intention);
  }

  @override
  void removeIntentionFromFavorite(Intention requestIntention) {
    final result = _favoriteIntentionList.remove(requestIntention);
    print('remove $result');
    log('remove ${_favoriteIntentionList.toString()}',
        name: 'IntentionRepositoryImpl');
  }

  @override
  void removeIntentionFromVisited(Intention intention) {
    final result = _visitedIntentionList.remove(intention);
    print('remove intention $result');
  }

  @override
  void swapIntention(Intention from, Intention to) {
    var fromIntention =
        _favoriteIntentionList.firstWhere((element) => element == from);
    var toIntention =
        _favoriteIntentionList.firstWhere((element) => element == to);
    int fromIndex = _favoriteIntentionList.indexOf(fromIntention);
    int toIndex = _favoriteIntentionList.indexOf(toIntention);
    _favoriteIntentionList[fromIndex] = toIntention;
    _favoriteIntentionList[toIndex] = fromIntention;
  }

  Intention findIntentionByPlaceId(int placeId) {
    return _favoriteIntentionList.firstWhere(
        (element) => element.placeId == placeId,
        orElse: () => Intention(placeId: -1));
  }

  @override
  void changeDateOfFavorite(DateTime date, Intention intention) {
    _favoriteIntentionList.firstWhere((element) => element == intention).date =
        date;
  }

  @override
  Intention findIntentionById(int id) {
    return _favoriteIntentionList.firstWhere(
      (element) => element.placeId == id,
      orElse: () => Intention.empty(-1),
    );
  }
}
