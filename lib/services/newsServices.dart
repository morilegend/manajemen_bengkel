import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kp_manajemen_bengkel/models/newsModels.dart';
import 'package:kp_manajemen_bengkel/services/userServices.dart';

class NewsService {
  Future<List<NewsM>?> getNews() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('news').get();
      List<NewsM> newsList = querySnapshot.docs.map((snapshot) {
        Map<String, dynamic> data = snapshot.data();
        return NewsM.fromMap(data, snapshot.id);
      }).toList();
      return newsList;
    } catch (e) {
      print('Error fetching news: $e');
      return null;
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File image) async {
    try {
      final storageRef = _storage
          .ref()
          .child('images/news_images/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> addNews(String tittle, String description, Timestamp date,
      String urlimage) async {
    try {
      await _firestore.collection('news').add({
        'tittle': tittle,
        'descr': description,
        'date': date,
        'urlimage': urlimage,
      });
    } catch (e) {
      throw Exception('Failed to add news: $e');
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

  Future<List<NewsM>?> getNewsFavorite() async {
    try {
      List<NewsM>? allNews = await newsService.getNews();
      if (allNews != null) {
        String? uid = await getCurrentUserId();
        if (uid != null) {
          List<NewsM> favoriteNewsList = [];
          for (NewsM news in allNews) {
            DocumentReference<Map<String, dynamic>> favoritesDocRef =
                FirebaseFirestore.instance
                    .collection('news')
                    .doc(news.id)
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
    return null;
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
