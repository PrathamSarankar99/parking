import 'package:google_maps_flutter/google_maps_flutter.dart';

String mapTypesToString(GoogleMapType mapType) {
  switch (mapType) {
    case GoogleMapType.normal:
      return 'Normal';
      break;
    case GoogleMapType.terrain:
      return 'Terrain';
      break;
    case GoogleMapType.sattelite:
      return 'Sattelite';
      break;
    case GoogleMapType.hybrid:
      return 'Hybrid';
      break;
  }
}

enum GoogleMapType {
  normal,
  terrain,
  sattelite,
  hybrid,
}

MapType googleMapTypeToMapType(GoogleMapType mapType) {
  switch (mapType) {
    case GoogleMapType.normal:
      return MapType.normal;
      break;
    case GoogleMapType.terrain:
      return MapType.terrain;
      break;
    case GoogleMapType.sattelite:
      return MapType.satellite;
      break;
    case GoogleMapType.hybrid:
      return MapType.hybrid;
      break;
  }
}
