import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class DbSeeder {
  static Future<void> seedProducts() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final products = SampleData.products;

    debugPrint('Starting seeding process...');

    for (var product in products) {
      try {
        debugPrint('Adding/Updating product: ${product.name}...');
        await db.collection('products').doc(product.id).set(product.toMap());
        debugPrint('Successfully added/updated ${product.name}');
        // Small delay to show progress "one by one"
        await Future.delayed(const Duration(milliseconds: 500));
      } catch (e) {
        debugPrint('Error adding ${product.name}: $e');
      }
    }

    debugPrint('Seeding process completed!');
  }

  static Future<void> removeDuplicates() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    debugPrint('Checking for duplicate products...');
    
    final snapshot = await db.collection('products').get();
    final Map<String, List<QueryDocumentSnapshot>> productsByName = {};
    
    for (var doc in snapshot.docs) {
      final data = doc.data();
      if (data.containsKey('name')) {
        final name = data['name'] as String;
        if (!productsByName.containsKey(name)) {
          productsByName[name] = [];
        }
        productsByName[name]!.add(doc);
      }
    }

    int deletedCount = 0;
    for (var entry in productsByName.entries) {
      final docs = entry.value;
      if (docs.length > 1) {
        debugPrint('Found ${docs.length} copies of ${entry.key}. Deleting duplicates...');
        // Keep the first one, delete the rest
        for (int i = 1; i < docs.length; i++) {
          await db.collection('products').doc(docs[i].id).delete();
          deletedCount++;
        }
      }
    }
    
    debugPrint('Finished cleaning up. Deleted $deletedCount duplicate products.');
  }
}
