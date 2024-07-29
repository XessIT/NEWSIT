import 'package:flutter_bloc/flutter_bloc.dart';
import 'newsApi.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsApiService _newsApiService = NewsApiService();

  NewsBloc() : super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await _newsApiService.fetchNews(event.skip, event.limit);
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError('Failed to fetch news'));
      }
    });
  }
}

abstract class NewsEvent {}

class FetchNewsEvent extends NewsEvent {
  final int skip;
  final int limit;

  FetchNewsEvent(this.skip, this.limit);
}

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<dynamic> news;

  NewsLoaded(this.news);
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
