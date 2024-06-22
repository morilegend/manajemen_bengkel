import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/jasa/jasa_tampilAdmin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/laporan_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/pegawai/pegawai_tampilAdmin.dart';
import 'package:kp_manajemen_bengkel/models/historyModels.dart';
import 'package:kp_manajemen_bengkel/services/historyServices.dart';
import 'package:intl/intl.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _dailyIncome = 0;
  int _monthlyIncome = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeData();
  }

  void _initializeData() {
    _calculateIncome();
  }

  void _calculateIncome() async {
    List<HistoryM> histories = await HistoryService.getAllHistories();
    int dailyIncome = 0;
    int monthlyIncome = 0;

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime startOfMonth = DateTime(now.year, now.month, 1);

    for (var history in histories) {
      if (history.status == 'Done') {
        DateTime orderDate = history.orderDate;
        int price = history.price?.toInt() ?? 0;

        if (orderDate.isAfter(today.subtract(Duration(days: 1)))) {
          dailyIncome += price;
        }
        if (orderDate.isAfter(startOfMonth)) {
          monthlyIncome += price;
        }
      }
    }

    setState(() {
      _dailyIncome = dailyIncome;
      _monthlyIncome = monthlyIncome;
    });
  }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pendapatan Hari ini',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(201, 0, 0, 0)),
                            ),
                            Text(
                              'Rp${NumberFormat("#,###").format(_dailyIncome)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pendapatan Bulan ini',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(201, 0, 0, 0)),
                            ),
                            Text(
                              'Rp${NumberFormat("#,###").format(_monthlyIncome)}',
                              style: const TextStyle(fontSize: 16),
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
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.car_crash),
                              iconSize: 35,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TampilJasaAdmin()),
                                ).then((_) {
                                  _initializeData();
                                });
                              },
                            ),
                          ),
                          Text(
                            'Services',
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
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.people_alt),
                              iconSize: 35,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TampilPegawaiAdmin()),
                                ).then((_) {
                                  _initializeData();
                                });
                              },
                            ),
                          ),
                          Text('Employee'),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(231, 229, 93, 1),
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.book),
                              iconSize: 35,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LaporanAdmin()),
                                ).then((_) {
                                  _initializeData();
                                });
                              },
                            ),
                          ),
                          Text('Report'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
