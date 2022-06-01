import 'dart:math';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/data/mock_sights.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/location_repository.dart';

class SightRepository with ChangeNotifier {
  FilterRepository _filterRepository = FilterRepository();
  late LocationData? _locationData;
  final List<Sight> _sights = List<Sight>.from(mockSights);

  // static final SightRepository _sightRepository =
  //     SightRepository._privateConstructor();

  // SightRepository._privateConstructor();

  // factory SightRepository() {
  //   return _sightRepository;
  // }

  void updateLocation(LocationRepository locationRepository) =>
      _locationData = locationRepository.locationData;

  void updateFilter(FilterRepository filterRepository) {
    _filterRepository = filterRepository;
  }

  List<Sight> get sights {
    if (_locationData == null) {
      return <Sight>[];
    } else {
      return _sights
          .where(
            (element) =>
                _filterRepository.getFilterById(element.filterId).isActive &&
                inRange(element, _locationData, _filterRepository.range),
          )
          .toList();
    }
  }

  Sight getSightById(int id) {
    return _sights.firstWhere((element) => element.id == id);
  }

  void addSight(Sight newSight) {
    _sights.add(newSight);
    notifyListeners();
  }

  double calculateDistance(Sight sight, LocationData location) {
    const ky = 40000 / 360;
    var kx = cos(pi * location.latitude! / 180.0) * ky;
    var dx = (location.longitude! - sight.lon).abs() * kx;
    var dy = (location.latitude! - sight.lat).abs() * ky;
    return sqrt(dx * dx + dy * dy);
  }

  bool inRange(Sight sight, LocationData? location, RangeValues range) {
    if (location == null) return false;
    var distance = calculateDistance(sight, location);
    return distance >= range.start && distance <= range.end;
  }
}
