import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/admin/admin_home.dart';
import 'package:kp_manajemen_bengkel/screens/admin/laporan_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/settings_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/transaksi_admin.dart';

class NavbarAdmin extends StatefulWidget {
  const NavbarAdmin({Key? key}) : super(key: key);

  @override
  State<NavbarAdmin> createState() => _NavbarAdminState();
}

class _NavbarAdminState extends State<NavbarAdmin> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AdminHome(),
    const LaporanHomeAdmin(),
    const TransaksiHomeAdmin(),
    const SettingsAdmin()
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
                ? Icon(Icons.sticky_note_2, color: Colors.yellow)
                : Icon(Icons.sticky_note_2_outlined, color: Color(0xffd2d180)),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Icon(Icons.attach_money, color: Colors.yellow)
                : Icon(Icons.attach_money_outlined, color: Color(0xffd2d180)),
            label: 'Transaksi',
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
