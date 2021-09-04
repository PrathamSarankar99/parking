import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/parking_area.dart';
import 'package:parking/modals/database_modals/vehicle.dart';
import 'package:parking/screens/bookscreens/display_code.dart';
import 'package:parking/widgets/booking_widgets/vehicle_tile.dart';

class ChooseVehiclesPage extends StatefulWidget {
  const ChooseVehiclesPage({Key key, this.area}) : super(key: key);
  final ParkingArea area;
  @override
  _ChooseVehiclesPageState createState() => _ChooseVehiclesPageState();
}

class _ChooseVehiclesPageState extends State<ChooseVehiclesPage> {
  List<Vehicle> vehicles;

  @override
  void initState() {
    vehicles = dummyVehicles.where((element) => element.isPrimary).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 15),
              child: Text(
                'Choose Vehicles',
                style: GoogleFonts.montserrat(
                  fontSize: 38,
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'For Parking',
                  style: GoogleFonts.montserrat(
                    fontSize: 38,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(bottom: 8, left: 2),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 15, bottom: 10),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: vehicles
                        .map(
                          (e) => VehicleTile(
                            vehicle: e,
                          ),
                        )
                        .toList(),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            Colors.grey.withOpacity(0.1),
                          ),
                          shape: MaterialStateProperty.all(
                            const CircleBorder(),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.add_rounded,
                            size: 40,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
            child: TextButton(
              onPressed: vehicles.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return DisplayCodePage(
                              area: widget.area,
                              vehicles: vehicles,
                            );
                          },
                        ),
                      );
                    },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    vehicles.isEmpty ? Colors.grey.shade500 : Colors.blue),
                fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 50)),
              ),
              child: Text(
                'Done',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
