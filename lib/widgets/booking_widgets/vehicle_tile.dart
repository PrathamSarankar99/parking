import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/vehicle.dart';

class VehicleTile extends StatefulWidget {
  const VehicleTile({Key key, this.vehicle, this.onDelete}) : super(key: key);
  final Vehicle vehicle;
  final VoidCallback onDelete;
  @override
  _VehicleTileState createState() => _VehicleTileState();
}

class _VehicleTileState extends State<VehicleTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 10,
              bottom: 15,
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
            onPressed: widget.onDelete,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(
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
    );
  }
}
