import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/newsModels.dart';
import 'package:kp_manajemen_bengkel/screens/detail_screens/news_detailScreenUser.dart';
import 'package:kp_manajemen_bengkel/screens/user/favorite_news.dart';
import 'package:kp_manajemen_bengkel/services/news.dart';
import 'package:kp_manajemen_bengkel/services/user.dart';

class UserHome extends StatefulWidget {
  UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  final NewsService getNews = NewsService();
  final UserData getUserData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        automaticallyImplyLeading: false,
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        title: DefaultTextStyle(
          style: TextStyle(
            textBaseline: TextBaseline.alphabetic,
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                height: 50.0,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 75, 73, 73),
                      ),
                    ),
                    Container(
                      width: 190,
                      height: 31,
                      child: FutureBuilder<Map<dynamic, dynamic>?>(
                        future: getUserData.getUser(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Map<dynamic, dynamic>?> snapshot) {
                          return Text(
                            snapshot.data?["username"] ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 8, bottom: 1),
            child: Container(
              width: double.infinity,
              height: 130,
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            'News',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 190,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 40),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  _searchText = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 10.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Icon Favorite
                        Positioned(
                          left: 205.9,
                          bottom: 26,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FavoriteNewsUser(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 65,
                            ),
                          ),
                        ),
                        //Text Favorite News
                        Positioned(
                          bottom: 10,
                          left: 209.9,
                          right: 0,
                          child: Text(
                            'Favorite',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 218.9,
                          right: 0,
                          top: 70,
                          child: Text(
                            'News',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: FutureBuilder<List<NewsM>?>(
                future: getNews.getNews(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NewsM>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No news available.'),
                    );
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
                      // Check
                      Timestamp dateA = a.date ?? Timestamp(0, 0);
                      Timestamp dateB = b.date ?? Timestamp(0, 0);
                      return dateB.compareTo(dateA);
                    });

                    return ListView.builder(
                      itemCount: filteredNews.length,
                      itemBuilder: (BuildContext context, int index) {
                        NewsM newsGet = filteredNews[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => newsDetailScreen(
                                  newsData: newsGet,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsetsDirectional.only(bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 160.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(newsGet.urlImage ?? ''),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(231, 229, 93, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          newsGet.tittle ?? '',
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
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
