import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/user/Services_User.dart';
import 'package:kp_manajemen_bengkel/screens/user/Order_HistoryUser.dart';
import 'package:kp_manajemen_bengkel/screens/user/Options_user/Settings_user_Main.dart';
import 'package:kp_manajemen_bengkel/screens/user/favorite_news.dart';
import 'package:kp_manajemen_bengkel/screens/user/user_home(news).dart';
import 'package:lottie/lottie.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavbarUser extends StatefulWidget {
  @override
  NavbarUserState createState() => NavbarUserState();
}

class NavbarUserState extends State<NavbarUser> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    UserHome(),
    ServicesUser(),
    Order_HistoryUser(),
    AccountUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(231, 229, 93, 1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 1)
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10.0, bottom: 5, left: 30, right: 30),
          child: GNav(
            rippleColor: Color.fromARGB(255, 0, 0, 0)!,
            hoverColor: Color.fromARGB(255, 0, 0, 0)!,
            gap: 6,
            activeColor: Color.fromRGBO(231, 229, 93, 1),
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: const Color.fromARGB(255, 0, 0, 0)!,
            tabBorderRadius: 10,
            color: Colors.black,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.car_crash,
                text: 'Services',
              ),
              GButton(
                icon: Icons.note_alt,
                text: 'Order',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
