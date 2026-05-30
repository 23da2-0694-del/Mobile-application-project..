import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  // Stream of user orders
  Stream<List<OrderModel>> getUserOrders() {
    if (_uid == null) return Stream.value([]);
    
    return _db
        .collection('users')
        .doc(_uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OrderModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // Create a new order
  Future<void> createOrder(OrderModel order) async {
    if (_uid == null) throw Exception('User not authenticated');
    
    // We don't set the ID manually, let Firestore generate it
    await _db
        .collection('users')
        .doc(_uid)
        .collection('orders')
        .add(order.toMap());
  }
}
