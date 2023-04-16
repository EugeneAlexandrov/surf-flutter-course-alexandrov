import 'package:places/domain/model/place_type.dart';
import 'package:places/image_paths.dart';

final List<PlaceType> mockPlaceTypes = [
  PlaceType(
    title: 'Отель',
    requestTitle: 'hotel',
    iconName: AssetImages.iconHotelFilterPath,
    isActive: false,
  ),
  PlaceType(
    title: 'Ресторан',
    requestTitle: 'restaurant',
    iconName: AssetImages.iconRestourantFilterPath,
    isActive: false,
  ),
  PlaceType(
    title: 'Особое место',
    requestTitle: 'other',
    iconName: AssetImages.iconSpecialFilterPath,
    isActive: false,
  ),
  PlaceType(
    title: 'Парк',
    requestTitle: 'park',
    iconName: AssetImages.iconParkFilterPath,
    isActive: false,
  ),
  PlaceType(
    title: 'Музей',
    requestTitle: 'museum',
    iconName: AssetImages.iconMuseumFilterPath,
    isActive: false,
  ),
  PlaceType(
    title: 'Кафе',
    requestTitle: 'cafe',
    iconName: AssetImages.iconCafeFilterPath,
    isActive: false,
  ),
];

String getFilterTitle(String requestTitle) => mockPlaceTypes
    .firstWhere((element) => element.requestTitle == requestTitle,
        orElse: () => PlaceType(
            title: requestTitle,
            requestTitle: requestTitle,
            iconName: '',
            isActive: false))
    .title;
