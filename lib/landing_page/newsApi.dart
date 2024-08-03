import 'dart:convert';
import 'package:http/http.dart' as http;
import '../repositories/storage.dart';


class NewsService {
  final String baseUrl = 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/news-svc/api/v1/newsfeed';
  final SecureStorageService secureStorageService;

  NewsService({required this.secureStorageService});

  Future<List<dynamic>> fetchNews(int page, int pageSize, String language) async {
    final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjI2MDMwODIsImlkIjoiNjY2ZDM0MTkyZmNhZDMyM2ZmYzM1MDhhIiwidXNlcl9yb2xlIjoiYWRtaW4ifQ.hXXTDKE-ITDVwN4XZuldu1CU25-Exxm56R_Y_yszl-g';

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl?page=$page&page_size=$pageSize'),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept-Language': language,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized request. Please check your token.');
    } else {
      throw Exception('Failed to load news');
    }
  }
}
