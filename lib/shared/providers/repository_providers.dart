import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_client.dart';
import '../../core/network/socket_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/reel_repository.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/repositories/live_session_repository.dart';
import '../../data/repositories/cart_repository.dart';
import '../../data/repositories/seller_repository.dart';

final socketServiceProvider = Provider((ref) => SocketService());

final apiClientProvider = Provider((ref) => ApiClient());

final authRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient);
});

final productRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProductRepository(apiClient);
});

final orderRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return OrderRepository(apiClient);
});

final userRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserRepository(apiClient);
});

final reelRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReelRepository(apiClient);
});

final chatRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ChatRepository(apiClient);
});

final liveSessionRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return LiveSessionRepository(apiClient);
});

final cartRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CartRepository(apiClient);
});

final sellerRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SellerRepository(apiClient);
});
