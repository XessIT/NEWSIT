import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:read/bloc/welcome/welcome_event.dart';
import 'package:read/bloc/welcome/welcome_state.dart';

import '../../repositories/profileApi.dart';


class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final ProfileApiService profileApiService;

  WelcomeBloc({required this.profileApiService}) : super(WelcomeInitial()) {
    on<SubmitWelcomeForm>(_onSubmitWelcomeForm);
  }

  Future<void> _onSubmitWelcomeForm(
      SubmitWelcomeForm event,
      Emitter<WelcomeState> emit,
      ) async {
    emit(WelcomeLoading());

    try {
      final response = await profileApiService.submitProfile(
        name: event.name,
        mobileNumber: event.mobileNumber,
        dateOfBirth: event.dateOfBirth,
        gender: event.gender,
      );

      if (response.statusCode == 200) {
        emit(WelcomeSuccess());
      } else {
        final responseData = json.decode(response.body);
        final message = responseData['message'] ?? 'An error occurred';
        emit(WelcomeFailure(message));
      }
    } catch (error) {
      emit(WelcomeFailure(error.toString()));
    }
  }
}
