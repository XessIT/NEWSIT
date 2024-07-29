import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../model/city.dart';
import '../../repositories/city_api.dart';
import 'city_event.dart';
import 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityApiService apiService;

  CityBloc(this.apiService) : super(CityInitial()) {
    on<FetchCities>(_onFetchCities);
  }

  Future<void> _onFetchCities(FetchCities event, Emitter<CityState> emit) async {
    emit(CityLoading());
    try {
      List<City> cities = await CityApiService.fetchCities();
      emit(CityLoadSuccess(cities));
    } catch (e) {
      emit(CityLoadFailure(e.toString()));
    }
  }
}
