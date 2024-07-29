
import 'package:read/repositories/signup/signup_repo.dart';

import '../../model/api_response.dart';
import '../../model/signup/otp.dart';
import '../../model/signup/token.dart';
import '../../utils/api_helper.dart';
import '../../utils/url_endpoints.dart';
import '../storage.dart';

class SignupAction extends SignupRepository {
  final ApiHelper _apiHelper = ApiHelper();

  @override
  Future<ApiResponse<OtpData>?> sendOtp(String mobileNumber) async {
    final requestBody = {
      "mobile_number": mobileNumber
    };

    try {
      print('Sending OTP request with payload: $requestBody');
      final response = await _apiHelper.postRequest(
        otpUrl,
        requestBody,
            (json) => ApiResponse<OtpData>.fromJson(
            json as Map<String, dynamic>,
                (data) => OtpData.fromJson(data as Map<String, dynamic>)
        ),
      );

      // Debug print for the response
      print('Response data: $response');

      return response;
    } catch (e) {
      print('Error sending OTP: $e');
      return null;
    }
  }

  @override
  Future<Token?> verifyOtp(String mobileNumber, String otp) async {
    final requestBody = {
      "mobile_number": mobileNumber,
      "otp": otp
    };

    try {
      final response = await _apiHelper.postRequest(
        verifyotpUrl,
        requestBody,
            (json) => Token.fromJson(json as Map<String, dynamic>),
      );

      if (response != null) {
        final secureStorageService = SecureStorageService();
        await secureStorageService.writeAccessToken(response.accessToken);
        await secureStorageService.writeRefreshToken(response.refreshToken);
        print('Access Token: ${response.accessToken}'); // Debug print
        print('Refresh Token: ${response.refreshToken}'); // Debug print
      }

      return response;
    } catch (e) {
      print('Error verifying OTP: $e');
      return null;
    }
  }

  @override
  Future<Token?> loginGoogle(String idToken, String name, String email, String photoUrl) async {
    final requestBody = {
      "id_token": idToken, "name": name, "email": email, "photo_url": photoUrl
    };

    try {
      final response = await _apiHelper.postRequest(
        googleUrl,
        requestBody,
            (json) => Token.fromJson(json as Map<String, dynamic>),
      );

      if (response != null) {
        final secureStorageService = SecureStorageService();
        await secureStorageService.writeAccessToken(response.accessToken);
        await secureStorageService.writeRefreshToken(response.refreshToken);
      }

      return response;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }
}
