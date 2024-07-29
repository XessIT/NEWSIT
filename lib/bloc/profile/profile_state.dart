import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String name;
  final String phoneNumber;
  final String email;
  final String dateOfBirth;
  final String gender;

  ProfileState({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
  });

  ProfileState copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? dateOfBirth,
    String? gender,
  }) {
    return ProfileState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object> get props => [name, phoneNumber, email, dateOfBirth, gender];
}
