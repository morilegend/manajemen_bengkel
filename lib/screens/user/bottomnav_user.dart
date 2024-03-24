import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/admin/admin_home.dart';
import 'package:kp_manajemen_bengkel/screens/admin/laporan_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/settings_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/transaksi_admin.dart';
import 'package:kp_manajemen_bengkel/screens/user/Sewa_)asa_user.dart';
import 'package:kp_manajemen_bengkel/screens/user/history_pesanan_user.dart';
import 'package:kp_manajemen_bengkel/screens/user/settings_user.dart';
import 'package:kp_manajemen_bengkel/screens/user/user_home.dart';

class NavbarUser extends StatefulWidget {
  const NavbarUser({Key? key}) : super(key: key);

  @override
  State<NavbarUser> createState() => _NavbarUserState();
}

class _NavbarUserState extends State<NavbarUser> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const UserHome(),
    const SewaJasaUser(),
    const HistoryPesananUser(),
    const SettingsUser()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 117, 117, 138),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Color(0xffd2d180),
        items: <BottomNavigationBarItem>[
          // Perbaikan untuk BottomNavBar
          BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Icon(Icons.home, color: Colors.yellow)
                  : Icon(Icons.home_outlined, color: Color(0xffd2d180)),
              label: 'Home'),
          // Perbaikan untuk BottomNavBar
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Icon(Icons.car_rental, color: Colors.yellow)
                : Icon(Icons.car_rental_outlined, color: Color(0xffd2d180)),
            label: 'Sewa Jasa',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Icon(Icons.history, color: Colors.yellow)
                : Icon(Icons.history_outlined, color: Color(0xffd2d180)),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Icon(Icons.manage_accounts, color: Colors.yellow)
                : Icon(Icons.manage_accounts_outlined,
                    color: Color(0xffd2d180)),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
