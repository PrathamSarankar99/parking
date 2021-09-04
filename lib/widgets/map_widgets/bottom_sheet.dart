import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/utils/helpers/map_helper.dart';

class MapBottomSheet extends StatefulWidget {
  const MapBottomSheet(
      {Key key,
      this.changeRadius,
      @required this.value,
      this.changeMapType,
      this.googleMapType})
      : super(key: key);
  final Function changeRadius;
  final double value;
  final GoogleMapType googleMapType;
  final Function(GoogleMapType) changeMapType;
  @override
  _MapBottomSheetState createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends State<MapBottomSheet> {
  double radius;
  GoogleMapType mapType;
  @override
  void initState() {
    mapType = widget.googleMapType;
    radius = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, right: 15, left: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              'Radius',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.blue,
                inactiveTrackColor: Colors.blue.shade200,
                trackShape: const RoundedRectSliderTrackShape(),
                trackHeight: 4.0,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: Colors.blue,
                overlayColor: Colors.blue.withOpacity(0.3),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 1.0),
                tickMarkShape: const RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.blue,
                inactiveTickMarkColor: Colors.blue,
                valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.blue,
                valueIndicatorTextStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Slider(
                value: radius,
                min: 1,
                max: 5,
                divisions: 40,
                label: 'Under $radius kms',
                onChanged: (value) {
                  setState(() {
                    radius = value;
                  });
                  widget.changeRadius(value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Map Type',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: GoogleMapType.values.map((e) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      mapType = e;
                    });
                    widget.changeMapType(e);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    margin:
                        const EdgeInsets.only(top: 15, bottom: 25, right: 10),
                    decoration: BoxDecoration(
                      color: mapType == e
                          ? Colors.blue.shade50
                          : Colors.grey.shade100,
                      border: Border.all(
                        color: mapType == e ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        mapTypesToString(e),
                        style: GoogleFonts.poppins(
                          color: mapType == e ? Colors.blue : Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
