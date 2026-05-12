import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'repository_providers.dart';
import '../models/seller.dart';
import '../models/product.dart';

final sellersProvider = FutureProvider<List<Seller>>((ref) async {
  final repository = ref.watch(sellerRepositoryProvider);
  return await repository.getAllSellers();
});

final sellerAnalyticsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(sellerRepositoryProvider);
  return await repository.getAnalytics();
});

final sellerProductsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(sellerRepositoryProvider);
  return await repository.getSellerProducts();
});
