import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/admin/bottomnav_admin.dart';
import 'package:kp_manajemen_bengkel/screens/manager/manager_home.dart';
import 'package:kp_manajemen_bengkel/screens/user/bottomnav_user.dart';

class userLogin {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child("Users");

  Future<void> LoginUser(
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
        // Jika Langsung memanggil Ke HomeAdmin --> Maka Navbar Tidak Akan Terbaca
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavbarAdmin()),
        );
      } else if (userRole == 'User') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavbarUser()),
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
        print(e.code);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User Tidak Ditemukan'),
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }
}

// User Register
//email: admin@admin.com password: admin123
//email: manager@manager.com password: manager123
//email: testi123@gmail.com password: testi123

class userRegister {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("Users");

  Future<bool> newUserRegis(String email, String password, String username,
      String number, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // Simpan data pengguna ke Firebase Realtime Database
      await _databaseReference.child(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'number': number,
        'role': 'User',
      });
      return true;
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email Telah Digunakan'),
              duration: Duration(seconds: 4),
            ),
          );
        }
      }
    }
    return false;
  }
}

//Auth Get CurrentUserID
String getCurrentUserId() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.uid;
  } else {
    return 'Anda Belon Login';
  }
}
