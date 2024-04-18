import 'package:cloud_firestore/cloud_firestore.dart';

class getServicesList {
  Future<List<Map<String, dynamic>>> getServices() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('services_list').get();
      List<Map<String, dynamic>> dataListServices = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data();
        if (data != null) {
          dataListServices.add({
            'urlimage': data['urlimage'],
            'name': data['name'],
            'harga': data['harga'],
            'descr': data['descr'],
          });
        }
      });
      return dataListServices;
    } catch (error) {
      throw error;
    }
  }
}

class postServicesList {}
