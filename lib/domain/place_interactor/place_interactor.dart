import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/data/mock_categories.dart';
import 'package:places/data/repository/place_repository/place_repository.dart';
import 'package:places/domain/model/category.dart';
import 'package:places/domain/model/intention.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/services/geo/location_service.dart';

class PlaceInteractor with ChangeNotifier {
  final PlaceRepository placeRepository;
  final LocationService locationService;
  List<Place> _places = [];
  final List<Intention> _favoritePlaces = [];
  final List<Category> _categories = mockCategories;
  double _radius = 500;

  PlaceInteractor(this.placeRepository, this.locationService);

  List<Place> get places => _places;

  Future<void> getPlaces() async {
    try {
      LocationData location = await locationService.locationData;
      _places = await placeRepository.getFilteredPlaces(
        lat: location.latitude,
        lng: location.longitude,
        radius: _radius,
        category: _categories
            .where((element) => element.isActive)
            .map((e) => e.toString())
            .toList(),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<Place> getPlace(int id) async {
    final Place? place = findPlaceInLocal(id);
    if (place != null) {
      return place;
    }
    return await placeRepository.getPlace(id);
  }

  Future<void> addNewPlace(Place place) async {
    await placeRepository.postPlace(place);
    getPlaces();
    notifyListeners();
  }

  Place? findPlaceInLocal(int id) {
    try {
      Place place = _places.firstWhere((element) => element.id == id);
      return place;
    } catch (e) {
      return null;
    }
  }

// ----------------------------------------------------------------------------

  List<Category> get filters => _categories;

  double get radius => _radius / 1000;

  void resetFilters() {
    for (Category filter in _categories) {
      filter.isActive = false;
    }
    notifyListeners();
  }

  void changeFilter(int index) {
    _categories[index].isActive = !_categories[index].isActive;
    getPlaces();
    notifyListeners();
  }

  void changeRange(double radius) {
    _radius = radius;
    getPlaces();
    notifyListeners();
  }

// ----------------------------------------------------------------------------

  List<Intention> get favoritePlaces =>
      _favoritePlaces.where((element) => !element.hasVisited).toList();

  void addToFavorites(int placeId) {
    _favoritePlaces.add(Intention.empty(placeId));
    // notifyListeners();
  }

  void removeFromFavorites(int placeId) {
    _favoritePlaces.remove(findIntentionByPlaceId(placeId));
    // notifyListeners();
  }

  bool isFavorite(int placeId) =>
      _favoritePlaces.contains(findIntentionByPlaceId(placeId));

  void changeFavoriteState(int placeId) {
    isFavorite(placeId)
        ? removeFromFavorites(placeId)
        : addToFavorites(placeId);
    notifyListeners();
  }

  void changeDate(DateTime date, int placeId) {
    final index = _favoritePlaces.indexOf(findIntentionByPlaceId(placeId));
    _favoritePlaces[index].date = date;
    notifyListeners();
  }

  void swapIntention(int fromId, int toId) {
    var fromIntention = findIntentionByPlaceId(fromId);
    var toIntention = findIntentionByPlaceId(toId);
    int fromIndex = _favoritePlaces.indexOf(fromIntention);
    int toIndex = _favoritePlaces.indexOf(toIntention);
    _favoritePlaces[fromIndex] = toIntention;
    _favoritePlaces[toIndex] = fromIntention;
    notifyListeners();
  }

// ----------------------------------------------------------------------------

  List<Intention> get visitedPlaces =>
      _favoritePlaces.where((element) => element.hasVisited).toList();

  void addToVisitedPlaces(int placeId) {
    final index = _favoritePlaces.indexOf(findIntentionByPlaceId(placeId));
    _favoritePlaces[index].hasVisited = !_favoritePlaces[index].hasVisited;
    notifyListeners();
  }

  Intention findIntentionByPlaceId(int placeId) {
    return _favoritePlaces.firstWhere((element) => element.placeId == placeId,
        orElse: () => Intention(placeId: -1));
  }
}
