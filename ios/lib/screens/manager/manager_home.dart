import 'package:flutter/material.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  State<ManagerHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<ManagerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Home'),
        centerTitle: true,
      ),
      body: Center(
        child: const Text('Welcome to Admin Home'),
      ),
    );
  }
}
