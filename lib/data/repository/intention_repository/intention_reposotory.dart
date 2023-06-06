import 'package:places/domain/model/intention.dart';

abstract class IntentionRepository {
  List<Intention> get favoritePlaces;
  set favoritePlaces(List<Intention> list);

  List<Intention> get visitedPlaces;
  set visitedPlaces(List<Intention> list);

  void addIntentionToFavorite(Intention intention);
  void addIntentionToVisited(Intention intention);

  void removeIntentionFromFavorite(Intention intention);

  void removeIntentionFromVisited(Intention intention);

  void changeDateOfFavorite(DateTime date, Intention intention);

  void swapIntention(Intention from, Intention to);

  Intention findIntentionById(int id);
}
