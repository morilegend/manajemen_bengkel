import 'package:cloud_firestore/cloud_firestore.dart';

class Pegawai {
  String? id;
  String name;
  String role;

  Pegawai({this.id, required this.name, required this.role});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
    };
  }

  factory Pegawai.fromMap(Map<String, dynamic> map, String id) {
    return Pegawai(
      id: id,
      name: map['name'],
      role: map['role'],
    );
  }
}
