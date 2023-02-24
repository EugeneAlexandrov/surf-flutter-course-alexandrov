class GetPlaceDto {
  final int id;
  final double lat;
  final double lng;
  final double? distance;
  final String name;
  final String placeType;
  final String description;
  final List<String> urls;

  GetPlaceDto(
    this.id,
    this.lat,
    this.lng,
    this.distance,
    this.name,
    this.placeType,
    this.description,
    this.urls,
  );

  GetPlaceDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lat = json['lat'],
        lng = json['lng'],
        distance = json['distance'],
        name = json['name'],
        placeType = json['placeType'],
        description = json['description'],
        urls = List<String>.from(json['urls']);

  @override
  String toString() {
    return '--> Place: id:$id lat:$lat lng:$lng distance:$distance name:$name place';
  }
}
