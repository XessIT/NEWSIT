import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final String mobileNumber;

  const SignupState({this.mobileNumber = ''});

  SignupState copyWith({String? mobileNumber}) {
    return SignupState(
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }

  @override
  List<Object?> get props => [mobileNumber];
}

class OtpSentSuccess extends SignupState {
  const OtpSentSuccess();

  @override
  List<Object> get props => [];
}

class OtpSentFailure extends SignupState {}

class VerifyOtpSuccess extends SignupState {
  final bool isUserDetailsEmpty;

  const VerifyOtpSuccess({required this.isUserDetailsEmpty});

  @override
  List<Object> get props => [isUserDetailsEmpty];
}

class VerifyOtpFailure extends SignupState {}

class GoogleSigninSuccess extends SignupState {
  final String displayName;
  final String email;
  final String idToken;
  final String photoUrl;

  const GoogleSigninSuccess(this.displayName, this.email, this.idToken, this.photoUrl);

  @override
  List<Object> get props => [displayName, email, idToken, photoUrl];
}

class GoogleSigninFailure extends SignupState {}
