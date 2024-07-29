// profile_event.dart
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class EditName extends ProfileEvent {
  final String name;

  EditName(this.name);

  @override
  List<Object> get props => [name];
}

class ChangePhoneNumber extends ProfileEvent {
  final String phoneNumber;

  ChangePhoneNumber(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class EditGender extends ProfileEvent {
  final String gender;

  EditGender(this.gender);

  @override
  List<Object> get props => [gender];
}
