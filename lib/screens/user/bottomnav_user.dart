import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/user/Services_User.dart';
import 'package:kp_manajemen_bengkel/screens/user/Order_User.dart';
import 'package:kp_manajemen_bengkel/screens/user/Account_User.dart';
import 'package:kp_manajemen_bengkel/screens/user/news_detailScreen.dart';
import 'package:kp_manajemen_bengkel/screens/user/user_home(news).dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:lottie/lottie.dart';

class NavbarUser extends StatefulWidget {
  const NavbarUser({Key? key}) : super(key: key);

  @override
  State<NavbarUser> createState() => _NavbarUserState();
}

class _NavbarUserState extends State<NavbarUser> {
  PersistentTabController _controller = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        navBarHeight: 60,
        decoration: NavBarDecoration(
          colorBehindNavBar: Color.fromRGBO(231, 229, 93, 1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 5)
          ],
        ),
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        context,
        controller: _controller,
        screens: [
          UserHome(),
          ServicesUser(),
          OrderUsers(),
          AccountUser(),
        ],
        hideNavigationBar: false,
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style10,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.black,
        activeColorSecondary: Color.fromRGBO(231, 229, 93, 1),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.car_crash),
        title: ("Services"),
        activeColorPrimary: Colors.black,
        activeColorSecondary: Color.fromRGBO(231, 229, 93, 1),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.note_alt_sharp),
        title: ("Order"),
        activeColorPrimary: Colors.black,
        activeColorSecondary: Color.fromRGBO(231, 229, 93, 1),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Account"),
        activeColorPrimary: Colors.black,
        activeColorSecondary: Color.fromRGBO(231, 229, 93, 1),
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }
}
