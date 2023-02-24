import 'package:places/data/dto/post_place_dto.dart';
import 'package:places/domain/model/place.dart';

abstract class PlaceRepository {
  // get filtered places
  Future<List<Place>> getFilteredPlaces({
    double? lng,
    double? lat,
    double? radius,
    List<String>? typeFilter,
    String? nameFilter,
  });
  // get place detail
  Future<Place> getPlace(int id);
  //create Post
  Future<Place> postPlace(PostPlaceDto place);
  //load all place
  Future<List<Place>> getAllPlaces();
}
