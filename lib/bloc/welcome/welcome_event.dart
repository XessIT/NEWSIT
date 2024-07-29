import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object?> get props => [];
}

class SubmitWelcomeForm extends WelcomeEvent {
  final String name;
  final String mobileNumber;
  final String dateOfBirth;
  final String gender;

  const SubmitWelcomeForm({
    required this.name,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.gender,
  });

  @override
  List<Object?> get props => [name, mobileNumber, dateOfBirth, gender];
}
