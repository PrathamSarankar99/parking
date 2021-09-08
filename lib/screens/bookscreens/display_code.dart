import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/parking_area.dart';
import 'package:parking/modals/database_modals/vehicle.dart';
import 'package:parking/screens/bookscreens/congrats.dart';
import 'package:parking/screens/homescreens/homescreen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DisplayCodePage extends StatefulWidget {
  const DisplayCodePage({
    Key key,
    this.vehicle,
    this.area,
  }) : super(key: key);
  final Vehicle vehicle;
  final ParkingArea area;
  @override
  _DisplayCodePageState createState() => _DisplayCodePageState();
}

class _DisplayCodePageState extends State<DisplayCodePage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
    ));
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Alert',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    content: Text(
                      'This action will terminate the booking process and you will be redirected to the homepage. If you just want to visit the previous page, press cancel followed by back button.',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          SystemChrome.setSystemUIOverlayStyle(
                              const SystemUiOverlayStyle(
                            statusBarColor: Colors.white,
                            statusBarIconBrightness: Brightness.dark,
                          ));
                          Navigator.of(context)
                              .pushReplacement(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const HomeScreen();
                            },
                          ));
                        },
                        child: Text(
                          'Ok',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Container(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.clear,
                size: 20,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      spreadRadius: 3,
                      blurRadius: 10,
                      color: Colors.blue.shade700,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'QR CODE',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: QrImage(
                        data: widget.vehicle.number.toString(),
                        size: MediaQuery.of(context).size.height * 0.30,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          widget.area.name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            text: '₹ ',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: widget.area.charges.toString() + '/6hrs',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.05,
                top: 20,
              ),
              child: Text(
                'Show this QR code to the attendee at the parking area. He will verify your details, then pay from your wallet balance or cash.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            margin: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(left: 6, top: 6, bottom: 6),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 42,
                    color: Colors.blue.shade700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your Wallet',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: RichText(
                          text: TextSpan(
                            text: '₹ ',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: '100',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () async {
                      await Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const CongratsPage();
                        },
                      ));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue,
    );
  }
}
