class OrderM {
  String? id;
  String userId;
  List<Map<String, dynamic>> services;
  String carType;
  String notes;
  String status;
  DateTime orderDate;
  String licensePlate; // Tambahkan field licensePlate

  OrderM({
    this.id,
    required this.userId,
    required this.services,
    required this.carType,
    required this.notes,
    required this.status,
    required this.orderDate,
    required this.licensePlate, // Tambahkan ke konstruktor
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
      'licensePlate': licensePlate, // Tambahkan ke map
    };
  }

  factory OrderM.fromMap(Map<String, dynamic> map, String id) {
    return OrderM(
      id: id,
      userId: map['userId'],
      services: List<Map<String, dynamic>>.from(map['services']),
      carType: map['carType'],
      notes: map['notes'],
      status: map['status'],
      orderDate: DateTime.parse(map['orderDate']),
      licensePlate: map['licensePlate'], // Ambil dari map
    );
  }
}
