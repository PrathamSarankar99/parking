import 'package:firebase_auth/firebase_auth.dart' as frbs;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/modals/database_modals/user.dart';
import 'package:parking/screens/authscreens/authscreen.dart';
import 'package:parking/utils/helpers/toast_helper.dart';
import 'package:parking/widgets/home_widgets/app_drawer.dart';
import 'package:parking/widgets/profile_widgets/edit_profile_tile.dart';
import 'package:parking/widgets/profile_widgets/profile_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key, this.changeTab, this.fullName, this.email})
      : super(key: key);
  final Function(int) changeTab;
  final String fullName;
  final String email;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<ScaffoldState> scaffoldkey;
  TextEditingController nameController;
  TextEditingController mailController;
  @override
  void initState() {
    nameController = TextEditingController(
      text: widget.fullName,
    );
    mailController = TextEditingController(
      text: widget.email,
    );
    scaffoldkey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: AppDrawer(changeTab: widget.changeTab),
      key: scaffoldkey,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: Text(
              'Update your',
              style: GoogleFonts.montserrat(
                fontSize: 38,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'details',
                  style: GoogleFonts.montserrat(
                    fontSize: 38,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(bottom: 8, left: 2),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          EditProfileTile(
            controller: nameController,
            hintText: 'Your full name',
            title: 'Full Name',
          ),
          EditProfileTile(
            controller: mailController,
            hintText: 'your@example.com',
            title: 'Mail Address',
          ),
          ProfileButton(
            text: 'Update',
            onPressed: () {
              updateDetails(nameController.text, mailController.text);
              // print(frbs.FirebaseAuth.instance.currentUser.email);
            },
          ),
        ],
      ),
    );
  }

  updateDetails(String newFullname, String newEmail) async {
    try {
      User user = await User.currentUser();
      if (newFullname != widget.fullName) {
        user.fullName = newFullname;
        if (newFullname.length > 30) {
          showToast('Full name should be less than 30 characters');
          return;
        }
      }
      if (newEmail != widget.email) {
        frbs.User frbsUser = frbs.FirebaseAuth.instance.currentUser;
        await frbsUser.verifyBeforeUpdateEmail(newEmail);
        showToast('A verification link is sent to $newEmail');
        user.emailId = newEmail;
        user.isEmailVerified = true;
      }
      User.updateDataBase(user);
      showToast('Information updated successfully.');
    } on frbs.FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login' || e.code == 'user-token-expired') {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Note',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'In order to change or add a new mail address you need to relogin to the app.',
                style: GoogleFonts.poppins(),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pushReplacement(context, PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const AuthScreen();
                      },
                    ));
                    await frbs.FirebaseAuth.instance.signOut();
                  },
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
        return;
      }
      showCodeToast(e.code);
    }
  }
}
