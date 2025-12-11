import '../config/api_config.dart';
import '../models/user_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiService.post(
      ApiConfig.login,
      {'email': email, 'password': password},
    );

    if (response['success']) {
      final token = response['data']['token'];
      final user = response['data']['user'];

      await _storageService.saveToken(token);
      await _storageService.saveUser(user);
    }

    return response;
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password, String role,
      {String? specialization}) async {
    final body = {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      if (specialization != null) 'specialization': specialization,
    };

    final response = await _apiService.post(ApiConfig.register, body);

    if (response['success']) {
      final token = response['data']['token'];
      final user = response['data']['user'];

      await _storageService.saveToken(token);
      await _storageService.saveUser(user);
    }

    return response;
  }

  Future<UserModel?> getCurrentUser() async {
    final userData = await _storageService.getUser();
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  Future<void> logout() async {
    await _storageService.clearAll();
  }
}
