import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/user/bottomnav_user.dart';

class FavoriteNewsUser extends StatefulWidget {
  const FavoriteNewsUser({super.key});

  @override
  State<FavoriteNewsUser> createState() => _FavoriteNewsUserState();
}

class _FavoriteNewsUserState extends State<FavoriteNewsUser> {
  NavbarUser navbarUser = NavbarUser(); // Buat instance dari NavbarUser

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
