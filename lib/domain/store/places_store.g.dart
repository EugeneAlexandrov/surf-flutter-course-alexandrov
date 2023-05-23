// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlacesStore on PlacesStoreBase, Store {
  late final _$getPlacesFutureAtom =
      Atom(name: 'PlacesStoreBase.getPlacesFuture', context: context);

  @override
  ObservableFuture<List<Place>>? get getPlacesFuture {
    _$getPlacesFutureAtom.reportRead();
    return super.getPlacesFuture;
  }

  @override
  set getPlacesFuture(ObservableFuture<List<Place>>? value) {
    _$getPlacesFutureAtom.reportWrite(value, super.getPlacesFuture, () {
      super.getPlacesFuture = value;
    });
  }

  late final _$_radiusAtom =
      Atom(name: 'PlacesStoreBase._radius', context: context);

  @override
  double get _radius {
    _$_radiusAtom.reportRead();
    return super._radius;
  }

  @override
  set _radius(double value) {
    _$_radiusAtom.reportWrite(value, super._radius, () {
      super._radius = value;
    });
  }

  late final _$_placeTypesAtom =
      Atom(name: 'PlacesStoreBase._placeTypes', context: context);

  @override
  ObservableList<PlaceType> get _placeTypes {
    _$_placeTypesAtom.reportRead();
    return super._placeTypes;
  }

  @override
  set _placeTypes(ObservableList<PlaceType> value) {
    _$_placeTypesAtom.reportWrite(value, super._placeTypes, () {
      super._placeTypes = value;
    });
  }

  late final _$PlacesStoreBaseActionController =
      ActionController(name: 'PlacesStoreBase', context: context);

  @override
  void getPlaces() {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.getPlaces');
    try {
      return super.getPlaces();
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetPlaceTypes() {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.resetPlaceTypes');
    try {
      return super.resetPlaceTypes();
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePlaceType(int index) {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.changePlaceType');
    try {
      return super.changePlaceType(index);
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeRange(double radius) {
    final _$actionInfo = _$PlacesStoreBaseActionController.startAction(
        name: 'PlacesStoreBase.changeRange');
    try {
      return super.changeRange(radius);
    } finally {
      _$PlacesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getPlacesFuture: ${getPlacesFuture}
    ''';
  }
}
