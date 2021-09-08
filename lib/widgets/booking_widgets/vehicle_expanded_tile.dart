import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/vehicle.dart';
import 'package:parking/modals/others/vehicle_type.dart';

class VehicleExpandedTile extends StatefulWidget {
  const VehicleExpandedTile({Key key, this.vehicle}) : super(key: key);
  final Vehicle vehicle;
  @override
  _VehicleExpandedTileState createState() => _VehicleExpandedTileState();
}

class _VehicleExpandedTileState extends State<VehicleExpandedTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Vehicle.changePrimary(widget.vehicle.id);
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10,
          right: widget.vehicle.isPrimary ? 4 : 0,
          left: widget.vehicle.isPrimary ? 4 : 0,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5),
          boxShadow: widget.vehicle.isPrimary
              ? [
                  BoxShadow(
                    color: Colors.blue.shade300,
                    spreadRadius: 0,
                    blurRadius: 5,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            widget.vehicle.type == VehicleType.car
                ? const Icon(
                    CupertinoIcons.car_detailed,
                    size: 80,
                  )
                : Image.asset(
                    'assets/images/motorcycle.png',
                    height: 80,
                  ),
            const SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 10,
                bottom: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.vehicle.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.vehicle.number,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Alert',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: Text(
                        'Are you sure you want to delete ${widget.vehicle.name}? You will not be able to undo this proccess.',
                        style: GoogleFonts.poppins(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            widget.vehicle.delete();
                          },
                          child: Text(
                            'Delete',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.black.withOpacity(
                  0.05,
                )),
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
