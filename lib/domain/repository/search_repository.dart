import 'package:flutter/material.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/domain/repository/sight_repository.dart';

class SearchRepository with ChangeNotifier {
  SightRepository _sightRepository = SightRepository();
  List<Sight> searchSightList = <Sight>[];
  List<String> searchQueries = <String>[];

  SightRepository get sightRepository => _sightRepository;

  void updateSightRepository(SightRepository sightRepository) {
    _sightRepository = sightRepository;
  }

  void findSightsByName(String name) {
    searchSightList = _sightRepository.sights
        .where((element) => element.name.contains(name))
        .toList();
  }

  void deleteSearchQuery(int index) => searchQueries.removeAt(index);

  void clearSearchList() => searchSightList.clear();

  void addQuery(String query) => searchQueries.add(query);

  void clearHistory() => searchQueries.clear();
}
