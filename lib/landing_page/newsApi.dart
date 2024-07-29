import 'package:dio/dio.dart';
import '../repositories/storage.dart';
import '../utils/url_endpoints.dart';
 // Your secure storage service to get the token

class NewsApiService {
  final Dio _dio = Dio();
  final SecureStorageService _storageService = SecureStorageService();

  Future<List<dynamic>> fetchNews(int skip, int limit) async {
    final token = await _storageService.readAccessToken();
    final response = await _dio.get(
      '$getNewsUrl',
      queryParameters: {'skip': skip, 'limit': limit},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data as List<dynamic>;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
