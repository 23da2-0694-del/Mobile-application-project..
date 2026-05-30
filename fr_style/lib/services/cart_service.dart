import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/cart_model.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current authenticated user UID
  String? get _uid => _auth.currentUser?.uid;

  // Reference to the user's cart sub-collection
  CollectionReference<Map<String, dynamic>>? get _cartCollection {
    if (_uid == null) return null;
    return _db.collection('users').doc(_uid).collection('cart');
  }

  // Stream of cart items for this user
  Stream<List<CartItem>> getCartItems() {
    final collection = _cartCollection;
    if (collection == null) return const Stream.empty();
    return collection.orderBy('updatedAt', descending: true).snapshots().map(
      (snapshot) => snapshot.docs.map((doc) {
        try {
          return CartItem.fromMap(doc.data());
        } catch (e) {
          debugPrint('Error parsing cart item ${doc.id}: $e');
          return null;
        }
      }).whereType<CartItem>().toList(),
    );
  }

  // Create or update a cart item
  Future<void> saveCartItem(CartItem item) async {
    final collection = _cartCollection;
    if (collection == null) return;
    final itemId = '${item.product.id}_${item.selectedSize}_${item.selectedColor}';
    final data = item.toMap();
    data['updatedAt'] = FieldValue.serverTimestamp();
    await collection.doc(itemId).set(data);
  }

  // Remove a specific cart item
  Future<void> removeCartItem(String productId, String size, String color) async {
    final collection = _cartCollection;
    if (collection == null) return;
    final itemId = '${productId}_${size}_$color';
    await collection.doc(itemId).delete();
  }

  // Delete all cart items for the user (uses batch for atomicity)
  Future<void> clearCart() async {
    final collection = _cartCollection;
    if (collection == null) return;
    final snapshot = await collection.get();
    if (snapshot.docs.isEmpty) return;

    final batch = _db.batch();
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
