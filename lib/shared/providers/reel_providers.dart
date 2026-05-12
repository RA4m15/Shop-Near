import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reel.dart';
import 'repository_providers.dart';

final reelsProvider = FutureProvider<List<Reel>>((ref) async {
  final repository = ref.watch(reelRepositoryProvider);
  return await repository.getAllReels();
});
