import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking/modals/others/address.dart';

Future<LatLng> getCurrentLocation() async {
  // ignore: unused_local_variable
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  //TODO
  return const LatLng(23.2163, 77.4994);
  // return LatLng(position.latitude, position.longitude);
}

Future<Address> getCurrentAddress() async {
  LatLng location = await getCurrentLocation();
  List<Placemark> placeMarks =
      await placemarkFromCoordinates(location.latitude, location.longitude);
  return Address.fromPlaceMark(placeMarks.last);
}

Future<Address> getAddress(LatLng location) async {
  List<Placemark> placeMarks =
      await placemarkFromCoordinates(location.latitude, location.longitude);
  return Address.fromPlaceMark(placeMarks.last);
}

Future<GeoFirePoint> getCurrenGeoFirePoint() async {
  LatLng location = await getCurrentLocation();
  return GeoFirePoint(location.latitude, location.longitude);
}

Future<GeoFirePoint> getGeoFirePoint(LatLng location) async {
  return GeoFirePoint(location.latitude, location.longitude);
}

geoPointTogeoFirePoint(GeoPoint geoFirePoint) {
  return GeoFirePoint(geoFirePoint.latitude, geoFirePoint.longitude);
}

geoFirePointToLatLng(GeoFirePoint point) {
  return LatLng(point.latitude, point.longitude);
}

Future<Placemark> getCurrentPlaceMark() async {
  LatLng location = await getCurrentLocation();
  List<Placemark> placemark =
      await placemarkFromCoordinates(location.latitude, location.longitude);
  return placemark.last;
}

Future<String> getCurrentAddressString() async {
  try {
    Placemark plcmrk = await getCurrentPlaceMark();
    Address address = Address.fromPlaceMark(plcmrk);
    return "${address.subLocality}, ${address.locality}";
  } on Exception {
    return 'Your location';
  }
}
