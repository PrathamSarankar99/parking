import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/widgets/home_widgets/app_drawer.dart';

class ParkingHistoryTab extends StatefulWidget {
  const ParkingHistoryTab(
      {Key key, @required this.changeTab, this.isPushed = false})
      : super(key: key);
  final Function(int) changeTab;
  final bool isPushed;
  @override
  _OfferTabState createState() => _OfferTabState();
}

class _OfferTabState extends State<ParkingHistoryTab> {
  GlobalKey<ScaffoldState> scaffoldkey;

  @override
  void initState() {
    scaffoldkey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: AppDrawer(changeTab: widget.changeTab),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            widget.isPushed
                ? Navigator.pop(context)
                : scaffoldkey.currentState.openDrawer();
          },
          icon: widget.isPushed
              ? const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
        ),
      ),
      body: Center(
        child: Text(
          'History Tab.',
          style: GoogleFonts.poppins(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
