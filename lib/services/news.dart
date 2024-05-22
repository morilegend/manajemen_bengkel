import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kp_manajemen_bengkel/services/user.dart';

class news {
  Future<List<Map<String, dynamic>>?> getNews() async {
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
  }
}

class favoriteService {
  final seeNews = news();
  Future<void> addFavoriteNews(String? newsId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      // Mendapatkan current Id User
      String? uid = await getCurrentUserId();

      if (uid != null) {
        QuerySnapshot<Map<String, dynamic>> newsCollection =
            await firestore.collection('news').get();
        // Cek dokumen
        if (newsCollection.docs.isNotEmpty) {
          // Membuat referensi ke dokumen "favorites" di dalam dokumen "news"
          DocumentReference<Map<String, dynamic>> favoritesDocRef = firestore
              .collection('news')
              .doc(newsId)
              .collection('favorites')
              .doc('$uid');

          // Mengambil data dari dokumen "favorites"
          DocumentSnapshot<Map<String, dynamic>> favoritesDoc =
              await favoritesDocRef.get();
          // Jika dokumen "favorites" tidak ada, membuatnya dan menambahkan UID
          if (!favoritesDoc.exists) {
            await favoritesDocRef.set({'userId': uid, 'isFavorite': true});
            print("Sukses menambahkan Favorites dengan userId $uid");
          } else {
            print(
                'Data Favorites sudah ada untuk dokumen $newsId dengan userId $uid');
          }
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
      // Get semua berita, dan cek apakah terdapat favorites
      List<Map<String, dynamic>>? allNews = await seeNews.getNews();
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
            //Melakukan Pengecekan
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
        print('Berita dihapus dari daftar favorit.');
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
