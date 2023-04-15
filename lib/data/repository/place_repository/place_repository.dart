import 'package:places/domain/model/place.dart';

abstract class PlaceRepository {
  // get filtered places
  Future<List<Place>> getFilteredPlaces({
    double? lng,
    double? lat,
    double? radius,
    List<String>? category,
    String? nameFilter,
  });
  // get place detail
  Future<Place> getPlace(int id);
  //create Post
  Future<Place> postPlace(Place place);
  //load all place
  Future<List<Place>> getAllPlaces();
}
