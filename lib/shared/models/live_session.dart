class LiveSession {
  final String id;
  final String sellerId;
  final String sellerName;
  final String title;
  final String category;
  final int viewers;
  final String thumbnailPlaceholder;

  const LiveSession({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.title,
    required this.category,
    required this.viewers,
    required this.thumbnailPlaceholder,
  });

  factory LiveSession.fromMap(Map<String, dynamic> map) {
    return LiveSession(
      id: map['_id'] ?? map['id'] ?? '',
      sellerId: map['seller']?['_id'] ?? map['sellerId'] ?? '',
      sellerName: map['seller']?['name'] ?? map['sellerName'] ?? 'Seller',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      viewers: map['viewers'] ?? 0,
      thumbnailPlaceholder: map['thumbnailPlaceholder'] ?? '📺',
    );
  }
}
