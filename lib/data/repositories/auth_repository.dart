import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/api_endpoints.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final _storage = const FlutterSecureStorage();

  AuthRepository(this._apiClient);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiClient.post(ApiEndpoints.login, data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        await _storage.write(key: 'jwt_token', value: data['token']);
        await _storage.write(key: 'user_role', value: data['user']['role']);
        return data;
      }
      throw Exception('Login failed');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await _apiClient.post(ApiEndpoints.register, data: userData);
      if (response.statusCode == 201) {
        final data = response.data;
        await _storage.write(key: 'jwt_token', value: data['token']);
        if (data['user'] != null && data['user']['role'] != null) {
          await _storage.write(key: 'user_role', value: data['user']['role']);
        }
        return data;
      }
      throw Exception('Registration failed');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
    await _storage.delete(key: 'user_role');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'jwt_token');
    return token != null;
  }
}
