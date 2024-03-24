import 'package:flutter/material.dart';

class TransaksiHomeAdmin extends StatefulWidget {
  const TransaksiHomeAdmin({Key? key}) : super(key: key);

  @override
  State<TransaksiHomeAdmin> createState() => _TransaksiHomeState();
}

class _TransaksiHomeState extends State<TransaksiHomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        centerTitle: true,
      ),
      body: Center(
        child: const Text('Ini Transaksi Admin'),
      ),
    );
  }
}
