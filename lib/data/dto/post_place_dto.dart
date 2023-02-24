class PostPlaceDto {
  final String name;
  final double lng;
  final double lat;
  final List<String> urls;
  final String description;
  final String placeType;

  PostPlaceDto({
    required this.name,
    required this.lng,
    required this.lat,
    required this.urls,
    required this.description,
    required this.placeType,
  });

  PostPlaceDto.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        lng = json['lng'],
        lat = json['lat'],
        urls = List<String>.from(json['urls']),
        description = json['description'],
        placeType = json['placeType'];

  PostPlaceDto.fromDto(PostPlaceDto getPlaceDto)
      : name = getPlaceDto.name,
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
    return '--> Place $name $lng $lat $description $placeType $description';
  }
}
