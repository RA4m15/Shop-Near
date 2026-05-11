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
}
