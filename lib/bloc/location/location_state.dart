import 'package:equatable/equatable.dart';
import '../../model/category.dart';

class LocationSelectionState extends Equatable {
  final List<Category> categories;
  final List<String> selectedCategories;
  final String primaryLocation;
  final String homeTown;
  final String cityOfChoice;
  final String userName;

  LocationSelectionState({
    required this.categories,
    required this.selectedCategories,
    required this.primaryLocation,
    required this.homeTown,
    required this.cityOfChoice,
    required this.userName,
  });

  factory LocationSelectionState.initial() {
    return LocationSelectionState(
      categories: [],
      selectedCategories: [],
      primaryLocation: 'Select',
      homeTown: 'Select',
      cityOfChoice: 'Select',
      userName: '',
    );
  }

  LocationSelectionState copyWith({
    List<Category>? categories,
    List<String>? selectedCategories,
    String? primaryLocation,
    String? homeTown,
    String? cityOfChoice,
    String? userName,
  }) {
    return LocationSelectionState(
      categories: categories ?? this.categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      primaryLocation: primaryLocation ?? this.primaryLocation,
      homeTown: homeTown ?? this.homeTown,
      cityOfChoice: cityOfChoice ?? this.cityOfChoice,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object?> get props => [categories, selectedCategories, primaryLocation, homeTown, cityOfChoice, userName];
}
