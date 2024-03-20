import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/admin/admin_home.dart';
import 'package:kp_manajemen_bengkel/screens/manager/manager_home.dart';
import 'package:kp_manajemen_bengkel/screens/user/user_home.dart';

class userLogin {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child("Users");

  Future<void> newUserLogin(
      String email, String password, BuildContext context) async {
    try {
      // Melakukan login user
      UserCredential userCredentialLogin = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Mengambil data user dari database
      DataSnapshot dataRole = (await _databaseReference
              .child(userCredentialLogin.user!.uid)
              .child("role")
              .once())
          .snapshot;
      //Pengecekan Role berdasarkan role yang ada di database
      String userRole = dataRole.value.toString();
      if (userRole == 'Admin') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
      } else if (userRole == 'User') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserHome()),
        );
      } else if (userRole == 'Manager') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ManagerHome()),
        );
      } else {
        return null;
      }

      // Catch Error Belum Terbaca
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "user-not-found") {
          print("User Not Found");
        }
      }
    }
  }
}
