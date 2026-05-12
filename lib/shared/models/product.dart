class Product {
  final String id;
  final String name;
  final String shopName;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewsCount;
  final int soldCount;
  final String imagePlaceholder; // Emoji
  final List<String> tags;
  final String description;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.shopName,
    required this.price,
    this.oldPrice,
    required this.rating,
    this.reviewsCount = 0,
    this.soldCount = 0,
    required this.imagePlaceholder,
    this.tags = const [],
    this.description = '',
    this.category = 'All',
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? map['id'],
      name: map['name'] ?? '',
      shopName: map['seller']?['name'] ?? map['shopName'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      oldPrice: map['oldPrice']?.toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
      reviewsCount: map['reviewsCount'] ?? 0,
      soldCount: map['soldCount'] ?? 0,
      imagePlaceholder: (map['images'] != null && map['images'].isNotEmpty) 
        ? map['images'][0] 
        : (map['imagePlaceholder'] ?? '📦'),
      tags: List<String>.from(map['tags'] ?? []),
      description: map['description'] ?? '',
      category: map['category'] ?? 'All',
    );
  }
}
