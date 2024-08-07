import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:read/repositories/storage.dart';

import '../utils/url_endpoints.dart';

class ProfileApiService {
  final Dio _dio;
  final SecureStorageService _secureStorageService;

  ProfileApiService(this._dio, this._secureStorageService);

  Future<Map<String, dynamic>> fetchUserDetails() async {
    try {
      String? token = await _secureStorageService.readAccessToken();
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _dio.get(
        '$WelcomeUrl', // replace with your actual endpoint
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      throw Exception('Failed to fetch user details: $e');
    }
  }

  Future<http.Response> submitProfile({
    required String name,
    required String mobileNumber,
    required String dateOfBirth,
    required String gender,
  }) async {
    final String? token = await _secureStorageService.readAccessToken();
    final Map<String, dynamic> requestBody = {
      "name": name,
      "mobile_number": mobileNumber,
      "date_of_birth": dateOfBirth,
      "gender": gender,
    };

    final response = await http.put(
      Uri.parse('YOUR_UPDATE_PROFILE_ENDPOINT'), // replace with your actual endpoint
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(requestBody),
    );

    return response;
  }
}
