class KidsWear {
  final String name;
  final String image;
  final double price;
  final String category;

  KidsWear({
    required this.name,
    required this.image,
    required this.price,
    required this.category,
  });
}

List<KidsWear> kidsWearList = [
  // 👗 Girls
  KidsWear(
    name: "Pink Floral Dress",
    image: "assets/kids/girl1.png",
    price: 2500,
    category: "Girls",
  ),

  KidsWear(
    name: "Blue Party Dress",
    image: "assets/kids/girl2.png",
    price: 3000,
    category: "Girls",
  ),

  // 👕 Boys
  KidsWear(
    name: "Red T-Shirt Set",
    image: "assets/kids/boy1.png",
    price: 2000,
    category: "Boys",
  ),

  KidsWear(
    name: "Blue Sports Kit",
    image: "assets/kids/boy2.png",
    price: 2200,
    category: "Boys",
  ),
];
