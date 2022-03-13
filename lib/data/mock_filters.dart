import 'package:places/domain/model/filter.dart';
import 'package:places/image_paths.dart';

final List<Filter> mockFilters = [
  Filter(
    id: 0,
    title: 'Отель',
    iconName: AssetImages.iconHotelFilterPath,
    isActive: false,
  ),
  Filter(
    id: 1,
    title: 'Ресторан',
    iconName: AssetImages.iconRestourantFilterPath,
    isActive: false,
  ),
  Filter(
    id: 2,
    title: 'Особое место',
    iconName: AssetImages.iconSpecialFilterPath,
    isActive: false,
  ),
  Filter(
    id: 3,
    title: 'Парк',
    iconName: AssetImages.iconParkFilterPath,
    isActive: false,
  ),
  Filter(
    id: 4,
    title: 'Музей',
    iconName: AssetImages.iconMuseumFilterPath,
    isActive: false,
  ),
  Filter(
    id: 5,
    title: 'Кафе',
    iconName: AssetImages.iconCafeFilterPath,
    isActive: false,
  ),
];
