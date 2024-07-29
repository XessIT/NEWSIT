import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read/bloc/signup/signup_event.dart';
import 'package:read/bloc/signup/signup_state.dart';


import '../../repositories/location_api.dart';
import '../../repositories/signup/signup_action.dart';
import '../../repositories/storage.dart';
 // Import your service for fetching user details

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupAction signupAction = SignupAction();
  final SecureStorageService secureStorageService = SecureStorageService();
  final LocationApiService locationApiService = LocationApiService(Dio(),SecureStorageService()); // Your service for user details

  SignupBloc() : super(const SignupState()) {
    on<SentOTPEvent>((event, emit) => _mapSentOtpLogic(event, emit));
    on<VerifyOTPEvent>((event, emit) => _mapVerifyOtpLogic(event, emit));
  }

  Future<void> _mapSentOtpLogic(SentOTPEvent event, Emitter<SignupState> emit) async {
    final response = await signupAction.sendOtp(event.mobileNumber);

    // Debug prints to confirm response
    print('API Response Status: ${response?.status}');
    print('API Response Message: ${response?.message}');
    print('API Response Data: ${response?.data}');

    if (response?.status == 200) {
      emit(const OtpSentSuccess());
      print("OTP sent successfully");
    } else {
      emit(const OtpSentSuccess());
    }
  }

  Future<void> _mapVerifyOtpLogic(VerifyOTPEvent event, Emitter<SignupState> emit) async {
    final token = await signupAction.verifyOtp(event.mobileNumber, event.otp);

    if (token != null && token.accessToken.isNotEmpty) {
      await secureStorageService.writeAccessToken(token.accessToken);
      await secureStorageService.writeRefreshToken(token.refreshToken);

      // Fetch user details
      final userDetails = await locationApiService.fetchUserDetails();

      if (userDetails != null && userDetails['name'] != null) {
        emit(VerifyOtpSuccess(isUserDetailsEmpty: false));
      } else {
        emit(VerifyOtpSuccess(isUserDetailsEmpty: true));
      }
    } else {
      emit(VerifyOtpFailure());
    }
  }
}
