import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/repository_providers.dart';

final authStateProvider = StateProvider<bool>((ref) => false);

final loginProvider = FutureProvider.family<void, Map<String, String>>((ref, credentials) async {
  final repository = ref.watch(authRepositoryProvider);
  await repository.login(credentials['email']!, credentials['password']!);
  ref.read(authStateProvider.notifier).state = true;
});

final registerProvider = FutureProvider.family<void, Map<String, dynamic>>((ref, userData) async {
  final repository = ref.watch(authRepositoryProvider);
  await repository.register(userData);
  ref.read(authStateProvider.notifier).state = true;
});
