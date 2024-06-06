import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceM {
  String? id;
  String? name;
  double? harga1;
  double? harga2;
  Timestamp? timestamp;
  String? urlImage;
  String? descr;

  ServiceM({
    this.id,
    this.name,
    this.harga1,
    this.harga2,
    this.timestamp,
    this.urlImage,
    this.descr,
  });

  factory ServiceM.fromMap(Map<String, dynamic> data, String documentId) {
    return ServiceM(
      id: documentId,
      name: data['name'],
      harga1: data['harga1'],
      harga2: data['harga2'],
      descr: data['descr'],
      timestamp: data['timestamp'],
      urlImage: data['urlImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'harga1': harga1,
      'harga2': harga2,
      'timestamp': timestamp,
      'urlImage': urlImage,
      'descr': descr,
    };
  }
}
