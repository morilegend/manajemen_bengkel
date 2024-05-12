import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kp_manajemen_bengkel/screens/detail_screens/news_detailScreenUser.dart';
import 'package:kp_manajemen_bengkel/screens/user/bottomnav_user.dart';
import 'package:kp_manajemen_bengkel/screens/user/user_home(news).dart';
import 'package:kp_manajemen_bengkel/services/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Import Screens
import 'package:kp_manajemen_bengkel/screens/mainscreen/login.dart';

//Import Services
import 'package:kp_manajemen_bengkel/services/user.dart';

//Jangan Lupa Add MultiDex --> build.gradle

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
    return MaterialApp(
      // Dark Theme Mode.........
      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      // ),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
