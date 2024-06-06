import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_manajemen_bengkel/models/pegawaiModels.dart';

class PegawaiService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _pegawaiCollection =
      _database.collection('pegawai');

  static Future<void> addPegawai(Pegawai pegawai) async {
    try {
      DocumentReference docRef = await _pegawaiCollection.add(pegawai.toMap());
      pegawai.id = docRef.id;
      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('Failed to add pegawai: $e');
    }
  }

  static Future<List<Pegawai>> getAllPegawai() async {
    try {
      QuerySnapshot querySnapshot = await _pegawaiCollection.get();
      return querySnapshot.docs.map((doc) {
        return Pegawai.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get all pegawai: $e');
    }
  }
}
