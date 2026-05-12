class Seller {
  final String id;
  final String name;
  final String handle;
  final String location;
  final String avatarPlaceholder;
  final double rating;
  final int followersCount;
  final int productsCount;
  final int salesCount;
  final int reviewsCount;
  final String bio;
  final bool isVerified;
  final bool isLive;

  const Seller({
    required this.id,
    required this.name,
    required this.handle,
    required this.location,
    required this.avatarPlaceholder,
    required this.rating,
    this.followersCount = 0,
    this.productsCount = 0,
    this.salesCount = 0,
    this.reviewsCount = 0,
    this.bio = '',
    this.isVerified = false,
    this.isLive = false,
  });

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      id: map['_id'] ?? map['id'] ?? '',
      name: map['name'] ?? '',
      handle: map['handle'] ?? '@${(map['name'] ?? '').toString().toLowerCase().replaceAll(' ', '')}',
      location: map['location'] ?? 'Near You',
      avatarPlaceholder: map['avatarPlaceholder'] ?? '👤',
      rating: (map['rating'] ?? 0).toDouble(),
      followersCount: map['followersCount'] ?? 0,
      productsCount: map['productsCount'] ?? 0,
      salesCount: map['salesCount'] ?? 0,
      reviewsCount: map['reviewsCount'] ?? 0,
      bio: map['bio'] ?? '',
      isVerified: map['isVerified'] ?? false,
      isLive: map['isLive'] ?? false,
    );
  }
}
