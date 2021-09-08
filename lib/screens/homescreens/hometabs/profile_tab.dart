import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as frbs;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/user.dart';
import 'package:parking/screens/profilescreens/edit_profile.dart';
import 'package:parking/utils/helpers/toast_helper.dart';
import 'package:parking/widgets/home_widgets/app_drawer.dart';
import 'package:parking/widgets/profile_widgets/profile_button.dart';
import 'package:parking/widgets/profile_widgets/profile_tile.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key key, @required this.changeTab}) : super(key: key);
  final Function(int) changeTab;
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  GlobalKey<ScaffoldState> scaffoldkey;
  @override
  void initState() {
    scaffoldkey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: getStream(),
          builder: (context, snapshot) {
            User user = User.fromMap(
                snapshot.hasData ? snapshot.data.data() : {},
                snapshot.hasData ? snapshot.data.id : '');
            return ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    'Good ${getGreeting()}!',
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
                        user.userName,
                        style: GoogleFonts.montserrat(
                          fontSize: 35,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          TextEditingController controller =
                              TextEditingController(text: user.userName);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Update',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                ),
                                content: TextField(
                                    style: GoogleFonts.poppins(),
                                    controller: controller,
                                    decoration: InputDecoration(
                                      hintText: 'Enter new username',
                                      hintStyle: GoogleFonts.poppins(),
                                    )),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      updateUsername(controller.text, user.id);
                                    },
                                    child: Text(
                                      'Save',
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
                                          MaterialStateProperty.all(
                                              Colors.blue),
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
                ProfileTile(
                  title: 'Full Name',
                  content: user.fullName,
                ),
                ProfileTile(
                  title: 'Your Mail ID',
                  content: user.emailId,
                ),
                ProfileTile(
                  title: 'Your Contact no.',
                  content: user.contactNumber,
                ),
                ProfileButton(
                  text: 'Edit',
                  onPressed: () {
                    Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return EditProfile(
                          email: user.emailId,
                          fullName: user.fullName,
                        );
                      },
                    ));
                  },
                ),
                const SizedBox(height: 50),
                Center(
                  child: SvgPicture.asset(
                    'assets/graphics/working1.svg',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          }),
    );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getStream() {
    String uid = frbs.FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  updateUsername(String username, String uid) {
    if (username.isEmpty) {
      showToast('Enter new Username');
      return;
    }
    if (username.contains(' ')) {
      showToast('Username should not contain whitespaces.');
      return;
    }
    if (username.length > 15) {
      showToast('Username should be less than 15 characters');
      return;
    } else {
      FirebaseFirestore.instance.collection('users').doc(uid).update(
        {
          'userName': username,
        },
      );
      Navigator.pop(context);
    }
  }

  getGreeting() {
    DateTime datime = DateTime.now();
    if (datime.hour >= 0 && datime.hour <= 10) {
      return 'Morning';
    }
    if (datime.hour >= 11 && datime.hour <= 2) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
