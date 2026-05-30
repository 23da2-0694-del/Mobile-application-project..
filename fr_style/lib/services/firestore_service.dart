import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all products
  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Product.fromMap(data, doc.id);
      }).toList();
    });
  }

  // Get products by category
  Stream<List<Product>> getProductsByCategory(String category) {
    return _db
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Product.fromMap(data, doc.id);
      }).toList();
    });
  }

  // Add product (for admin use)
  Future<void> addProduct(Map<String, dynamic> productData) {
    return _db.collection('products').add(productData);
  }

  // User Profile Management
  Future<void> saveUserProfile(String uid, Map<String, dynamic> userData) {
    return _db.collection('users').doc(uid).set(userData, SetOptions(merge: true));
  }

  Future<DocumentSnapshot> getUserProfile(String uid) {
    return _db.collection('users').doc(uid).get();
  }

  Stream<DocumentSnapshot> streamUserProfile(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }
}
