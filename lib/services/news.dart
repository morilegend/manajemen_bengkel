import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kp_manajemen_bengkel/services/user.dart';

class NewsService {
  Future<List<Map<String, dynamic>>?> getNews() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('news').get();
      List<Map<String, dynamic>> newsList = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot
          in querySnapshot.docs) {
        Map<String, dynamic> data = snapshot.data();
        if (data != null) {
          data['id'] = snapshot.id;
          newsList.add(data);
        }
      }
      return newsList;
    } catch (e) {
      print('Error fetching news: $e');
      return null;
    }
  }
}

class FavoriteService {
  final NewsService newsService = NewsService();

  Future<void> addFavoriteNews(String? newsId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String? uid = await getCurrentUserId();

      if (uid != null) {
        DocumentReference<Map<String, dynamic>> favoritesDocRef = firestore
            .collection('news')
            .doc(newsId)
            .collection('favorites')
            .doc(uid);

        DocumentSnapshot<Map<String, dynamic>> favoritesDoc =
            await favoritesDocRef.get();
        if (!favoritesDoc.exists) {
          await favoritesDocRef.set({'userId': uid, 'isFavorite': true});
          print("Successfully added to favorites with userId $uid");
        } else {
          print(
              'Favorite already exists for document $newsId with userId $uid');
        }
      } else {
        throw Exception("User not signed in.");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<List<Map<String, dynamic>>?> getNewsFavorite() async {
    try {
      List<Map<String, dynamic>>? allNews = await newsService.getNews();
      if (allNews != null) {
        String? uid = await getCurrentUserId();
        if (uid != null) {
          List<Map<String, dynamic>> favoriteNewsList = [];
          for (Map<String, dynamic> news in allNews) {
            DocumentReference<Map<String, dynamic>> favoritesDocRef =
                FirebaseFirestore.instance
                    .collection('news')
                    .doc(news['id'])
                    .collection('favorites')
                    .doc(uid);

            DocumentSnapshot<Map<String, dynamic>> favoritesDoc =
                await favoritesDocRef.get();
            if (favoritesDoc.exists) {
              favoriteNewsList.add(news);
            }
          }
          return favoriteNewsList;
        } else {
          throw Exception("User not signed in.");
        }
      }
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }

  Future<void> removeFavoriteNews(String? newsId) async {
    try {
      final uid = await getCurrentUserId();
      if (uid != null) {
        final favoritesDocRef = FirebaseFirestore.instance
            .collection('news')
            .doc(newsId)
            .collection('favorites')
            .doc(uid);

        await favoritesDocRef.delete();
        print('News removed from favorites.');
      } else {
        throw Exception("User not signed in.");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<bool> isFavoriteNews(String? newsId) async {
    try {
      final uid = await getCurrentUserId();
      if (uid != null) {
        final favoritesDocRef = FirebaseFirestore.instance
            .collection('news')
            .doc(newsId)
            .collection('favorites')
            .doc(uid);

        final favoritesDoc = await favoritesDocRef.get();
        return favoritesDoc.exists;
      } else {
        throw Exception("User not signed in.");
      }
    } catch (error) {
      print("Error: $error");
      return false;
    }
  }
}
