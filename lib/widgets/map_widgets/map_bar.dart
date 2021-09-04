import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking/modals/others/address.dart';
import 'package:parking/utils/helpers/location_helper.dart';
import 'package:parking/utils/helpers/map_helper.dart';
import 'package:parking/widgets/map_widgets/bottom_sheet.dart';

class MapBar extends StatefulWidget {
  const MapBar(
      {Key key,
      this.onTap,
      this.noOfParkings = 0,
      this.changeRadius,
      this.radius,
      this.changeMapType,
      this.googleMapType})
      : super(key: key);
  final int noOfParkings;
  final VoidCallback onTap;
  final double radius;
  final GoogleMapType googleMapType;
  final Function(double) changeRadius;
  final Function(GoogleMapType) changeMapType;
  @override
  _MapBarState createState() => _MapBarState();
}

class _MapBarState extends State<MapBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        height: 68,
        padding: const EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  spreadRadius: 0,
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.3)),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.onTap();
            },
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.location_pin,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          contentPadding: EdgeInsets.zero,
          title: FutureBuilder<String>(
              future: getCurrentAddressString(),
              builder: (context, snapshot) {
                return Text(
                  !snapshot.hasData ? 'Your location' : snapshot.data,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
          subtitle: Text(
            widget.noOfParkings == 0
                ? 'No parkings near you.'
                : '${widget.noOfParkings} parkings near you',
            style: GoogleFonts.poppins(),
          ),
          trailing: IconButton(
            onPressed: () {
              showBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => MapBottomSheet(
                  changeRadius: widget.changeRadius,
                  value: widget.radius,
                  googleMapType: widget.googleMapType,
                  changeMapType: widget.changeMapType,
                ),
              );
            },
            icon: const Icon(
              Icons.more_vert,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
