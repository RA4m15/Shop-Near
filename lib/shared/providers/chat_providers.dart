import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_preview.dart';
import 'repository_providers.dart';

final chatListProvider = FutureProvider<List<ChatPreview>>((ref) async {
  final repository = ref.watch(chatRepositoryProvider);
  return await repository.getChatList();
});
