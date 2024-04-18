import 'package:flutter/material.dart';

class LaporanHomeAdmin extends StatefulWidget {
  const LaporanHomeAdmin({Key? key}) : super(key: key);

  @override
  State<LaporanHomeAdmin> createState() => _LaporanHomeAdminState();
}

class _LaporanHomeAdminState extends State<LaporanHomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Admin'),
        centerTitle: true,
      ),
      body: Center(
        child: const Text('Ini Laporan Admin'),
      ),
    );
  }
}
