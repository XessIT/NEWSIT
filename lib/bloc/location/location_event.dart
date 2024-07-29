import 'package:equatable/equatable.dart';

abstract class LocationSelectionEvent extends Equatable {
  const LocationSelectionEvent();

  @override
  List<Object> get props => [];
}

class PrimaryLocationChanged extends LocationSelectionEvent {
  final String primaryLocation;

  const PrimaryLocationChanged(this.primaryLocation);

  @override
  List<Object> get props => [primaryLocation];
}

class HomeTownChanged extends LocationSelectionEvent {
  final String homeTown;

  const HomeTownChanged(this.homeTown);

  @override
  List<Object> get props => [homeTown];
}

class CityOfChoiceChanged extends LocationSelectionEvent {
  final String cityOfChoice;

  const CityOfChoiceChanged(this.cityOfChoice);

  @override
  List<Object> get props => [cityOfChoice];
}

class CategoriesChanged extends LocationSelectionEvent {
  final List<String> selectedCategories;

  const CategoriesChanged(this.selectedCategories);

  @override
  List<Object> get props => [selectedCategories];
}

class LoadCategories extends LocationSelectionEvent {}

class LoadUserDetails extends LocationSelectionEvent {}

class SubmitLocationSelection extends LocationSelectionEvent {}
