import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/screens/user/news_detailScreen.dart';
import 'package:kp_manajemen_bengkel/services/news.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

getNewsData getNew = getNewsData();

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getNew.getNew(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Tampilkan indikator loading jika sedang memuat data
          } else {
            // Jika data berhasil dimuat, tampilkan ListView.builder
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                //Data berita
                Map<String, dynamic> news = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => newsDetailScreen(
                          news: news,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(12.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(news['urlimage'] ?? null),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 117, 117, 138),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(news['header'] ?? null,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                    overflow: TextOverflow.visible),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                news['tittle'] ?? '',
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                                overflow: TextOverflow
                                    .visible, // Membuat sebuah text panjang menggunakan expand
                              ),
                            ),
                            Text(
                              news['date'] ?? '',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: const Color.fromARGB(255, 114, 114, 114),
                              ),
                            )
                          ],
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
    );
  }
}
