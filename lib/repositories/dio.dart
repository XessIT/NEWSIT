import 'package:dio/dio.dart';
import 'package:read/repositories/storage.dart';
import 'interceptor.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    final secureStorageService = SecureStorageService();
    _dio.interceptors.add(AuthInterceptor(secureStorageService, _dio));
  }

  Dio get dio => _dio;
}
