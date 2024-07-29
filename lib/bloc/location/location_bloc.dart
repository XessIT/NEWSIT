import 'package:bloc/bloc.dart';
import '../../repositories/location_api.dart';
import '../../repositories/profileApi.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationSelectionBloc extends Bloc<LocationSelectionEvent, LocationSelectionState> {
  final LocationApiService apiService;
  final ProfileApiService profileApiService; // Add this

  LocationSelectionBloc(this.apiService, this.profileApiService)
      : super(LocationSelectionState(
    primaryLocation: '',
    homeTown: '',
    cityOfChoice: '',
    selectedCategories: [],
    categories: [],
    userName: '', // Add userName field to the state
  )) {
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
        // Handle the error appropriately, e.g., emit an error state
        print('Error loading categories: $e');
      }
    });

    on<LoadUserDetails>((event, emit) async {
      try {
        final userDetails = await profileApiService.fetchUserDetails(); // Use the instance method
        emit(state.copyWith(userName: userDetails['name']));
      } catch (e) {
        // Handle the error appropriately, e.g., emit an error state
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
        // Optionally, you could emit a success state here
      } catch (e) {
        // Handle the error appropriately, e.g., emit an error state
        print('Error submitting location selection: $e');
      }
    });
  }
}
