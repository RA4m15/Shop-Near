import '../../core/network/api_client.dart';
import '../../core/constants/api_endpoints.dart';
import '../../shared/models/chat_preview.dart';

class ChatRepository {
  final ApiClient _apiClient;

  ChatRepository(this._apiClient);

  Future<List<ChatPreview>> getChatList() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.chat);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => ChatPreview.fromMap(item)).toList();
      }
      throw Exception('Failed to load chats');
    } catch (e) {
      rethrow;
    }
  }
}
