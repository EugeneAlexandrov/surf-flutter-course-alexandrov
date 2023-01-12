import 'package:flutter/material.dart';
import 'package:places/data/repository/place_repository/place_repository.dart';
import 'package:places/domain/model/place.dart';

class SearchInteractor with ChangeNotifier {
  final PlaceRepository placeRepository;

  SearchInteractor(this.placeRepository);

  final List<String> _searchQueries = <String>[];
  List<Place> _searchPlaceList = <Place>[];
  String _actualQuery = '';

  List<String> get queries => _searchQueries;
  Future<List<Place>> get places async {
    if (_actualQuery.isNotEmpty) {
      await findPlacesByName();
    }
    return _searchPlaceList;
  }

  String get actualQuery => _actualQuery;

  Future<void> findPlacesByName() async {
    _searchPlaceList =
        await placeRepository.getFilteredPlaces(nameFilter: actualQuery);
    //notifyListeners();
  }

  void changeQuery(String value) {
    _actualQuery = value;
    notifyListeners();
  }

  void clearSearchList() {
    _searchPlaceList.clear();
    notifyListeners();
  }

  void addSearchQuery(String query) {
    _searchQueries.add(query);
    notifyListeners();
  }

  void deleteSearchQuery(int index) {
    _searchQueries.removeAt(index);
    notifyListeners();
  }

  void clearSearchQueryHistory() {
    _searchQueries.clear();
    notifyListeners();
  }

  void deleteActualQuery() {
    _actualQuery = '';
    notifyListeners();
  }
}

// class SearchRepository with ChangeNotifier {
//   final SightRepository _sightRepository;
//   List<Sight> searchSightList = <Sight>[];
//   List<String> searchQueries = <String>[];

//   SearchRepository(SightRepository sightRepository)
//       : _sightRepository = sightRepository;

//   // SightRepository get sightRepository => _sightRepository;

//   // void updateSightRepository(SightRepository sightRepository) {
//   //   _sightRepository = sightRepository;
//   // }

//   void findSightsByName(String name) {
//     searchSightList = _sightRepository.sights
//         .where((element) => element.name.contains(name))
//         .toList();
//   }

//   void deleteSearchQuery(int index) => searchQueries.removeAt(index);

//   void clearSearchList() => searchSightList.clear();

//   void addQuery(String query) => searchQueries.add(query);

//   void clearHistory() => searchQueries.clear();
// }
