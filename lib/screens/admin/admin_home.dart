import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/admin/settings_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/laporan_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/transaksi_admin.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        centerTitle: true,
      ),
      body: Center(
        child: const Text('Welcome to Admin Home'),
      ),
    );
  }
}
