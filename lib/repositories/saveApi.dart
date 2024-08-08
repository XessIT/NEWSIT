import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:read/repositories/storage.dart';
import '../model/api_response.dart';

class SaveApiService {
  final String baseUrl;
  final SecureStorageService secureStorageService;

  SaveApiService({required this.baseUrl, required this.secureStorageService});

  Future<ApiResponse<void>> saveNews(String newsId) async {
    // final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjMwMjg0NzAsImlkIjoiNjY2ZDM0MTkyZmNhZDMyM2ZmYzM1MDhhIiwidXNlcl9yb2xlIjoiYWRtaW4ifQ.psbzOR7KitRjkN2eGx4bJ3AqyA8RUnfg_WrJMZ1FVJE";
    String? token = await secureStorageService.readAccessToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final url = '$baseUrl/core-svc/api/v1/news/$newsId/save';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ApiResponse<void>(status: 200, message: 'Success', data: null);
    } else {
      final errorResponse = json.decode(response.body);
      return ApiResponse<void>(
        status: response.statusCode,
        message: errorResponse['message'] ?? 'Error',
        data: null,
      );
    }
  }

  Future<ApiResponse<void>> unsaveNews(String newsId) async {
    // final String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjMwMjg0NzAsImlkIjoiNjY2ZDM0MTkyZmNhZDMyM2ZmYzM1MDhhIiwidXNlcl9yb2xlIjoiYWRtaW4ifQ.psbzOR7KitRjkN2eGx4bJ3AqyA8RUnfg_WrJMZ1FVJE";
    String? token = await secureStorageService.readAccessToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final url = '$baseUrl/core-svc/api/v1/news/$newsId/unsave';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ApiResponse<void>(status: 200, message: 'Success', data: null);
    } else {
      final errorResponse = json.decode(response.body);
      return ApiResponse<void>(
        status: response.statusCode,
        message: errorResponse['message'] ?? 'Error',
        data: null,
      );
    }
  }
}