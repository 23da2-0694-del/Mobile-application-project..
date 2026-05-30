import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<CartItem> items;
  final Map<String, dynamic> shippingAddress;
  final String paymentMethod;
  final double subtotal;
  final double shippingFee;
  final double total;
  final String status;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'subtotal': subtotal,
      'shippingFee': shippingFee,
      'total': total,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map, String documentId) {
    return OrderModel(
      id: documentId,
      userId: map['userId'] ?? '',
      items: List<CartItem>.from(
        (map['items'] as List<dynamic>? ?? []).map(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      shippingAddress: Map<String, dynamic>.from(map['shippingAddress'] ?? {}),
      paymentMethod: map['paymentMethod'] ?? '',
      subtotal: (map['subtotal'] ?? 0.0).toDouble(),
      shippingFee: (map['shippingFee'] ?? 0.0).toDouble(),
      total: (map['total'] ?? 0.0).toDouble(),
      status: map['status'] ?? 'processing',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
