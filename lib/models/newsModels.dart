import 'package:cloud_firestore/cloud_firestore.dart';

class NewsM {
  String? id;
  String? tittle;
  String? description;
  Timestamp? date;
  String? urlImage;

  NewsM({this.id, this.tittle, this.description, this.date, this.urlImage});

  factory NewsM.fromMap(Map<String, dynamic> data, String documentId) {
    return NewsM(
      id: documentId,
      tittle: data['tittle'],
      description: data['descr'],
      date: data['date'],
      urlImage: data['urlimage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tittle': tittle,
      'description': description,
      'date': date,
      'urlimage': urlImage,
    };
  }
}
