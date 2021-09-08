import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as frbs;

class User {
  final String id;
  final String userName;
  String fullName;
  final String contactNumber;
  String emailId;
  bool isEmailVerified;
  final double walletBalance;

  User({
    this.id,
    this.userName,
    this.fullName,
    this.contactNumber,
    this.emailId,
    this.isEmailVerified,
    this.walletBalance,
  });

  static User fromFirebaseUser(frbs.User user) {
    return User(
      contactNumber: user.phoneNumber,
      emailId: user.email ?? 'your@example.com',
      id: user.uid,
      isEmailVerified: user.emailVerified ?? false,
      userName: user.displayName ?? 'Username',
      fullName: user.displayName ?? 'Your full name',
      walletBalance: 0,
    );
  }

  static User fromMap(Map<String, dynamic> map, String uid) {
    if (map.isEmpty) {
      return User(
        userName: 'Username',
        fullName: 'Full Name',
        id: uid,
        contactNumber: 'Contact Number',
        emailId: 'Mail Address',
        isEmailVerified: false,
        walletBalance: 0,
      );
    }
    return User(
      userName: map['userName'],
      fullName: map['fullName'],
      id: uid,
      contactNumber: map['contactNumber'],
      emailId: map['emailId'],
      isEmailVerified: map['isEmailVerified'],
      walletBalance: map['walletBalance'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'fullName': fullName,
      'contactNumber': contactNumber,
      'emailId': emailId,
      'isEmailVerified': isEmailVerified,
      'walletBalance': walletBalance,
    };
  }

  static Future<User> currentUser() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(frbs.FirebaseAuth.instance.currentUser.uid)
        .get();
    return User.fromMap(snapshot.data(), snapshot.id);
  }

  static updateDataBase(User user) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update(user.toMap());
  }
}
