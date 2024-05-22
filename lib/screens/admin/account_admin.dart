import 'package:flutter/material.dart';

class AccountAdmin extends StatefulWidget {
  const AccountAdmin({Key? key}) : super(key: key);

  @override
  State<AccountAdmin> createState() => _SettingsHomeStateAdmin();
}

class _SettingsHomeStateAdmin extends State<AccountAdmin> {
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
