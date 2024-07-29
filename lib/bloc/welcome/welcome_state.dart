import 'package:equatable/equatable.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object?> get props => [];
}

class WelcomeInitial extends WelcomeState {}

class WelcomeLoading extends WelcomeState {}

class WelcomeSuccess extends WelcomeState {}

class WelcomeFailure extends WelcomeState {
  final String error;

  const WelcomeFailure(this.error);

  @override
  List<Object?> get props => [error];
}
