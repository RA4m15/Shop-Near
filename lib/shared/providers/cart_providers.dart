import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import 'repository_providers.dart';

final cartProvider = FutureProvider<List<CartItem>>((ref) async {
  final repository = ref.watch(cartRepositoryProvider);
  return await repository.getCart();
});
