import 'package:flutter/material.dart';
import 'package:places/data/mock_sights.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/domain/repository/filter_repository.dart';

class SightRepository with ChangeNotifier {
  final FilterRepository _filterRepository;
  // late LocationData? _locationData;
  final List<Sight> _sights = List<Sight>.from(mockSights);

  SightRepository(FilterRepository filterRepository)
      : _filterRepository = filterRepository;

  // void updateLocation(LocationRepository locationRepository) =>
  //     _locationData = locationRepository.locationData;

  // void updateFilter(FilterRepository filterRepository) {
  //   _filterRepository = filterRepository;
  // }

  FilterRepository get filterRepository => _filterRepository;

  List<Sight> get sights {
    return _sights
        .where(
          (element) =>
              _filterRepository.getFilterById(element.filterId).isActive &&
              _filterRepository.inRange(element),
          // inRange(element, _locationData, _filterRepository.range),
        )
        .toList();
  }

  Sight getSightById(int id) {
    return _sights.firstWhere((element) => element.id == id);
  }

  void addSight(Sight newSight) {
    _sights.add(newSight);
    notifyListeners();
  }
}
