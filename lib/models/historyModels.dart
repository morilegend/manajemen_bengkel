class HistoryM {
  String? id;
  String userId;
  List<Map<String, dynamic>> services;
  String carType;
  String notes;
  String status;
  DateTime orderDate;
  int? price;
  double? harga1;
  double? harga2;
  String? pegawaiId;

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
    this.pegawaiId,
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
      'price': price,
      'harga1': harga1,
      'harga2': harga2,
      'pegawaiId': pegawaiId, // Add this field
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
      price: map['price'],
      harga1: map['harga1'],
      harga2: map['harga2'],
      pegawaiId: map['pegawaiId'],
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
    int? price,
    double? harga1,
    double? harga2,
    String? pegawaiId,
  }) {
    return HistoryM(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      services: services ?? this.services,
      carType: carType ?? this.carType,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      orderDate: orderDate ?? this.orderDate,
      price: price ?? this.price,
      harga1: harga1 ?? this.harga1,
      harga2: harga2 ?? this.harga2,
      pegawaiId: pegawaiId ?? this.pegawaiId,
    );
  }
}
