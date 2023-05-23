import 'package:mobx/mobx.dart';

part 'place_type.g.dart';

class PlaceType = _PlaceType with _$PlaceType;

abstract class _PlaceType with Store {
  String title;
  String requestTitle;
  @observable
  bool isActive;
  String iconName;

  _PlaceType({
    required this.title,
    required this.requestTitle,
    required this.isActive,
    required this.iconName,
  });

  @override
  String toString() {
    return '$requestTitle $isActive';
  }
}
