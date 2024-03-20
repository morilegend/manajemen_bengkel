import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kp_manajemen_bengkel/services/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Import Screens
import 'package:kp_manajemen_bengkel/screens/admin/admin_home.dart';
import 'package:kp_manajemen_bengkel/screens/mainscreen/login.dart';
import 'package:kp_manajemen_bengkel/screens/manager/manager_home.dart';
import 'package:kp_manajemen_bengkel/screens/user/user_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Check DefaultOptions
    //options: DefaultFirebaseOptions.android,
    //options: DefaultFirebaseOptions.ios,
    // options: DefaultFirebaseOptions.web,
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
