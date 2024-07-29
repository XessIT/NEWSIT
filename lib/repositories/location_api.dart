import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:read/repositories/storage.dart';

import '../model/category.dart';
import '../utils/url_endpoints.dart';

class LocationApiService {
  final Dio _dio;
  final SecureStorageService _secureStorageService;

  LocationApiService(this._dio, this._secureStorageService);

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await _dio.post(
        '$categoryUrl',
        data: {
          "filter": {},
          "sort": "_id",
          "order": 1,
          "skip": 0,
          "limit": 10
        },
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Safeguard against null response data
        final responseData = response.data['data'] as List?;
        if (responseData == null) {
          throw Exception('Invalid response data');
        }

        List<Category> categories = responseData
            .map((json) => Category.fromJson(json as Map<String, dynamic>))
            .toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<void> updateLocationSelection(Map<String, dynamic> body) async {
    try {
      String? token = await _secureStorageService.readAccessToken();

      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _dio.put(
        '$locationUrl', // replace with your actual endpoint
        data: jsonEncode(body),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token', // Add the token in the headers
          },
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to update location selection: $e');
    }
  }

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
            'Authorization': 'Bearer $token', // Add the token in the headers
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

}
