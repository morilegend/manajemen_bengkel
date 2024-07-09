import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_manajemen_bengkel/models/historyModels.dart';
import 'package:kp_manajemen_bengkel/models/orderModels.dart';
import 'package:kp_manajemen_bengkel/services/historyServices.dart';

class OrderService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _ordersCollection =
      _database.collection('orders');

  static Future<void> addOrder(OrderM order) async {
    try {
      DocumentReference docRef = await _ordersCollection.add(order.toMap());
      order.id = docRef.id;
      await docRef.update({'id': docRef.id});
      await addOrderToHistory(order);
    } catch (e) {
      throw Exception('Failed to add order: $e');
    }
  }

  static Future<List<OrderM>> getOrdersByUser(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await _ordersCollection.where('userId', isEqualTo: userId).get();
      return querySnapshot.docs
          .map((doc) =>
              OrderM.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  static Future<void> addOrderToHistory(OrderM order) async {
    final history = HistoryM(
      id: order.id,
      userId: order.userId,
      services: order.services,
      carType: order.carType,
      notes: order.notes,
      status: order.status,
      orderDate: order.orderDate,
      reservationDate: order.reservationDate,
      licensePlate: order.licensePlate,
    );
    await HistoryService.addHistory(history);
  }
}
