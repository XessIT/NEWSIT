import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../repositories/dio.dart';


class ApiHelper<T> {
  final Dio _dio = DioClient().dio;

  Future<T> getRequest(String endpoint, T Function(dynamic) fromJson) async {
    try {
      final response = await _dio.get(endpoint);
      debugPrint('Raw response data: ${response.data}');  // Add debug print
      return fromJson(response.data);
    } catch (e) {
      debugPrint('Failed to load data: $e');
      throw Exception('Failed to load data: $e');
    }
  }


  Future<T> postRequest(String endpoint, dynamic body, T Function(dynamic) fromJson) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: jsonEncode(body),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      debugPrint('Response data: ${response.data}');
      return fromJson(response.data);
    } catch (e) {
      debugPrint('Failed to post data: $e');
      throw Exception('Failed to post data: $e');
    }
  }

  Future<T> putRequest(String endpoint, dynamic body, T Function(dynamic) fromJson) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: jsonEncode(body),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );
      debugPrint('Response data: ${response.data}');
      return fromJson(response.data);
    } catch (e) {
      debugPrint('Failed to put data: $e');
      throw Exception('Failed to put data: $e');
    }
  }

  Future<T> deleteRequest(String endpoint, T Function(dynamic) fromJson) async {
    try {
      final response = await _dio.delete(endpoint);
      debugPrint('Response data: ${response.data}');
      return fromJson(response.data);
    } catch (e) {
      debugPrint('Failed to delete data: $e');
      throw Exception('Failed to delete data: $e');
    }
  }
}

