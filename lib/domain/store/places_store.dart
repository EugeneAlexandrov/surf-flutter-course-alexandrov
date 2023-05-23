import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:places/data/mock_categories.dart';
import 'package:places/data/repository/place_repository/place_repository.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type.dart';

part 'places_store.g.dart';

class PlacesStore = PlacesStoreBase with _$PlacesStore;

abstract class PlacesStoreBase with Store {
  final PlaceRepository _placeRepository;
  final LocationData _locationData;

  PlacesStoreBase(this._placeRepository, this._locationData);

  @observable
  ObservableFuture<List<Place>>? getPlacesFuture;

  @observable
  double _radius = 500;

  double get radius => _radius / 1000;

  @observable
  ObservableList<PlaceType> _placeTypes =
      ObservableList<PlaceType>.of(mockPlaceTypes);

  List<PlaceType> get placeTypes => _placeTypes.toList();

  @action
  void getPlaces() {
    final future = _placeRepository.getFilteredPlaces(
      lat: _locationData.latitude,
      lng: _locationData.longitude,
      radius: _radius,
      typeFilter: placeTypes
          .where((element) => element.isActive)
          .map((e) => e.requestTitle)
          .toList(),
    );
    getPlacesFuture = ObservableFuture(future);
  }

  @action
  void resetPlaceTypes() {
    for (PlaceType filter in _placeTypes) {
      filter.isActive = false;
    }
    getPlaces();
  }

  @action
  void changePlaceType(int index) {
    _placeTypes[index].isActive = !_placeTypes[index].isActive;
    getPlaces();
  }

  @action
  void changeRange(double radius) {
    _radius = radius;
    getPlaces();
  }
}
