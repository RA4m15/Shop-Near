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
}
