import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/parking_area.dart';
import 'package:parking/screens/bookscreens/choose_vehicles.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingAreaDescription extends StatefulWidget {
  const ParkingAreaDescription({Key key, @required this.area})
      : super(key: key);
  final ParkingArea area;
  @override
  _ParkingAreaDescriptionState createState() => _ParkingAreaDescriptionState();
}

class _ParkingAreaDescriptionState extends State<ParkingAreaDescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
        right: 10,
        left: 10,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'PHOTO',
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.40,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.35),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Icon(
                    Icons.photo_library_outlined,
                    size: 60,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.40,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 5),
                        child: Text(
                          widget.area.name,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      FutureBuilder<String>(
                        future: widget.area.getFullAddress(),
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 5, top: 2, bottom: 5),
                            child: Text(
                              !snapshot.hasData
                                  ? 'Fetching address ...'
                                  : snapshot.data,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: RichText(
                          text: TextSpan(
                            text: '₹ ',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            children: [
                              TextSpan(
                                text: widget.area.charges.toString() + '/6hrs',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            right: 5, left: 5, bottom: 5, top: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextButton(
                                  onPressed: () {
                                    launch(
                                        'tel:${widget.area.owner.contactNumber}');
                                  },
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                      const Size(100, 100),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.green),
                                  ),
                                  child: const Icon(
                                    Icons.phone_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return ChooseVehiclesPage(
                                          area: widget.area,
                                        );
                                      },
                                    ));
                                  },
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                      const Size(100, 100),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                    shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Proceed',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
