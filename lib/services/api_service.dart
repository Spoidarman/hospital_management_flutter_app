import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'storage_service.dart';

class ApiService {
  final StorageService _storageService = StorageService();

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body,
      {bool requiresAuth = false}) async {
    try {
      String? token;
      if (requiresAuth) {
        token = await _storageService.getToken();
      }

      final response = await http.post(
        Uri.parse(url),
        headers: ApiConfig.getHeaders(token: token),
        body: json.encode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> get(String url,
      {bool requiresAuth = true}) async {
    try {
      String? token;
      if (requiresAuth) {
        token = await _storageService.getToken();
      }

      final response = await http.get(
        Uri.parse(url),
        headers: ApiConfig.getHeaders(token: token),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> body) async {
    try {
      final token = await _storageService.getToken();

      final response = await http.put(
        Uri.parse(url),
        headers: ApiConfig.getHeaders(token: token),
        body: json.encode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> delete(String url) async {
    try {
      final token = await _storageService.getToken();

      final response = await http.delete(
        Uri.parse(url),
        headers: ApiConfig.getHeaders(token: token),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final data = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return {'success': true, 'data': data};
    } else {
      return {
        'success': false,
        'message': data['message'] ?? 'Something went wrong'
      };
    }
  }
}
