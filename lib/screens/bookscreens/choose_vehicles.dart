import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/parking_area.dart';
import 'package:parking/modals/database_modals/vehicle.dart';
import 'package:parking/modals/others/vehicle_type.dart';
import 'package:parking/screens/bookscreens/display_code.dart';
import 'package:parking/screens/vehiclescreens/search_vehicle.dart';

class ChooseVehiclesPage extends StatefulWidget {
  const ChooseVehiclesPage({Key key, this.area}) : super(key: key);
  final ParkingArea area;
  @override
  _ChooseVehiclesPageState createState() => _ChooseVehiclesPageState();
}

class _ChooseVehiclesPageState extends State<ChooseVehiclesPage> {
  Vehicle vehicle;
  @override
  void initState() {
    Vehicle.getCurrentPrimaryVehicle().then((value) {
      setState(() {
        vehicle = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, -1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Pay ',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: ' ₹',
                      style: GoogleFonts.poppins(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: widget.area.charges.toString(),
                      style: GoogleFonts.poppins(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DisplayCodePage(
                        area: widget.area,
                        vehicle: vehicle,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 10, left: 10),
                  child: Text(
                    'Proceed',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 17,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.32,
              color: Colors.blue,
              // child: PageView.builder(
              //   itemBuilder: (context, index) {
              //     return
              //   },
              // ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: ListView(
                padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
                children: [
                  Text(
                    widget.area.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  FutureBuilder<String>(
                    future: widget.area.getFullAddress(),
                    builder: (context, snapshot) {
                      return RichText(
                        text: TextSpan(
                          text: snapshot.data,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    height: 200,
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            right: 15,
                            left: 15,
                          ),
                          child: Text(
                            'SELECT YOUR VEHICLE',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Vehicle response = await Navigator.push(
                                        context, PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return const SearchVehicle();
                                      },
                                    )) as Vehicle;

                                    if (response != null) {
                                      setState(() {
                                        vehicle = response;
                                      });
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        top: 15,
                                        bottom: 25,
                                        right: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.blue,
                                          size: 35,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Select Vehicle',
                                          style: GoogleFonts.poppins(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (vehicle != null)
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        top: 15,
                                        bottom: 25,
                                        right: 15),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.cyan.shade400,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            child: const Icon(
                                              Icons.check,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Colors.cyan,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            vehicle.type == VehicleType.bike
                                                ? Image.asset(
                                                    'assets/images/motorcycle.png',
                                                    height: 40,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  )
                                                : Icon(
                                                    CupertinoIcons.car_detailed,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    size: 35,
                                                  ),
                                            const SizedBox(height: 5),
                                            Text(
                                              vehicle.name,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              vehicle.number,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black
                                                    .withOpacity(0.7),
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 15, left: 15),
                          child: Text(
                            'Payment Summary',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 18, left: 18, top: 20),
                          child: Row(
                            children: [
                              Text(
                                'Parking charges',
                                style: GoogleFonts.poppins(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              RichText(
                                text: TextSpan(
                                  text: '₹ ',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.area.charges.toString(),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 18, left: 18),
                          child: Divider(
                            height: 40,
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, bottom: 20),
                          child: Row(
                            children: [
                              Text(
                                "Grand Total",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              RichText(
                                text: TextSpan(
                                  text: '₹ ',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.area.charges.toString(),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<Vehicle>>(
//           future: Vehicle.getCurrentPrimaryVehicles(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData && firstTime) {
//               selectedVehicles.addAll(snapshot.data);
//               firstTime = false;
//             }
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 50, left: 15),
//                     child: Text(
//                       'Choose Vehicles',
//                       style: GoogleFonts.montserrat(
//                         fontSize: 38,
//                         color: Colors.black.withOpacity(0.8),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5, left: 15),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         'For Parking',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 38,
//                           color: Colors.black.withOpacity(0.8),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Container(
//                         width: 10,
//                         height: 10,
//                         margin: const EdgeInsets.only(bottom: 8, left: 2),
//                         decoration: const BoxDecoration(
//                           color: Colors.blue,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         right: 15, left: 15, top: 15, bottom: 10),
//                     child: ListView(
//                       padding: EdgeInsets.zero,
//                       children: [
//                         Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: selectedVehicles
//                               .map(
//                                 (e) => VehicleTile(
//                                   vehicle: e,
//                                   onDelete: () {
//                                     setState(() {
//                                       selectedVehicles.remove(e);
//                                     });
//                                   },
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                         Container(
//                           height: 100,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(10)),
//                           ),
//                           child: Center(
//                             child: TextButton(
//                               onPressed: () async {
//                                 Vehicle response = await showCupertinoDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return const SearchVehicle();
//                                   },
//                                 ) as Vehicle;

//                                 if (response != null &&
//                                     !selectedVehicles.contains(response)) {
//                                   setState(() {
//                                     selectedVehicles.add(response);
//                                   });
//                                 }
//                               },
//                               style: ButtonStyle(
//                                 overlayColor: MaterialStateProperty.all(
//                                   Colors.grey.withOpacity(0.1),
//                                 ),
//                                 shape: MaterialStateProperty.all(
//                                   const CircleBorder(),
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Icon(
//                                   Icons.add_rounded,
//                                   size: 40,
//                                   color: Colors.grey.shade800,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(right: 15, left: 15, bottom: 10),
//                   child: TextButton(
//                     onPressed: selectedVehicles.isEmpty
//                         ? null
//                         : () {
//                             Navigator.push(
//                               context,
//                               PageRouteBuilder(
//                                 pageBuilder:
//                                     (context, animation, secondaryAnimation) {
//                                   return DisplayCodePage(
//                                     area: widget.area,
//                                     vehicles: selectedVehicles,
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                           selectedVehicles.isEmpty
//                               ? Colors.grey.shade500
//                               : Colors.blue),
//                       fixedSize: MaterialStateProperty.all(
//                           Size(MediaQuery.of(context).size.width, 50)),
//                     ),
//                     child: Text(
//                       'Done',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             );
//           }),
//     );
//   }
