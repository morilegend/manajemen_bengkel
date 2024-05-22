import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kp_manajemen_bengkel/screens/admin/account_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/jasa_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/laporan_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/pegawai_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/order_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/tambah_news.dart';
import 'package:kp_manajemen_bengkel/screens/admin/transaksi_admin.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(231, 229, 93, 1),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 0.1,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Pendapatan Hari ini',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(201, 0, 0, 0)),
                        ),
                        Text(
                          'Rp0', // <-- Berikan Sebuah Logic Untuk Mengganti Text Hari ini
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Pendapatan Bulan ini',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(201, 0, 0, 0)),
                        ),
                        Text(
                          'Rp0', // <-- Berikan Sebuah Logic Untuk Mengganti Text Bulan ini
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Menu Label
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Menu',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Icons with Text
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(231, 229, 93, 1),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                          icon: Icon(Icons.attach_money),
                          iconSize: 35,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JasaAdmin()),
                            );
                          },
                        ),
                      ),
                      Text(
                        'Jasa',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(231, 229, 93, 1),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                          icon: Icon(Icons.insert_chart),
                          iconSize: 35,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PegawaiAdmin()),
                            );
                          },
                        ),
                      ),
                      Text('Pegawai'),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(231, 229, 93, 1),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                          icon: Icon(Icons.settings),
                          iconSize: 35,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LaporanAdmin()),
                            );
                          },
                        ),
                      ),
                      Text('Laporan'),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            //Tambah News
            SingleChildScrollView(
              child: Container(
                height: 120,
                width: 280,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 199, 196, 196),
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                  ),
                  iconSize: 90,
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TambahNews()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
