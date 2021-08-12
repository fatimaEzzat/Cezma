// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/model.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation {
  Location location = new Location();
  late bool _serviceEnabled;

  late var _locationData;
  late LocationPermission _permission;
  Future<void> checkLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw (Get.defaultDialog(
            middleText: "الرجاء تفعيل خدمة تحديد المكان", title: "! تنبيه"));
      }
    }
  }

  Future<void> checkLocationPermission() async {
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied ||
          _permission == LocationPermission.deniedForever) {
        throw (Get.defaultDialog(
            middleText: "يجب السماح للتطبيق باستخدام تحديد موقع",
            title: "! تنبيه"));
      }
    }
  }

  Future<String> getLocationName() async {
    await checkLocationService();
    await checkLocationPermission();
    _locationData = await Geolocator.getCurrentPosition();
    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;
    return first.addressLine;
  }
}
