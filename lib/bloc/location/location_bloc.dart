import 'package:bloc/bloc.dart';
import '../../repositories/location_api.dart';
import '../../repositories/profileApi.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationSelectionBloc extends Bloc<LocationSelectionEvent, LocationSelectionState> {
  final LocationApiService apiService;
  final ProfileApiService profileApiService;

  LocationSelectionBloc(this.apiService, this.profileApiService)
      : super(LocationSelectionState.initial()) {
    on<PrimaryLocationChanged>((event, emit) {
      emit(state.copyWith(primaryLocation: event.primaryLocation));
    });

    on<HomeTownChanged>((event, emit) {
      emit(state.copyWith(homeTown: event.homeTown));
    });

    on<CityOfChoiceChanged>((event, emit) {
      emit(state.copyWith(cityOfChoice: event.cityOfChoice));
    });

    on<CategoriesChanged>((event, emit) {
      emit(state.copyWith(selectedCategories: event.selectedCategories));
    });

    on<LoadCategories>((event, emit) async {
      try {
        final categories = await apiService.fetchCategories();
        emit(state.copyWith(categories: categories));
      } catch (e) {
        print('Error loading categories: $e');
      }
    });

    on<LoadUserDetails>((event, emit) async {
      try {
        final userDetails = await profileApiService.fetchUserDetails();
        emit(state.copyWith(
          userName: userDetails['name'] as String,
          primaryLocation: (userDetails['preferences']['city_1']['name'] as String?) ?? '',
          homeTown: (userDetails['preferences']['city_2']['name'] as String?) ?? '',
          cityOfChoice: (userDetails['preferences']['city_3']['name'] as String?) ?? '',
          selectedCategories: (userDetails['preferences']['categories'] as List<dynamic>)
              .map<String>((category) => category['id'] as String)
              .toList(),
        ));
      } catch (e) {
        print('Error loading user details: $e');
      }
    });

    on<SubmitLocationSelection>((event, emit) async {
      try {
        await apiService.updateLocationSelection({
          'notifications_enabled': true,
          'categories': state.selectedCategories,
          'city_1': state.primaryLocation,
          'city_2': state.homeTown,
          'city_3': state.cityOfChoice,
        });
      } catch (e) {
        print('Error submitting location selection: $e');
      }
    });
  }
}
