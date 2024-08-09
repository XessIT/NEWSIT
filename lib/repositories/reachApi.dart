import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:read/repositories/storage.dart';

import '../utils/url_endpoints.dart';

class ReachApiService {
  final Dio _dio;
  final SecureStorageService _secureStorageService;

  ReachApiService(this._dio, this._secureStorageService);

  Future<Response<dynamic>> submitReach({
    required String comment,
    required String company_name,
    required String email,
    required String phone_number,
  }) async {
    final String? token = await _secureStorageService.readAccessToken();
    final Map<String, dynamic> requestBody = {
      "comment": comment,
      "mobile_number": company_name,
      "company_name": email,
      "phone_number": phone_number,
    };

    final response = await _dio.post(
      reachUrl, // replace with your actual endpoint
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
      data: requestBody,
    );

    return response;
  }
}
