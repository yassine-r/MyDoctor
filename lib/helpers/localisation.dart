import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class localisation {
  static Future<Position?> getCurrentLocation() async {
    Position? _currentPosition;
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      // await getAddressFromLatLng(geolocator,);
      print(position.altitude.toString());
      print(position.latitude.toString());
      _currentPosition = position;
    }).catchError((e) {
      print(e);
    });
    return _currentPosition;
  }

  // static Future<String?>? getAddressFromLatLng(
  //     Geolocator geolocator, Position currentPosition) async {
  //   try {
  //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //         currentPosition.latitude, currentPosition.longitude);
  //     Placemark place = p[0];
  //     return "${place.locality}, ${place.postalCode}, ${place.country}";
  //   } catch (e) {
  //     print(e);
  //   }
  //   return null;
  // }
}
