import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key key, @required this.changeTab}) : super(key: key);
  final Function(int) changeTab;
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 60,
                          width: 70,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 3),
                                  spreadRadius: 0.5,
                                  color: Colors.black.withOpacity(0.15),
                                )
                              ]),
                          child: const Icon(
                            Icons.android,
                            color: Colors.blue,
                            size: 45,
                          ),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser.phoneNumber ?? '',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            DrawerTile(
              data: Icons.home_outlined,
              text: 'Home',
              onTap: () {
                widget.changeTab(0);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.person_outline,
              text: 'Profile',
              onTap: () {
                widget.changeTab(1);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.search_outlined,
              text: 'Find Parking',
              onTap: () {
                widget.changeTab(2);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.history,
              text: 'Parking History',
              onTap: () {
                widget.changeTab(3);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.account_balance_wallet_outlined,
              text: 'My Wallet',
              onTap: () {
                widget.changeTab(4);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.local_offer_outlined,
              text: 'Offers',
              onTap: () {
                widget.changeTab(5);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.notifications_outlined,
              text: 'Notification',
              onTap: () {
                widget.changeTab(6);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.settings,
              text: 'Settings',
              onTap: () {
                widget.changeTab(7);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.info_outline,
              text: 'About us',
              onTap: () {
                widget.changeTab(8);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.support_agent,
              text: 'Support',
              onTap: () {
                widget.changeTab(9);
                Navigator.pop(context);
              },
            ),
            DrawerTile(
              data: Icons.exit_to_app,
              text: 'Logout',
              onTap: () {
                setState(() {
                  FirebaseAuth.instance.signOut();
                });
              },
            ),
            SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    '1.0.0',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      letterSpacing: 2,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({Key key, this.text, this.data, this.onTap})
      : super(key: key);
  final String text;
  final IconData data;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 0.5,
          thickness: 0.5,
        ),
        ListTile(
          onTap: () {
            onTap();
          },
          leading: Icon(
            data,
            size: 25,
            color: Colors.black.withOpacity(0.8),
          ),
          title: Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
