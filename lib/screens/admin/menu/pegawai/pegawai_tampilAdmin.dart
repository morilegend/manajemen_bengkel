import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/pegawaiModels.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/pegawai/pegawai_tambahAdmin.dart';
import 'package:kp_manajemen_bengkel/services/pegawaiServices.dart';

class TampilPegawaiAdmin extends StatefulWidget {
  const TampilPegawaiAdmin({super.key});

  @override
  State<TampilPegawaiAdmin> createState() => _TampilPegawaiAdminState();
}

class _TampilPegawaiAdminState extends State<TampilPegawaiAdmin> {
  late Future<List<Pegawai>> _futurePegawai;

  @override
  void initState() {
    super.initState();
    _futurePegawai = PegawaiService.getAllPegawai();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Pegawai Admin"),
          backgroundColor: Color.fromRGBO(231, 229, 93, 1)),
      body: FutureBuilder<List<Pegawai>>(
        future: _futurePegawai,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada pegawai"));
          } else {
            List<Pegawai> pegawaiList = snapshot.data!;
            return ListView.builder(
              itemCount: pegawaiList.length,
              itemBuilder: (context, index) {
                Pegawai pegawai = pegawaiList[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(pegawai.name),
                      subtitle: Text(pegawai.role),
                    ),
                    Divider(),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahPegawaiAdmin()),
          ).then((value) {
            setState(() {
              _futurePegawai = PegawaiService.getAllPegawai();
            });
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
      ),
    );
  }
}
