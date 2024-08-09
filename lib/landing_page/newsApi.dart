import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:read/model/api_response.dart';
import '../model/news_model.dart';
import '../repositories/storage.dart';

class NewsService {
  final String baseUrl = 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/news-svc/api/v1/newsfeed';
  final SecureStorageService secureStorageService;

  NewsService({required this.secureStorageService});

  Future<List<News>> fetchNews(int page, int pageSize, String language) async {
    // You should replace the hardcoded token with a dynamic one if needed
    // final token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjMwMjg0NzAsImlkIjoiNjY2ZDM0MTkyZmNhZDMyM2ZmYzM1MDhhIiwidXNlcl9yb2xlIjoiYWRtaW4ifQ.psbzOR7KitRjkN2eGx4bJ3AqyA8RUnfg_WrJMZ1FVJE";
    String? token = await secureStorageService.readAccessToken();
    print('News Api Access Token: $token');
    if (token!.isEmpty) {
      throw Exception('Token is empty');
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
      try {
        final Map<String, dynamic>? jsonResponse = json.decode(response.body) as Map<String, dynamic>?;

        print('JSON Response: $jsonResponse');

        final apiResponse = ApiResponse<List<News>>.fromJson(
          jsonResponse ?? {},
              (data) {
            if (data is List) {
              return data.map((item) {
                if (item is Map<String, dynamic>) {
                  return News.fromJson(item);
                }
                throw Exception('Unexpected item format in data list');
              }).toList();
            }
            throw Exception('Unexpected data format');
          },
        );

        print('API Response: $apiResponse');
        return apiResponse.data ?? [];
      } catch (e) {
        print('Error parsing response: $e'); // Log the parsing error
        throw Exception('Failed to parse response');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized request. Please check your token.');
    } else {
      throw Exception('Failed to load news. Status code: ${response.statusCode}');
    }
  }
}
