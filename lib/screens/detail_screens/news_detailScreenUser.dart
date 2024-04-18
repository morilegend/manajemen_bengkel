import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/services/news.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class newsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> newsData;
  String? newsId;

  newsDetailScreen({Key? key, required this.newsData, required this.newsId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final news addFavorite = news();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      newsData['tittle'] ?? '',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        newsData['date'] ?? '',
                        style: TextStyle(
                          color: Color.fromRGBO(116, 117, 137, 1),
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(newsData['urlimage'] ?? ''),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 209, 209, 209),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 30.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        newsData['descr'] ?? '',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        child: Icon(
          Icons.menu_sharp,
        ),
        activeIcon: Icons.close,
        buttonSize: Size(10, 40),
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              backgroundColor: Color.fromRGBO(231, 229, 93, 1),
              elevation: 0,
              child: Icon(Icons.favorite),
              labelWidget: Text("Favorites"),
              shape: CircleBorder(),
              onTap: () {
                addFavorite.addFavoriteNews(newsId);
              }),
          SpeedDialChild(
            backgroundColor: Color.fromRGBO(231, 229, 93, 1),
            elevation: 0,
            child: Icon(Icons.comment),
            labelWidget: Text("Comments"),
            shape: CircleBorder(),
            onTap: () {
              print('Document ID: $newsId');
            },
          ),
        ],
      ),
    );
  }
}
