import 'package:equatable/equatable.dart';
import '../../model/category.dart';

class LocationSelectionState extends Equatable {
  final List<Category> categories;
  final List<String> selectedCategories;
  final String primaryLocation;
  final String homeTown;
  final String cityOfChoice;
  final String userName; // Add userName field

  LocationSelectionState({
    required this.categories,
    required this.selectedCategories,
    required this.primaryLocation,
    required this.homeTown,
    required this.cityOfChoice,
    required this.userName, // Initialize userName
  });

  factory LocationSelectionState.initial() {
    return LocationSelectionState(
      categories: [],
      selectedCategories: [],
      primaryLocation: 'Select',
      homeTown: 'Select',
      cityOfChoice: 'Select',
      userName: '', // Default userName to an empty string
    );
  }

  LocationSelectionState copyWith({
    List<Category>? categories,
    List<String>? selectedCategories,
    String? primaryLocation,
    String? homeTown,
    String? cityOfChoice,
    String? userName, // Add userName to copyWith
  }) {
    return LocationSelectionState(
      categories: categories ?? this.categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      primaryLocation: primaryLocation ?? this.primaryLocation,
      homeTown: homeTown ?? this.homeTown,
      cityOfChoice: cityOfChoice ?? this.cityOfChoice,
      userName: userName ?? this.userName, // Copy userName
    );
  }

  @override
  List<Object?> get props => [categories, selectedCategories, primaryLocation, homeTown, cityOfChoice, userName];
}
