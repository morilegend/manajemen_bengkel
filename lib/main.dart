import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kp_manajemen_bengkel/screens/admin/bottomnav_admin.dart';
import 'package:kp_manajemen_bengkel/services/firebase_options.dart';

//Import Screens

//Import Services

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
      home: NavbarAdmin(),
    );
  }
}
