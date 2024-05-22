import 'package:flutter/material.dart';

class JasaAdmin extends StatefulWidget {
  const JasaAdmin({super.key});

  @override
  State<JasaAdmin> createState() => _JasaAdminState();
}

class _JasaAdminState extends State<JasaAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jasa"),
      ),
    );
  }
}
