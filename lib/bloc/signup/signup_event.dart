import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SentOTPEvent extends SignupEvent {
  final String mobileNumber;

  const SentOTPEvent(this.mobileNumber);

  @override
  List<Object?> get props => [mobileNumber];
}

class VerifyOTPEvent extends SignupEvent {
  final String mobileNumber;
  final String otp;

  const VerifyOTPEvent(this.mobileNumber, this.otp);

  @override
  List<Object?> get props => [mobileNumber, otp];
}

class GoogleSignInEvent extends SignupEvent {}
