import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/live_session.dart';
import 'repository_providers.dart';

final liveSessionsProvider = FutureProvider<List<LiveSession>>((ref) async {
  final repository = ref.watch(liveSessionRepositoryProvider);
  return await repository.getLiveSessions();
});
