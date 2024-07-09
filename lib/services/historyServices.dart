import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kp_manajemen_bengkel/models/historyModels.dart';

class HistoryService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _historyCollection =
      _database.collection('history');

  static Future<void> addHistory(HistoryM history) async {
    try {
      DocumentReference docRef = await _historyCollection.add(history.toMap());
      history.id = docRef.id;
      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('Failed to add history: $e');
    }
  }

  static Future<String?> uploadImage(File imageFile, String path) async {
    try {
      String fileName = '$path/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  static Future<void> deleteImage(String imageUrl) async {
    try {
      Reference storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
      await storageRef.delete();
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  static Future<List<HistoryM>> getUserHistories(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await _historyCollection.where('userId', isEqualTo: userId).get();
      return querySnapshot.docs
          .map((doc) =>
              HistoryM.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user histories: $e');
    }
  }

  static Future<void> updateHistory(HistoryM history) async {
    try {
      await _historyCollection.doc(history.id!).update(history.toMap());
    } catch (e) {
      throw Exception('Failed to update history: $e');
    }
  }

  static Future<List<HistoryM>> getAllHistories() async {
    try {
      QuerySnapshot querySnapshot = await _historyCollection.get();
      return querySnapshot.docs.map((doc) {
        return HistoryM.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get all histories: $e');
    }
  }

  static Future<void> updateStatus(String historyId, String status) async {
    try {
      await _historyCollection.doc(historyId).update({'status': status});
    } catch (e) {
      throw Exception('Failed to update status: $e');
    }
  }

  static Future<void> updatePegawaiAndStatus(
      String historyId, String pegawaiId, String status) async {
    try {
      await _historyCollection.doc(historyId).update({
        'pegawaiId': pegawaiId,
        'status': status,
      });
    } catch (e) {
      throw Exception('Failed to update pegawai and status: $e');
    }
  }

  static Future<void> updatePriceAndStatus(
      String historyId, int price, double? harga1, double? harga2) async {
    try {
      await _historyCollection.doc(historyId).update({
        'price': price,
        'status': 'Pending',
        'harga1': harga1,
        'harga2': harga2,
      });
    } catch (e) {
      throw Exception('Failed to update price and status: $e');
    }
  }

  static Future<Map<String, double>> calculateIncome() async {
    try {
      QuerySnapshot querySnapshot =
          await _historyCollection.where('status', isEqualTo: 'done').get();

      double dailyIncome = 0;
      double monthlyIncome = 0;

      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime startOfMonth = DateTime(now.year, now.month, 1);

      for (var doc in querySnapshot.docs) {
        HistoryM history =
            HistoryM.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        DateTime orderDate = history.orderDate;

        if (orderDate.isAfter(today.subtract(Duration(days: 1)))) {
          dailyIncome += history.price ?? 0;
        }
        if (orderDate.isAfter(startOfMonth)) {
          monthlyIncome += history.price ?? 0;
        }
      }

      return {
        'dailyIncome': dailyIncome,
        'monthlyIncome': monthlyIncome,
      };
    } catch (e) {
      throw Exception('Failed to calculate income: $e');
    }
  }

  static Future<List<HistoryM>> getDoneHistories() async {
    try {
      QuerySnapshot querySnapshot =
          await _historyCollection.where('status', isEqualTo: 'Done').get();
      return querySnapshot.docs.map((doc) {
        return HistoryM.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get done histories: $e');
    }
  }
}
