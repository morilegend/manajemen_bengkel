import 'package:flutter/material.dart';

class PegawaiAdmin extends StatefulWidget {
  const PegawaiAdmin({super.key});

  @override
  State<PegawaiAdmin> createState() => _PegawaiAdminState();
}

class _PegawaiAdminState extends State<PegawaiAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pegawai Admin"),
      ),
    );
  }
}
