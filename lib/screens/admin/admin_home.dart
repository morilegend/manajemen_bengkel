import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/admin/account_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/jasa/jasa_tampilAdmin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/laporan_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/pegawai/pegawai_tampilAdmin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/order_admin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/tambah_news.dart';
import 'package:kp_manajemen_bengkel/models/newsModels.dart';
import 'package:kp_manajemen_bengkel/screens/admin/detail_screens_admin/news_detailScreenAdmin.dart';
import 'package:kp_manajemen_bengkel/services/newsServices.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late Future<List<NewsM>?> _newsFuture;
  final NewsService _newsService = NewsService();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _newsFuture = _newsService.getNews();
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
                          children: const [
                            Text(
                              'Pendapatan Hari ini',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(201, 0, 0, 0)),
                            ),
                            Text(
                              'Rp0', // <-- Berikan Sebuah Logic Untuk Mengganti Text Hari ini
                              style: TextStyle(fontSize: 16),
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
                              style: TextStyle(fontSize: 16),
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
                              icon: Icon(Icons.attach_money),
                              iconSize: 35,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TampilJasaAdmin()),
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
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.insert_chart),
                              iconSize: 35,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TampilPegawaiAdmin()),
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
                              borderRadius: BorderRadius.circular(30),
                            ),
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
              ],
            ),
          ),
          Divider(thickness: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 199, 196, 196),
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 90,
                        color: Colors.black,
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TambahNews()),
                          );
                          setState(() {
                            _newsFuture = _newsService.getNews();
                          });
                        },
                      ),
                    ),
                    FutureBuilder<List<NewsM>?>(
                      future: _newsFuture,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<NewsM>?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('Berita Kosong'));
                        } else {
                          List<NewsM> filteredNews = snapshot.data!
                              .where((news) =>
                                  news.tittle
                                      ?.toLowerCase()
                                      .contains(_searchText.toLowerCase()) ??
                                  false)
                              .toList();

                          // Filtered By Date
                          filteredNews.sort((a, b) {
                            Timestamp dateA = a.date ?? Timestamp(0, 0);
                            Timestamp dateB = b.date ?? Timestamp(0, 0);
                            return dateB.compareTo(dateA);
                          });

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredNews.length,
                            itemBuilder: (BuildContext context, int index) {
                              NewsM newsGet = filteredNews[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          newsDetailScreenAdmin(
                                              newsData: newsGet),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  padding:
                                      EdgeInsetsDirectional.only(bottom: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 160.0,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                newsGet.urlImage ?? ''),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10)),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(231, 229, 93, 1),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(10)),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                newsGet.tittle ?? '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.0),
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
