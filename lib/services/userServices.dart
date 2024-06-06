import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/admin/bottomnav_admin.dart';
import 'package:kp_manajemen_bengkel/screens/user/bottomnav_user.dart';

// User Register
//email: admin@admin.com password: admin123
//email: manager@manager.com password: manager123
//email: testi123@gmail.com password: testi123

class userLogin {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child("Users");

  Future<void> LoginUser(
      String email, String password, BuildContext context) async {
    try {
      // Melakukan login user
      UserCredential userCredentialLogin = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("UID pengguna: ${userCredentialLogin.user!.uid}");

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
      } else {
        return null;
      }
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

class userRegister {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("Users");

  Future<bool> newUserRegis(String email, String password, String username,
      String number, BuildContext context) async {
    try {
      //Buat Authentication User
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // Simpan data pengguna ke Firebase Realtime Database
      await _databaseReference.child(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'number': number,
        'role': 'User',
      });
      return false;
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
    return true;
  }
}

class UserData {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child("Users");
  Future<Map<dynamic, dynamic>?> getUser() async {
    try {
      String? userId = await getCurrentUserId();
      if (userId != null) {
        DataSnapshot dataSnapshot =
            await _databaseReference.child(userId).get();
        // print(dataSnapshot.value);
        // print(userId);
        // print(dataSnapshot.runtimeType); //Check Type Data
        return dataSnapshot.value as Map<dynamic, dynamic>?;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class username {
//Change Username
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child("Users");
  Future<void> changeUsername(String newUsername) async {
    try {
      String? userId = await getCurrentUserId();
      if (userId != null) {
        await _databaseReference
            .child(userId)
            .update({'username': newUsername});
      }
    } catch (e) {
      print(e);
    }
  }
}

class email {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("Users");

  Future<void> changeEmail(String newEmail) async {
    try {
      String? userId = await getCurrentUserId();
      if (userId != null) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updateEmail(newEmail);
          await _databaseReference.child(userId).update({'email': newEmail});
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // Service to check if current email is valid
  Future<bool> checkCurrentEmail(String currentEmail) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user?.email == currentEmail;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

class phone {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("Users");

//Change Phone Number
  Future<void> changePhoneNumber(String newEmail) async {
    try {
      String? userId = await getCurrentUserId();
      if (userId != null) {
        await _databaseReference.child(userId).update({'number': newEmail});
      }
    } catch (e) {
      print(e);
    }
  }
}

class password {
  //Change Password
  Future<void> changePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkPassword(String password) async {
    try {
      // Mendapatkan pengguna saat ini dari Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Memeriksa kredensial dengan metode reauthenicateWithCredential
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}

//Get CurrentUserID
Future<String?> getCurrentUserId() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user.uid;
  } else {
    return "Error Terhadap User dengan $user";
  }
}
