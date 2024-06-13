import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LaporanAdmin extends StatefulWidget {
  const LaporanAdmin({super.key});

  @override
  State<LaporanAdmin> createState() => _LaporanAdminState();
}

class _LaporanAdminState extends State<LaporanAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        title: Text(
          'Report',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Text(
                "Masukkan Sebuah Filter Untuk Timestamp untuk menangani logic date"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                //Logic Fliter Date
                children: [
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(231, 229, 93, 1),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 0.1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                const Text(
                                  'Total Pendapatan',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(201, 0, 0, 0)),
                                ),
                                Text(
                                  'Rp${NumberFormat("#,###").format(10000)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 0.5,
              endIndent: 10,
              indent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("Tambhakan Status Done --> Order Disini "),
            )
          ],
        ),
      ),
    );
  }
}
