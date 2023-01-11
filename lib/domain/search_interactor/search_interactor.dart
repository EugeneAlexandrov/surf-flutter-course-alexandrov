import 'package:flutter/material.dart';
import 'package:places/data/repository/place_repository/place_repository.dart';
import 'package:places/domain/model/place.dart';

class SearchInteractor with ChangeNotifier {
  final PlaceRepository placeRepository;

  SearchInteractor(this.placeRepository);

  List<String> searchQueries = <String>[];
  List<Place> searchSightList = <Place>[];

  void findSightsByName(String name) {}

  void deleteSearchQuery(int index) => searchQueries.removeAt(index);

  void clearSearchList() => searchSightList.clear();

  void addQuery(String query) => searchQueries.add(query);

  void clearHistory() => searchQueries.clear();
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
