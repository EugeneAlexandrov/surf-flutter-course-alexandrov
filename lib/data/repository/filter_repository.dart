import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/data/mock_filters.dart';
import 'package:places/domain/model/filter.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/domain/repository/location_repository.dart';

class FilterRepository with ChangeNotifier {
  final List<Filter> _filters = mockFilters;
  RangeValues _range = const RangeValues(0.5, 5);
  final LocationRepository _locationRepository;

  FilterRepository(LocationRepository locationRepository)
      : _locationRepository = locationRepository;

  // static final FilterRepository _filterRepository =
  //     FilterRepository._privateConstructor();

  // FilterRepository._privateConstructor();

  // factory FilterRepository() {
  //   return _filterRepository;
  // }

  RangeValues get range => _range;

  void resetFilters() {
    for (Filter filter in _filters) {
      filter.isActive = false;
    }
    notifyListeners();
  }

  List<Filter> get allFilters => _filters;

  void changeFilter(int id) {
    getFilterById(id).isActive = !getFilterById(id).isActive;
    notifyListeners();
  }

  Filter getFilterById(int id) {
    return _filters.firstWhere((element) => element.id == id);
  }

  void changeRange(RangeValues newRange) {
    _range = newRange;
    notifyListeners();
  }

  double calculateDistance(Sight sight) {
    var longitude = _locationRepository.locationData?.longitude ?? 0;
    var latitude = _locationRepository.locationData?.latitude ?? 0;
    const ky = 40000 / 360;
    var kx = cos(pi * latitude / 180.0) * ky;
    var dx = (longitude - sight.lon).abs() * kx;
    var dy = (latitude - sight.lat).abs() * ky;
    return sqrt(dx * dx + dy * dy);
  }

  bool inRange(Sight sight) {
    if (_locationRepository.locationData == null) return false;
    var distance = calculateDistance(sight);
    return distance >= range.start && distance <= range.end;
  }
}
