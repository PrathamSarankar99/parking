import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/widgets/home_widgets/app_drawer.dart';
import 'package:parking/widgets/profile_widgets/profile_tile.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key key, @required this.changeTab}) : super(key: key);
  final Function(int) changeTab;
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  GlobalKey<ScaffoldState> scaffoldkey;
  User user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              'Good Morning!',
              style: GoogleFonts.montserrat(
                fontSize: 38,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Pratham',
                  style: GoogleFonts.montserrat(
                    fontSize: 35,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(top: 6, left: 5),
                    child: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ProfileTile(
            title: 'Your Mail ID',
            content: user.email,
          ),
          ProfileTile(
            title: 'Your Mail ID',
            content: user.email,
          ),
        ],
      ),
    );
  }
}
