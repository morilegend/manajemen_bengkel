import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/pegawaiModels.dart';
import 'package:kp_manajemen_bengkel/services/pegawaiServices.dart';

class TambahPegawaiAdmin extends StatefulWidget {
  const TambahPegawaiAdmin({super.key});

  @override
  State<TambahPegawaiAdmin> createState() => _TambahPegawaiAdminState();
}

class _TambahPegawaiAdminState extends State<TambahPegawaiAdmin> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  late Future<List<Pegawai>> _futurePegawai;

  @override
  void initState() {
    super.initState();
    _futurePegawai = PegawaiService.getAllPegawai();
  }

  Future<void> _addPegawai() async {
    if (_nameController.text.isNotEmpty && _roleController.text.isNotEmpty) {
      Pegawai pegawai =
          Pegawai(name: _nameController.text, role: _roleController.text);
      await PegawaiService.addPegawai(pegawai);
      setState(() {
        _futurePegawai = PegawaiService.getAllPegawai();
      });
      _nameController.clear();
      _roleController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Pegawai"),
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nama Pegawai"),
            ),
            TextField(
              controller: _roleController,
              decoration: InputDecoration(labelText: "Role Pegawai"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addPegawai,
              child: Text("Tambah Pegawai"),
            ),
          ],
        ),
      ),
    );
  }
}
