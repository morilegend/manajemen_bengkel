import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/services/news.dart';
import 'package:kp_manajemen_bengkel/services/user.dart';

class newsDetailScreen extends StatefulWidget {
  final Map<String, dynamic> newsData;
  final String? newsId;

  newsDetailScreen({Key? key, required this.newsData, required this.newsId})
      : super(key: key);

  @override
  nNewsDetailScreenState createState() => nNewsDetailScreenState();
}

class nNewsDetailScreenState extends State<newsDetailScreen> {
  bool isFavorite = false;
  final favoriteService newsService = favoriteService();

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  Future<void> checkFavoriteStatus() async {
    final favoriteStatus = await newsService.isFavoriteNews(widget.newsId);
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
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
                      widget.newsData['tittle'] ?? '',
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
                        widget.newsData['date'] ?? '',
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
                    image: NetworkImage(widget.newsData['urlimage'] ?? ''),
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
                        widget.newsData['descr'] ?? '',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: isFavorite ? Colors.red : Colors.grey,
        onPressed: () async {
          final uid = await getCurrentUserId();
          if (uid != null) {
            if (isFavorite) {
              await newsService.removeFavoriteNews(widget.newsId);
            } else {
              await newsService.addFavoriteNews(widget.newsId);
            }
            setState(() {
              isFavorite = !isFavorite;
            });
          }
        },
        child: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }
}
