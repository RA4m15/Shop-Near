import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import 'repository_providers.dart';

final userProfileProvider = FutureProvider<User>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return await repository.getProfile();
});
