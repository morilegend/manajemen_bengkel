import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
