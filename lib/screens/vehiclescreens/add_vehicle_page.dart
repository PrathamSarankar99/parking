import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/vehicle.dart';
import 'package:parking/modals/others/vehicle_type.dart';
import 'package:parking/utils/helpers/toast_helper.dart';
import 'package:parking/widgets/profile_widgets/profile_button.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key key}) : super(key: key);

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  bool isCar;
  bool isPrimary;
  TextEditingController nameController;
  TextEditingController numberController;
  @override
  void initState() {
    nameController = TextEditingController();
    numberController = TextEditingController();
    isCar = true;
    isPrimary = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Text(
                'Register your new vehicle.',
                style: GoogleFonts.montserrat(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
            child: Text(
              'Note - A primary vehicle is auto choosen everytime you find parking near you.',
              style: GoogleFonts.montserrat(
                color: Colors.black.withOpacity(0.5),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10, top: 20),
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, right: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: nameController,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: 'Enter a Name',
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 5, left: 0),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCar = !isCar;
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 50,
                      child: isCar
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Icon(
                                CupertinoIcons.car_detailed,
                                size: 35,
                                color: Colors.white,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Image.asset(
                                'assets/images/motorcycle.png',
                                color: Colors.white,
                              ),
                            ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10, top: 0),
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, right: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: numberController,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.black.withOpacity(0.8),
              ),
              decoration: InputDecoration(
                hintText: 'DC - 3C - BF - 3907',
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding:
                    const EdgeInsets.only(top: 10, bottom: 5, left: 0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 6, top: 10),
            child: Row(
              children: [
                Checkbox(
                  value: isPrimary,
                  fillColor: MaterialStateProperty.all(Colors.blue),
                  onChanged: (value) {
                    setState(() {
                      isPrimary = !isPrimary;
                    });
                  },
                ),
                Text(
                  'Primary',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          ProfileButton(
            text: 'Add',
            topPadding: 10,
            onPressed: () async {
              Navigator.pop(context);
              String id = await Vehicle(
                name: nameController.text,
                isPrimary: isPrimary,
                number: numberController.text,
                user: FirebaseAuth.instance.currentUser.uid,
                type: isCar ? VehicleType.car : VehicleType.bike,
              ).add();
              showToast('Vehicle added successfully.');
              if (isPrimary) {
                Vehicle.changePrimary(id);
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          SvgPicture.asset(
            'assets/graphics/parking.svg',
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
