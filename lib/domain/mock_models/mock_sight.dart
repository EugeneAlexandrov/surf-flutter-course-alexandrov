import 'package:places/domain/mock_models/place_image.dart';

class MockSight {
  final int id;
  final String name;
  final double lon;
  final double lat;
  final String? url;
  final String details;
  final int filterId;
  final List<PlaceImage> images;

  static final Set<int> idList = {0, 1, 2, 3, 4, 5, 6, 7, 8};

  MockSight(
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

  MockSight.withId(
      {required this.id,
      required this.name,
      required this.lon,
      required this.lat,
      required this.url,
      required this.details,
      required this.filterId,
      required this.images});
}
