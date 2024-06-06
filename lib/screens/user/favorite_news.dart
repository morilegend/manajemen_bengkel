import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/newsModels.dart';
import 'package:kp_manajemen_bengkel/services/newsServices.dart';
import 'package:kp_manajemen_bengkel/screens/user/detail_screens_user/news_detailScreenUser.dart';

class FavoriteNewsUser extends StatefulWidget {
  @override
  _FavoriteNewsUserState createState() => _FavoriteNewsUserState();
}

class _FavoriteNewsUserState extends State<FavoriteNewsUser> {
  List<NewsM>? favoriteNews;
  List<NewsM>? filteredFavoriteNews;
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavoriteNews();
    _searchController.addListener(_searchNews);
  }

  @override
  void dispose() {
    _searchController.removeListener(_searchNews);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchFavoriteNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      favoriteNews = await FavoriteService().getNewsFavorite();
      filteredFavoriteNews = favoriteNews;
    } catch (error) {
      print('Gagal Mendapatkan Data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _searchNews() {
    setState(() {
      _searchText = _searchController.text;
      if (_searchText.isEmpty) {
        filteredFavoriteNews = favoriteNews;
      } else {
        filteredFavoriteNews = favoriteNews?.where((news) {
          return news.tittle
                  ?.toLowerCase()
                  .contains(_searchText.toLowerCase()) ??
              false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Color.fromRGBO(231, 229, 93, 1),
          elevation: 3,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
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
                          padding: const EdgeInsets.only(right: 20, bottom: 10),
                          child: Text(
                            'Favorite News',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 290,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 45),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 10.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.black),
                                ),
                              ),
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
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : filteredFavoriteNews != null &&
                          filteredFavoriteNews!.isNotEmpty
                      ? ListView.builder(
                          itemCount: filteredFavoriteNews!.length,
                          itemBuilder: (BuildContext context, int index) {
                            NewsM newsGet = filteredFavoriteNews![index];
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
                                          image: NetworkImage(
                                              newsGet.urlImage ?? ''),
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
                        )
                      : Center(child: Text('Favorite Kosong')),
            ),
          ),
        ],
      ),
    );
  }
}
