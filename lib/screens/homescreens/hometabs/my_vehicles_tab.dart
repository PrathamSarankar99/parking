import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/vehicle.dart';
import 'package:parking/screens/vehiclescreens/add_vehicle_page.dart';
import 'package:parking/widgets/booking_widgets/vehicle_expanded_tile.dart';
import 'package:parking/widgets/home_widgets/app_drawer.dart';

class MyVehiclesTab extends StatefulWidget {
  const MyVehiclesTab({Key key, @required this.changeTab}) : super(key: key);
  final Function(int) changeTab;
  @override
  _MyVehiclesTabState createState() => _MyVehiclesTabState();
}

class _MyVehiclesTabState extends State<MyVehiclesTab> {
  GlobalKey<ScaffoldState> scaffoldkey;

  @override
  void initState() {
    scaffoldkey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const AddVehicle();
              },
            ));
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              Colors.grey.withOpacity(0.1),
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
      drawer: AppDrawer(changeTab: widget.changeTab),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 15),
              child: Text(
                'Your Vehicles',
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
                  'Catalogue',
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
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 10, left: 15, right: 50),
            child: Text(
              'Double tap on any vehicle to make it primary.',
              style: GoogleFonts.montserrat(
                color: Colors.black.withOpacity(0.5),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: Vehicle.currentUserVehiclesStream(),
              builder: (context, snapshot) {
                List<Vehicle> vehicleList = snapshot.hasData
                    ? Vehicle.listFromSnapshot(snapshot.data)
                    : [];
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 15, left: 15, top: 15, bottom: 10),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: vehicleList
                              .map(
                                (e) => VehicleExpandedTile(
                                  vehicle: e,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
