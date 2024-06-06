import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kp_manajemen_bengkel/models/servicesModels.dart';

class ServiceService {
  // Reference to the Firestore collection
  static final CollectionReference _serviceCollection =
      FirebaseFirestore.instance.collection('services_list');

  Future<List<ServiceM>> getServices() async {
    try {
      QuerySnapshot<Object?> querySnapshot = await _serviceCollection.get();
      List<ServiceM> dataListServices = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        ServiceM service = ServiceM.fromMap(data, doc.id);
        dataListServices.add(service);
      });
      return dataListServices;
    } catch (error) {
      throw error;
    }
  }

  static Future<void> addService(ServiceM service) async {
    try {
      service.timestamp = Timestamp.now();
      DocumentReference docRef = await _serviceCollection.add(service.toMap());
      service.id = docRef.id;
      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('Failed to add service: $e');
    }
  }

  static Future<List<ServiceM>> getAllServices() async {
    try {
      QuerySnapshot querySnapshot = await _serviceCollection.get();
      return querySnapshot.docs
          .map((doc) =>
              ServiceM.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get services: $e');
    }
  }

  static Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/services_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  static Future<void> deleteService(String serviceId) async {
    try {
      await _serviceCollection.doc(serviceId).delete();
    } catch (e) {
      throw Exception('Failed to delete service: $e');
    }
  }
}
