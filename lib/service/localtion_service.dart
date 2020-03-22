import 'package:geolocator/geolocator.dart';

class LocationService {
//  final bool _serviceEnabled;
//  final PermissionStatus _permissionGranted;
//  final LocationData _locationData;
//
//
//  _serviceEnabled = await location.serviceEnabled();
//  if (!_serviceEnabled) {
//  _serviceEnabled = await location.requestService();
//  if (!_serviceEnabled) {
//  return;
//  }
//  }

  Future<String> printCurrentLocation() async {
    Geolocator geoLocator = Geolocator();
    Position position = await geoLocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print("printing current location");
    var list = await geoLocator.placemarkFromCoordinates(
        position.latitude, position.longitude);
    return list.first.country +
        '-' +
        list.first.administrativeArea +
        '-' +
        list.first.thoroughfare +
        '-' +
        list.first.subLocality +
        '-' +
        list.first.postalCode;
  }
}
