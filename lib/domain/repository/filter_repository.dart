import 'package:places/data/mock_filters.dart';

class FilterRepository{
  var filterList = mockFilters;

  void resetList() {
    filterList = mockFilters;
  }

  void changeFilter(int index) {
    filterList[index].isActive = !filterList[index].isActive;
  }
}
