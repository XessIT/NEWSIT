import 'package:equatable/equatable.dart';

import '../../model/city.dart';


abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoadSuccess extends CityState {
  final List<City> cities;

  CityLoadSuccess(this.cities);

  @override
  List<Object> get props => [cities];
}

class CityLoadFailure extends CityState {
  final String error;

  CityLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
