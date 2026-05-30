class Product {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> additionalImages;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final bool isFeatured;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.additionalImages = const [],
    required this.category,
    this.sizes = const [],
    this.colors = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isNew = false,
    this.isFeatured = false,
  });

  double get discountPercent {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).roundToDouble();
  }

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      brand: map['brand'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      originalPrice: map['originalPrice']?.toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      additionalImages: List<String>.from(map['additionalImages'] ?? []),
      category: map['category'] ?? '',
      sizes: List<String>.from(map['sizes'] ?? []),
      colors: List<String>.from(map['colors'] ?? []),
      rating: (map['rating'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      isNew: map['isNew'] ?? false,
      isFeatured: map['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'additionalImages': additionalImages,
      'category': category,
      'sizes': sizes,
      'colors': colors,
      'rating': rating,
      'reviewCount': reviewCount,
      'isNew': isNew,
      'isFeatured': isFeatured,
    };
  }
}

// Sample data for Phase 1 (no Firebase)
class SampleData {
  static const List<String> categories = [
    'All',
    'Men',
    'Women',
    'Kids',
    'Accessories',
    'Shoes',
  ];

  static List<Product> get products => [
        const Product(
          id: '1',
          name: 'Classic Brown Coat',
          brand: 'FR Style\'s',
          description:
              'A timeless brown coat perfect for any season. Made from premium wool blend fabric that provides warmth and style.',
          price: 89.99,
          originalPrice: 120.00,
          imageUrl: 'assets/products/coat.png',
          additionalImages: [
            'assets/products/coat.png',
          ],
          category: 'Women',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['Brown', 'Black', 'Camel'],
          rating: 4.8,
          reviewCount: 124,
          isFeatured: true,
        ),
        const Product(
          id: '2',
          name: 'Slim Fit Trousers',
          brand: 'FR Style\'s',
          description:
              'Modern slim fit trousers with a sophisticated cut. Perfect for both casual and formal occasions.',
          price: 4590,
          imageUrl:
              'assets/products/item1.png',
          category: 'Men',
          sizes: ['28', '30', '32', '34', '36'],
          colors: ['Olive', 'Black', 'Navy'],
          rating: 4.5,
          reviewCount: 89,
          isNew: true,
        ),
        const Product(
          id: '3',
          name: 'Leather Ankle Boots',
          brand: 'FR Style\'s',
          description:
              'Genuine leather ankle boots with a chunky heel. A versatile footwear choice that elevates any outfit.',
          price: 120.00,
          originalPrice: 160.00,
          imageUrl: 'assets/products/boots.png',
          category: 'Shoes',
          sizes: ['36', '37', '38', '39', '40', '41'],
          colors: ['Black', 'Brown'],
          rating: 4.9,
          reviewCount: 213,
          isFeatured: true,
        ),
        const Product(
          id: '4',
          name: 'Minimalist Watch',
          brand: 'FR Style\'s',
          description:
              'A clean, minimal design watch with genuine leather strap. Timeless accessory for any occasion.',
          price: 75.00,
          imageUrl: 'assets/products/watch.png',
          category: 'Accessories',
          sizes: ['One Size'],
          colors: ['Silver', 'Gold', 'Rose Gold'],
          rating: 4.7,
          reviewCount: 66,
          isNew: true,
        ),
        const Product(
          id: '5',
          name: 'Striped Casual Shirt',
          brand: 'FR Style\'s',
          description:
              'A lightweight striped shirt made from breathable cotton. Great for casual outings.',
          price: 35.99,
          imageUrl: 'assets/products/shirt.png',
          category: 'Men',
          sizes: ['S', 'M', 'L', 'XL', 'XXL'],
          colors: ['Blue/White', 'Black/White'],
          rating: 4.3,
          reviewCount: 45,
        ),
        const Product(
          id: '6',
          name: 'Floral Summer Dress',
          brand: 'FR Style\'s',
          description:
              'A beautiful floral print dress perfect for summer. Light fabric for maximum comfort.',
          price: 55.00,
          originalPrice: 75.00,
          imageUrl: 'assets/products/dress.png',
          category: 'Women',
          sizes: ['XS', 'S', 'M', 'L'],
          colors: ['Floral Print'],
          rating: 4.6,
          reviewCount: 132,
          isFeatured: true,
        ),
        const Product(
          id: '7',
          name: 'Pink Floral Dress',
          brand: 'FR Style\'s',
          description: 'A beautiful pink floral dress for girls.',
          price: 2500,
          imageUrl: 'assets/kids/girl1.png',
          category: 'Kids',
          sizes: ['2Y', '4Y', '6Y', '8Y'],
          colors: ['Pink'],
          rating: 4.8,
          reviewCount: 56,
          isNew: true,
        ),
        const Product(
          id: '8',
          name: 'Blue Party Dress',
          brand: 'FR Style\'s',
          description: 'Elegant blue party dress for special occasions.',
          price: 3000,
          imageUrl: 'assets/kids/girl2.png',
          category: 'Kids',
          sizes: ['4Y', '6Y', '8Y', '10Y'],
          colors: ['Blue'],
          rating: 4.9,
          reviewCount: 42,
        ),
        const Product(
          id: '9',
          name: 'Red T-Shirt Set',
          brand: 'FR Style\'s',
          description: 'Comfortable red T-shirt set for boys.',
          price: 2000,
          imageUrl: 'assets/kids/boy1.png',
          category: 'Kids',
          sizes: ['2Y', '4Y', '6Y', '8Y'],
          colors: ['Red'],
          rating: 4.7,
          reviewCount: 38,
          isNew: true,
        ),
        const Product(
          id: '10',
          name: 'Blue Sports Kit',
          brand: 'FR Style\'s',
          description: 'Breathable sports kit for active kids.',
          price: 2200,
          imageUrl: 'assets/kids/boy2.png',
          category: 'Kids',
          sizes: ['6Y', '8Y', '10Y', '12Y'],
          colors: ['Blue'],
          rating: 4.5,
          reviewCount: 29,
        ),
        const Product(
          id: '11',
          name: 'Premium Leather Wallet',
          brand: 'FR Style\'s',
          description: 'Handcrafted genuine leather wallet with multiple card slots and a sleek profile.',
          price: 45.00,
          imageUrl: 'assets/products/wallet.png',
          category: 'Accessories',
          sizes: ['One Size'],
          colors: ['Brown', 'Black'],
          rating: 4.8,
          reviewCount: 156,
          isNew: true,
        ),
      ];
}
