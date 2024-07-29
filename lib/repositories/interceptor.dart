import 'package:dio/dio.dart';
import 'package:read/repositories/storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService secureStorageService;
  final Dio _dio;

  AuthInterceptor(this.secureStorageService, this._dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorageService.readAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await secureStorageService.readRefreshToken();
      if (refreshToken != null) {
        try {
          final newToken = await _refreshToken(refreshToken);
          if (newToken != null) {
            await secureStorageService.writeAccessToken(newToken);
            // Retry the request with the new token
            final retryOptions = Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': 'Bearer $newToken',
              },
            );
            final cloneReq = await _dio.request(
              err.requestOptions.path,
              options: retryOptions,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );
            return handler.resolve(cloneReq);
          } else {
            await secureStorageService.clearAllTokens();
            // Navigate to the login screen
            // This can be implemented based on your navigation setup
          }
        } catch (e) {
          await secureStorageService.clearAllTokens();
          // Navigate to the login screen
          // This can be implemented based on your navigation setup
        }
      }
    }
    return super.onError(err, handler);
  }

  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post('your_refresh_token_url', data: {
        'refresh_token': refreshToken,
      });
      if (response.statusCode == 200) {
        return response.data['access_token'];
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }
}
