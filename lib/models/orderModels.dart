class OrderM {
  String? id;
  String userId;
  List<Map<String, dynamic>> services;
  String carType;
  String notes;
  String status;
  DateTime orderDate;
  DateTime reservationDate;
  String licensePlate;

  OrderM({
    this.id,
    required this.userId,
    required this.services,
    required this.carType,
    required this.notes,
    required this.status,
    required this.orderDate,
    required this.reservationDate,
    required this.licensePlate,
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
      'licensePlate': licensePlate,
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
      reservationDate: DateTime.parse(map['reservationDate']),
      licensePlate: map['licensePlate'],
    );
  }
}
