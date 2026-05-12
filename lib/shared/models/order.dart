class Order {
  final String id;
  final String productId;
  final String productName;
  final String buyerName;
  final double amount;
  final String status; // Pending, Packing, Delivered, Cancelled
  final String paymentMethod;
  final DateTime orderDate;
  final String productPlaceholder;

  const Order({
    required this.id,
    required this.productId,
    required this.productName,
    required this.buyerName,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    required this.orderDate,
    required this.productPlaceholder,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    final productMap = map['product'] as Map<String, dynamic>?;
    final images = productMap?['images'] as List<dynamic>?;
    
    return Order(
      id: map['_id'] ?? map['id'],
      productId: productMap?['_id'] ?? map['productId'] ?? '',
      productName: productMap?['name'] ?? map['productName'] ?? '',
      buyerName: map['buyer']?['name'] ?? map['buyerName'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      status: map['status'] ?? 'Pending',
      paymentMethod: map['paymentMethod'] ?? 'COD',
      orderDate: DateTime.parse(map['orderDate'] ?? DateTime.now().toIso8601String()),
      productPlaceholder: (images != null && images.isNotEmpty)
          ? images[0]
          : (map['productPlaceholder'] ?? '📦'),
    );
  }
}
