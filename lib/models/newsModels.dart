class newsM {
  final String date;
  final String descr;
  final String title;
  final String urlImage;

  newsM({
    required this.date,
    required this.descr,
    required this.title,
    required this.urlImage,
  });

  factory newsM.fromMap(Map<String, dynamic> data, String documentId) {
    return newsM(
      date: data['date'] ?? '',
      descr: data['descr'] ?? '',
      title: data['title'] ?? '',
      urlImage: data['urlImage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'descr': descr,
      'title': title,
      'urlImage': urlImage,
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
