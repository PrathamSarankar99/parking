import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/screens/homescreens/hometabs/find_parking_tab.dart';
import 'package:parking/screens/homescreens/hometabs/parking_history_tab.dart';
import 'package:parking/widgets/home_widgets/app_drawer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key key, @required this.changeTab}) : super(key: key);
  final Function(int) changeTab;
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
      drawer: AppDrawer(
        changeTab: widget.changeTab,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: GoogleFonts.poppins(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            scaffoldkey.currentState.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/graphics/town.svg',
              alignment: Alignment.bottomCenter,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75.0, bottom: 20),
                child: Center(
                  child: Text(
                    "Welcome",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 100,
                    child: Wrap(
                      spacing: MediaQuery.of(context).size.width * 0.05,
                      runSpacing: MediaQuery.of(context).size.width * 0.05,
                      children: [
                        HomeTabCard(
                          text: 'Parking',
                          assetPath: 'assets/images/parking.png',
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return FindParkingTab(
                                  changeTab: widget.changeTab,
                                  isPushed: true,
                                );
                              },
                            ));
                          },
                        ),
                        HomeTabCard(
                          text: 'My Wallet',
                          assetPath: 'assets/images/wallet.png',
                          onTap: () {
                            widget.changeTab(4);
                          },
                        ),
                        HomeTabCard(
                          text: 'My Vehicles',
                          assetPath: 'assets/images/vehicles.png',
                          onTap: () {
                            widget.changeTab(10);
                          },
                        ),
                        HomeTabCard(
                          text: 'History',
                          assetPath: 'assets/images/history.png',
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return ParkingHistoryTab(
                                  changeTab: widget.changeTab,
                                  isPushed: true,
                                );
                              },
                            ));
                          },
                        ),
                      ],
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HomeTabCard extends StatelessWidget {
  const HomeTabCard({Key key, this.text, this.assetPath, @required this.onTap})
      : super(key: key);
  final String text;
  final String assetPath;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.width * 0.30,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 2,
            ),
            Image.asset(
              assetPath,
              height: MediaQuery.of(context).size.width * 0.15,
            ),
            Text(
              text,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
