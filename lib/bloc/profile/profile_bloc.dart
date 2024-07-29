// profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../repositories/profileApi.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileApiService profileApiService;

  ProfileBloc({required this.profileApiService})
      : super(ProfileState(
    name: '',
    phoneNumber: '',
    email: '',
    dateOfBirth: '',
    gender: '',
  )) {
    on<LoadProfile>((event, emit) async {
      try {
        final profileData = await profileApiService.fetchUserDetails();
        print('Profile Data: $profileData'); // Debug print

        emit(state.copyWith(
          name: profileData['name'] ?? '',
          phoneNumber: profileData['mobile_number'] ?? '',
          email: profileData['email'] ?? '',
          dateOfBirth: profileData['date_of_birth'] ?? '',
          gender: profileData['gender'] ?? '',
        ));
      } catch (e) {
        print('Error fetching profile data: $e'); // Debug print
      }
    });

    on<EditName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<ChangePhoneNumber>((event, emit) {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    });

    on<EditGender>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });
  }
}



