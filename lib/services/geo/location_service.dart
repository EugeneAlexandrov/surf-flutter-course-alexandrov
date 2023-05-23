import 'package:location/location.dart';

class LocationService {
  late LocationData _locationData;
  bool dataIsReady = false;

  LocationData get locationData {
    if (dataIsReady) {
      return _locationData;
    }
    throw GeoServiceException();
  }

  Future<void> initLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    dataIsReady = true;
  }
}

class GeoServiceException implements Exception {
  String getErrorMessage() {
    return 'Ooops, GPS Servise doesn\'t work';
  }
}
