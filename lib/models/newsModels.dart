class newsM {
  final String date;
  final String descr;
  final String tittle;
  final String urlImage;

  newsM({
    required this.date,
    required this.descr,
    required this.tittle,
    required this.urlImage,
  });

  factory newsM.fromMap(Map<String, dynamic> data, String documentId) {
    return newsM(
      date: data['date'] ?? '',
      descr: data['descr'] ?? '',
      tittle: data['tittle'] ?? '',
      urlImage: data['urlimage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'descr': descr,
      'tittle': tittle,
      'urlimage': urlImage,
    };
  }
}

//Class Favorite
class Favorite {
  final String userId;

  Favorite({
    required this.userId,
  });

  factory Favorite.fromMap(Map<String, dynamic> data) {
    return Favorite(
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }
}
