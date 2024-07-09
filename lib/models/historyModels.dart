class HistoryM {
  String? id;
  String userId;
  List<Map<String, dynamic>> services;
  String carType;
  String notes;
  String status;
  DateTime orderDate;
  DateTime reservationDate;
  int? price;
  double? harga1;
  double? harga2;
  String? pegawaiId;
  String? licensePlate;
  String? beforeCarImageUrl;
  String? afterCarImageUrl;

  HistoryM({
    this.id,
    this.price,
    this.harga1,
    this.harga2,
    required this.userId,
    required this.services,
    required this.carType,
    required this.notes,
    required this.status,
    required this.orderDate,
    required this.reservationDate,
    this.pegawaiId,
    this.licensePlate,
    this.beforeCarImageUrl,
    this.afterCarImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'services': services,
      'carType': carType,
      'notes': notes,
      'status': status,
      'orderDate': orderDate.toIso8601String(),
      'reservationDate': reservationDate.toIso8601String(),
      'price': price,
      'harga1': harga1,
      'harga2': harga2,
      'pegawaiId': pegawaiId,
      'licensePlate': licensePlate,
      'beforeCarImageUrl': beforeCarImageUrl,
      'afterCarImageUrl': afterCarImageUrl,
    };
  }

  factory HistoryM.fromMap(Map<String, dynamic> map, String id) {
    return HistoryM(
      id: id,
      userId: map['userId'],
      services: List<Map<String, dynamic>>.from(map['services']),
      carType: map['carType'],
      notes: map['notes'],
      status: map['status'],
      orderDate: DateTime.parse(map['orderDate']),
      reservationDate: DateTime.parse(map['reservationDate']),
      price: map['price'],
      harga1: map['harga1'],
      harga2: map['harga2'],
      pegawaiId: map['pegawaiId'],
      licensePlate: map['licensePlate'],
      beforeCarImageUrl: map['beforeCarImageUrl'],
      afterCarImageUrl: map['afterCarImageUrl'],
    );
  }

  HistoryM copyWith({
    String? id,
    String? userId,
    List<Map<String, dynamic>>? services,
    String? carType,
    String? notes,
    String? status,
    DateTime? orderDate,
    DateTime? reservationDate,
    int? price,
    double? harga1,
    double? harga2,
    String? pegawaiId,
    String? licensePlate,
    String? beforeCarImageUrl,
    String? afterCarImageUrl,
  }) {
    return HistoryM(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      services: services ?? this.services,
      carType: carType ?? this.carType,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
      reservationDate: reservationDate ?? this.reservationDate,
      price: price ?? this.price,
      harga1: harga1 ?? this.harga1,
      harga2: harga2 ?? this.harga2,
      pegawaiId: pegawaiId ?? this.pegawaiId,
      licensePlate: licensePlate ?? this.licensePlate,
      beforeCarImageUrl: beforeCarImageUrl ?? this.beforeCarImageUrl,
      afterCarImageUrl: afterCarImageUrl ?? this.afterCarImageUrl,
    );
  }
}
