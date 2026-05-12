import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import 'repository_providers.dart';

final sellerOrdersProvider = FutureProvider<List<Order>>((ref) async {
  final repository = ref.watch(orderRepositoryProvider);
  return await repository.getOrders();
});

final orderDetailsProvider = FutureProvider.family<Order, String>((ref, orderId) async {
  final repository = ref.watch(orderRepositoryProvider);
  final orders = await repository.getOrders();
  return orders.firstWhere((o) => o.id == orderId);
});
