import 'package:places/domain/model/filter.dart';
import 'package:places/image_paths.dart';

final List<Filter> mockFilters = [
  Filter(
    title: 'Отель',
    requestTitle: 'hotel',
    iconName: AssetImages.iconHotelFilterPath,
    isActive: false,
  ),
  Filter(
    title: 'Ресторан',
    requestTitle: 'restaurant',
    iconName: AssetImages.iconRestourantFilterPath,
    isActive: false,
  ),
  Filter(
    title: 'Особое место',
    requestTitle: 'other',
    iconName: AssetImages.iconSpecialFilterPath,
    isActive: false,
  ),
  Filter(
    title: 'Парк',
    requestTitle: 'park',
    iconName: AssetImages.iconParkFilterPath,
    isActive: false,
  ),
  Filter(
    title: 'Музей',
    requestTitle: 'museum',
    iconName: AssetImages.iconMuseumFilterPath,
    isActive: false,
  ),
  Filter(
    title: 'Кафе',
    requestTitle: 'cafe',
    iconName: AssetImages.iconCafeFilterPath,
    isActive: false,
  ),
];

String getFilterTitle(String requestTitle) => mockFilters
    .firstWhere((element) => element.requestTitle == requestTitle)
    .title;
