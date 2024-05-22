import 'package:flutter/material.dart';

class TambahNews extends StatefulWidget {
  const TambahNews({super.key});

  @override
  State<TambahNews> createState() => _TambahNewsState();
}

class _TambahNewsState extends State<TambahNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah News"),
      ),
    );
  }
}
