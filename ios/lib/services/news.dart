import 'package:cloud_firestore/cloud_firestore.dart';

//User
class getNewsData {
  Future<List<Map<String, dynamic>>> getNew() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('news').get();
      List<Map<String, dynamic>> dataListNews = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data();
        if (data != null) {
          dataListNews.add({
            'urlimage': data['urlimage'],
            'tittle': data['tittle'],
            'descr': data['descr'],
            'date': data['date'],
            'likes': data['likes'],
            'map': data['map']
          });
        }
      });
      return dataListNews;
    } catch (error) {
      throw error;
    }
  }
}

//Admin Post
class postNewsData {}
