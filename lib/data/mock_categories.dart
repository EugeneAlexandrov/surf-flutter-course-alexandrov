import 'package:places/domain/model/category.dart';
import 'package:places/image_paths.dart';

final List<Category> mockCategories = [
  Category(
    title: 'Отель',
    requestTitle: 'hotel',
    iconName: AssetImages.iconHotelFilterPath,
    isActive: false,
  ),
  Category(
    title: 'Ресторан',
    requestTitle: 'restaurant',
    iconName: AssetImages.iconRestourantFilterPath,
    isActive: false,
  ),
  Category(
    title: 'Особое место',
    requestTitle: 'other',
    iconName: AssetImages.iconSpecialFilterPath,
    isActive: false,
  ),
  Category(
    title: 'Парк',
    requestTitle: 'park',
    iconName: AssetImages.iconParkFilterPath,
    isActive: false,
  ),
  Category(
    title: 'Музей',
    requestTitle: 'museum',
    iconName: AssetImages.iconMuseumFilterPath,
    isActive: false,
  ),
  Category(
    title: 'Кафе',
    requestTitle: 'cafe',
    iconName: AssetImages.iconCafeFilterPath,
    isActive: false,
  ),
];

String getFilterTitle(String requestTitle) => mockCategories
    .firstWhere((element) => element.requestTitle == requestTitle,
        orElse: () => Category(
            title: requestTitle,
            requestTitle: requestTitle,
            iconName: '',
            isActive: false))
    .title;
