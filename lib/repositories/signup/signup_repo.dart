
import '../../model/api_response.dart';
import '../../model/signup/otp.dart';
import '../../model/signup/token.dart';

abstract class SignupRepository {
  Future<ApiResponse<OtpData>?> sendOtp(String mobileNumber);
  Future<Token?>verifyOtp(String mobileNumber, String otp);
  Future<Token?>loginGoogle(String id_token, String name, String email, String photo_url);
}
