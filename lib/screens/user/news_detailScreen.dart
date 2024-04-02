import 'package:flutter/material.dart';

class newsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> news;

  const newsDetailScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implementasi halaman detail berita di sini
    return Scaffold(
      appBar: AppBar(
        title: Text(news['tittle'] ??
            null), // Misalnya menampilkan judul berita di appbar
      ),
      body: Center(
        child: Text(news['descr'] ??
            null), // Misalnya menampilkan deskripsi berita di body
      ),
    );
  }
}
