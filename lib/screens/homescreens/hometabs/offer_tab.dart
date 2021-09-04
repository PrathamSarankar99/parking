import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/widgets/home_widgets/app_drawer.dart';

class OfferTab extends StatefulWidget {
  const OfferTab({Key key, @required this.changeTab}) : super(key: key);
  final Function(int) changeTab;
  @override
  _OfferTabState createState() => _OfferTabState();
}

class _OfferTabState extends State<OfferTab> {
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
            scaffoldkey.currentState.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Offer Tab.',
          style: GoogleFonts.poppins(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
