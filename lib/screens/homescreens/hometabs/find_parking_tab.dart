import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking/modals/database_modals/parking_area.dart';
import 'package:parking/utils/helpers/location_helper.dart';
import 'package:parking/utils/helpers/map_helper.dart';
import 'package:parking/widgets/map_widgets/map_bar.dart';
import 'package:parking/widgets/map_widgets/parking_area_description.dart';

class FindParkingTab extends StatefulWidget {
  const FindParkingTab({
    Key key,
    @required this.changeTab,
    this.isPushed = false,
  }) : super(key: key);
  final Function(int) changeTab;
  final bool isPushed;
  @override
  _FindParkingTabState createState() => _FindParkingTabState();
}

class _FindParkingTabState extends State<FindParkingTab> {
  LatLng initialcameraposition = const LatLng(0, 0);
  GoogleMapController controller;
  GlobalKey<ScaffoldState> globalKey;
  LatLng currentLocation;
  LatLng buildLocation;
  GoogleMapType mapType;
  Set<Marker> markers = {};
  ValueNotifier<double> valueNotifier;
  @override
  void initState() {
    globalKey = GlobalKey<ScaffoldState>();
    mapType = GoogleMapType.normal;
    valueNotifier = ValueNotifier<double>(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.changeTab(0);
        return widget.isPushed;
      },
      child: Scaffold(
        key: globalKey,
        body: ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, __) {
              return FutureBuilder<
                      Stream<List<DocumentSnapshot<Map<String, dynamic>>>>>(
                  future: getStream(value),
                  builder: (context, futureSnapshot) {
                    if (!futureSnapshot.hasData) {
                      return Container();
                    }
                    return StreamBuilder<
                            List<DocumentSnapshot<Map<String, dynamic>>>>(
                        stream: futureSnapshot.data,
                        builder: (context, streamSnapshot) {
                          if (!streamSnapshot.hasData) {
                            return Container();
                          }
                          return SafeArea(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: initialcameraposition),
                                  mapType: googleMapTypeToMapType(mapType),
                                  onMapCreated: _onMapCreated,
                                  markers: getMarkers(streamSnapshot.data),
                                  trafficEnabled: true,
                                  zoomControlsEnabled: false,
                                  myLocationButtonEnabled: false,
                                  zoomGesturesEnabled: true,
                                  myLocationEnabled: true,
                                ),
                                MapBar(
                                  onTap: setCurrentLocation,
                                  noOfParkings: streamSnapshot.data.length,
                                  changeRadius: changeRadius,
                                  radius: valueNotifier.value,
                                  changeMapType: changeMapType,
                                  googleMapType: mapType,
                                ),
                              ],
                            ),
                          );
                        });
                  });
            }),
      ),
    );
  }

  @override
  void dispose() {
    if (controller != null) {
      controller.dispose();
    }
    super.dispose();
  }

  setCurrentLocation() async {
    currentLocation = await getCurrentLocation();
    var cameraPosition = CameraPosition(target: currentLocation, zoom: 14);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  changeRadius(double radius) {
    valueNotifier.value = radius;
  }

  changeMapType(GoogleMapType mapType) {
    setState(() {
      this.mapType = mapType;
    });
  }

  // addArea() async {
  //   String name = 'Cross Highway Parking';
  //   Address address = await getAddress(buildLocation);
  //   GeoFirePoint geoFirePoint = await getGeoFirePoint(buildLocation);
  //   Owner owner = Owner(
  //     contactNumber: '+918269302154',
  //     mailId: 'justin.jhonson@gmail.com',
  //     name: 'Justin Johnson',
  //   );
  //   ParkingArea area = ParkingArea(
  //       location: geoFirePoint, owner: owner, address: address, name: name);
  //   await FirebaseFirestore.instance
  //       .collection('parking_areas')
  //       .add(area.toMap());
  //   print('It is done!');
  // }

  onMarkerTap(ParkingArea area) {
    globalKey.currentState.showBottomSheet(
      (context) => ParkingAreaDescription(
        area: area,
      ),
      backgroundColor: Colors.transparent,
    );

    // showBottomSheet(
    //   context: context,
    //   backgroundColor: Colors.white,
    //   builder: (context) {
    // return Container(
    //   color: Colors.white,
    //   height: 300,
    //   width: MediaQuery.of(context).size.width,
    // );
    //   },
    // );
  }

  Future<Stream<List<DocumentSnapshot<Map<String, dynamic>>>>> getStream(
      double radius) async {
    LatLng location = await getCurrentLocation();
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint center = GeoFirePoint(location.latitude, location.longitude);
    CollectionReference reference =
        FirebaseFirestore.instance.collection('parking_areas');
    return geo.collection(collectionRef: reference).within(
          center: center,
          radius: radius,
          field: 'location',
          strictMode: true,
        );
  }

  Set<Marker> getMarkers(List<DocumentSnapshot<Map<String, dynamic>>> docs) {
    return ParkingArea.documentsToAreaList(docs).map((area) {
      return Marker(
        markerId: MarkerId(
          area.id,
        ),
        position: geoFirePointToLatLng(area.location),
        visible: true,
        onTap: () {
          onMarkerTap(area);
        },
        infoWindow:
            InfoWindow(title: area.name, snippet: area.address.locality),
        alpha: 1,
        rotation: 0,
        icon: BitmapDescriptor.defaultMarker,
      );
    }).toSet();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    controller = _cntlr;
    setCurrentLocation();
  }
}
