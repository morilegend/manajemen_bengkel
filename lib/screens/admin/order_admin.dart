import 'package:flutter/material.dart';

class OrderAdmin extends StatefulWidget {
  const OrderAdmin({Key? key}) : super(key: key);

  @override
  State<OrderAdmin> createState() => OrderAdminState();
}

class OrderAdminState extends State<OrderAdmin> {
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
