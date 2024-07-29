import 'package:dio/dio.dart';

class GoogleSignInRepository {
  final Dio _dio;

  GoogleSignInRepository(this._dio);

  Future<Response> signInWithGoogle(String token) async {
    return await _dio.post(
      'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/core-svc/api/v1/users/login-google',
      data: {'token': token},
    );
  }
}
