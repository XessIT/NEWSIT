import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';

class ApiService {
  static const String baseUrl = 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/news-svc/api/v1/news-stories';

  static Future<NewsCategoryResponse> fetchNewsCategories(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept-Language': 'en', // or the language you prefer
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return NewsCategoryResponse.fromJson(json.decode(response.body));
    } else {
      print('Failed to load news categories: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to load news categories');
    }
  }

}
