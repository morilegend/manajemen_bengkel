class OrderM {
  String? id;
  String userId;
  List<Map<String, dynamic>> services;
  String carType;
  String notes;
  String status;
  DateTime orderDate;

  OrderM({
    this.id,
    required this.userId,
    required this.services,
    required this.carType,
    required this.notes,
    required this.status,
    required this.orderDate,
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
    );
  }
}
