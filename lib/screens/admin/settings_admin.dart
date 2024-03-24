import 'package:flutter/material.dart';

class SettingsAdmin extends StatefulWidget {
  const SettingsAdmin({Key? key}) : super(key: key);

  @override
  State<SettingsAdmin> createState() => _SettingsHomeStateAdmin();
}

class _SettingsHomeStateAdmin extends State<SettingsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home Settings'),
        centerTitle: true,
      ),
      body: Center(
        child: const Text('Ini Settings Admin'),
      ),
    );
  }
}
