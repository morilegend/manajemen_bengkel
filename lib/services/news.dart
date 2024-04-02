import 'package:cloud_firestore/cloud_firestore.dart';

class getNewsData {
  Future<List<Map<String, dynamic>>> getNew() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('news').get();
      List<Map<String, dynamic>> dataList = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data();
        if (data != null) {
          dataList.add({
            'urlimage': data['urlimage'],
            'header': data['header'],
            'tittle': data['tittle'],
            'descr': data['descr'],
            'date': data['date'],
          });
        }
      });
      return dataList;
    } catch (error) {
      throw error;
    }
  }
}
