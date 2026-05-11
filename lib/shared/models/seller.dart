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
}
