import 'package:places/domain/model/place_image.dart';

class Sight {
  final int id;
  final String name;
  final double lon;
  final double lat;
  final String? url;
  final String details;
  final int filterId;
  final List<PlaceImage> images;

  static final Set<int> idList = {0, 1, 2, 3, 4, 5, 6, 7, 8};

  Sight(
      {required this.name,
      required this.lon,
      required this.lat,
      this.url,
      required this.details,
      required this.filterId,
      required this.images})
      : id = idList.last + 1 {
    idList.add(id);
  }

  Sight.withId(
      {required this.id,
      required this.name,
      required this.lon,
      required this.lat,
      required this.url,
      required this.details,
      required this.filterId,
      required this.images});
}
