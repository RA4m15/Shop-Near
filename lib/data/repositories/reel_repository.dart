import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/api_endpoints.dart';
import '../../shared/models/reel.dart';

class ReelRepository {
  final ApiClient _apiClient;

  ReelRepository(this._apiClient);

  Future<List<Reel>> getAllReels() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.reels);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => Reel.fromMap(item)).toList();
      }
      throw Exception('Failed to load reels');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadReel(XFile videoFile, String caption) async {
    try {
      final bytes = await videoFile.readAsBytes();
      
      // Ensure the filename has an extension so Dio sends the correct content-type
      String filename = videoFile.name;
      if (filename.isEmpty || !filename.contains('.')) {
        filename = 'upload.mp4';
      }

      final formData = FormData.fromMap({
        'video': MultipartFile.fromBytes(bytes, filename: filename),
        'caption': caption,
      });

      final response = await _apiClient.post(ApiEndpoints.reels, data: formData);
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception('Failed to upload reel: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map && data.containsKey('message')) {
          throw Exception(data['message']);
        }
        throw Exception('Server error: ${e.response?.statusCode}');
      }
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }
}
