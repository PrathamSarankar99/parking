import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/vehicle.dart';
import 'package:parking/modals/others/vehicle_type.dart';

class SearchVehicle extends StatefulWidget {
  const SearchVehicle({Key key}) : super(key: key);

  @override
  _SearchVehicleState createState() => _SearchVehicleState();
}

class _SearchVehicleState extends State<SearchVehicle> {
  TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade900,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          color: Colors.transparent,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: Vehicle.currentUserVehiclesStream(),
              builder: (context, snapshot) {
                List<Vehicle> vehicles = snapshot.hasData
                    ? Vehicle.listFromSnapshot(snapshot.data)
                    : [];
                List<Vehicle> selectedVehicles = vehicles.where((element) {
                  return searchController.text.isEmpty ||
                      element.name.toLowerCase().contains(
                            searchController.text.toLowerCase(),
                          ) ||
                      element.number.toLowerCase().contains(
                            searchController.text.toLowerCase(),
                          );
                }).toList();
                return Column(
                  children: [
                    SafeArea(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          cursorColor: Colors.white,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: TextButton(
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                });
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                  Colors.white.withOpacity(0.05),
                                ),
                                shape: MaterialStateProperty.all(
                                  const CircleBorder(),
                                ),
                              ),
                              child: const Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                                right: 15, left: 15, top: 10),
                            border: InputBorder.none,
                            hintText: 'Search vehicle . . .',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: selectedVehicles
                          .map(
                            (e) => Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context, e);
                                  },
                                  title: Text(
                                    e.name,
                                    style: GoogleFonts.poppins(),
                                  ),
                                  subtitle: Text(
                                    e.number,
                                    style: GoogleFonts.poppins(),
                                  ),
                                  minVerticalPadding: 15,
                                  minLeadingWidth: 45,
                                  leading: e.type == VehicleType.car
                                      ? const Icon(
                                          CupertinoIcons.car_detailed,
                                          color: Colors.black,
                                          size: 40,
                                        )
                                      : Image.asset(
                                          'assets/images/motorcycle.png',
                                          width: 45,
                                        ),
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
