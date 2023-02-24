import 'package:location/location.dart';

class LocationService {
  late LocationData _locationData;

  Future<LocationData> get locationData async {
    var i = await initLocation();
    if (i) {
      return _locationData;
    }
    throw GeoServiceException();
  }

  Future<bool> initLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    _locationData = await location.getLocation();
    return true;
  }
}

class GeoServiceException implements Exception {
  String getErrorMessage() {
    return 'Ooops, GPS Servise doesn\'t work';
  }
}
