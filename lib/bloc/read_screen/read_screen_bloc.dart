import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/news_stories_api.dart';
import 'read_screen_events.dart';
import 'read_screen_state.dart';

class ReadScreenBloc extends Bloc<ReadScreenEvent, ReadScreenState> {
  ReadScreenBloc() : super(ReadScreenInitial()) {
    on<FetchNewsCategories>(_onFetchNewsCategories);
  }

  Future<void> _onFetchNewsCategories(
      FetchNewsCategories event,
      Emitter<ReadScreenState> emit,
      ) async {
    emit(ReadScreenLoading());
    try {
      final response = await ApiService.fetchNewsCategories(event.token);
      emit(ReadScreenLoaded(response.data));
    } catch (e) {
      emit(ReadScreenError(e.toString()));
    }
  }
}
