import 'package:bloc/bloc.dart';

import '../../landing_page/newsApi.dart';
import 'newsFeed_event.dart';
import 'newsFeed_state.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService newsService;

  NewsBloc(this.newsService) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await newsService.fetchNews(event.page, event.pageSize, event.language);
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}
