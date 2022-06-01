import 'package:flutter/material.dart';
import 'package:places/data/mock_filters.dart';
import 'package:places/domain/model/filter.dart';

class FilterRepository with ChangeNotifier {
  final List<Filter> _filters = mockFilters;
  RangeValues _range = const RangeValues(0.5, 5);

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
}
