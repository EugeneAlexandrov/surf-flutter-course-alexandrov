import 'package:places/data/dto/place_dto.dart';
import 'package:places/data/dto/places_filter_request_dto.dart';
import 'package:places/data/repository/place_repository/place_repository.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/services/api/api_service.dart';

class PlaceRepositoryImpl with PlaceRepository {
  DioApiService apiservice = DioApiService();

  @override
  Future<List<Place>> getAllPlaces() async {
    return await apiservice.getAllPlaces();
  }

  @override
  Future<List<Place>> getFilteredPlaces({
    double? lng,
    double? lat,
    double? radius,
    List<String>? typeFilter,
    String? nameFilter,
  }) async {
    var requestBody = PlacesFilterRequestDto(
      lng: lng,
      lat: lat,
      radius: radius,
      typeFilter: typeFilter,
      nameFilter: nameFilter,
    );
    List<PlaceDto> filteredPlaces =
        await apiservice.getFilteredPlaces(requestBody);
    return filteredPlaces.map((placeDto) => Place.fromDto(placeDto)).toList();
  }

  @override
  Future<Place> getPlace(int id) async {
    return await apiservice.getPlace(id);
  }

  @override
  void postPlace(Place place) {
    apiservice.createPlace(place);
  }
}
