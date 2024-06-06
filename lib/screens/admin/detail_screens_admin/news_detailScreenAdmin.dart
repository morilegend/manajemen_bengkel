import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Package for Provides internationalization and localization facilities
import 'package:kp_manajemen_bengkel/models/newsModels.dart';
import 'package:kp_manajemen_bengkel/services/newsServices.dart';
import 'package:kp_manajemen_bengkel/services/userServices.dart';

class newsDetailScreenAdmin extends StatefulWidget {
  final NewsM newsData;

  newsDetailScreenAdmin({Key? key, required this.newsData}) : super(key: key);

  @override
  _newsDetailScreenAdminState createState() => _newsDetailScreenAdminState();
}

class _newsDetailScreenAdminState extends State<newsDetailScreenAdmin> {
  bool isFavorite = false;
  final FavoriteService newsService = FavoriteService();

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  Future<void> checkFavoriteStatus() async {
    try {
      final favoriteStatus =
          await newsService.isFavoriteNews(widget.newsData.id!);
      setState(() {
        isFavorite = favoriteStatus;
      });
    } catch (error) {
      print('Error checking favorite status: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format the date using DateFormat
    String formattedDate = widget.newsData.date != null
        ? DateFormat.yMMMd().format(widget.newsData.date!.toDate())
        : 'Kosong';

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.newsData.tittle ?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.fade,
              ),
              SizedBox(height: 10),
              Text(
                formattedDate,
                style: TextStyle(
                  color: Color.fromRGBO(116, 117, 137, 1),
                  fontSize: 15.0,
                ),
                overflow: TextOverflow.clip,
              ),
              SizedBox(height: 10),
              Container(
                height: 220.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.newsData.urlImage ?? ''),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 30.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  widget.newsData.description ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
