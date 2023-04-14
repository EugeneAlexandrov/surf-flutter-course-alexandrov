import 'package:places/data/dto/place_dto.dart';

class Place {
  final int id;
  final String name;
  final double lng;
  final double lat;
  final List<String> urls;
  final String description;
  final String placeType;

  Place({
    required this.id,
    required this.name,
    required this.lng,
    required this.lat,
    required this.urls,
    required this.description,
    required this.placeType,
  });

  Place.unpersist({
    required this.name,
    required this.lng,
    required this.lat,
    required this.urls,
    required this.description,
    required this.placeType,
  }) : id = -1;

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        lng = json['lng'],
        lat = json['lat'],
        urls = List<String>.from(json['urls']),
        description = json['description'],
        placeType = json['placeType'];

  Place.fromDto(PlaceDto getPlaceDto)
      : id = getPlaceDto.id,
        name = getPlaceDto.name,
        lng = getPlaceDto.lng,
        lat = getPlaceDto.lat,
        urls = getPlaceDto.urls,
        description = getPlaceDto.description,
        placeType = getPlaceDto.placeType;

  Map<String, dynamic> toJson() => {
        'name': name,
        'lat': lat,
        'lng': lng,
        'placeType': placeType,
        'description': description,
        'urls': urls,
      };

  @override
  String toString() {
    return '--> Place $id $name $lng $lat $description $placeType $description';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || other is Place && id == other.id;
  }

  @override
  int get hashCode => id;
}
