import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking/screens/authscreens/authtabs/logintab.dart';
import 'package:parking/screens/authscreens/authtabs/otptab.dart';
import 'package:parking/screens/homescreens/homescreen.dart';
import 'package:parking/utils/helpers/toast_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking/modals/database_modals/user.dart' as prkng;
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isOTPsent;
  bool issending;
  String verificationId;
  String phoneNo;
  int forceResendingToken;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
  }

  @override
  void initState() {
    isOTPsent = false;
    issending = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isOTPsent
        ? OTPTab(
            onPop: loadBack,
            phoneNo: phoneNo,
            verifyOtp: verifyOTP,
          )
        : LoginTab(
            onOtpRequest: sendOTP,
            isSending: issending,
          );
  }

  loadBack() {
    setState(() {
      issending = false;
      isOTPsent = false;
    });
  }

  verifyOTP(String otp) async {
    try {
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      if (userCredential.additionalUserInfo.isNewUser) {
        uploadUserData(userCredential.user);
      }
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const HomeScreen();
        },
      ));
    } on FirebaseAuthException catch (error) {
      showCodeToast(error.code);
    }
  }

  uploadUserData(User user) {
    var data = prkng.User.fromFirebaseUser(user).toMap();
    FirebaseFirestore.instance.collection('users').doc(user.uid).set(data);
  }

  sendOTP(String phoneNo) {
    setState(() {
      issending = true;
      this.phoneNo = phoneNo;
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        forceResendingToken: forceResendingToken,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          setState(() {
            issending = false;
            isOTPsent = false;
          });
          showCodeToast(error.code);
        },
        codeSent: (verificationId, forceResendingToken) {
          setState(() {
            isOTPsent = true;
            this.verificationId = verificationId;
            this.forceResendingToken = forceResendingToken;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    });
  }
}
