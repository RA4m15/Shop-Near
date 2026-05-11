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
}
