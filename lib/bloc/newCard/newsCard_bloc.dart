import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../repositories/likeApi.dart';
import 'newsCard_event.dart';
import 'newsCard_state.dart';


class NewsFeedBloc extends Bloc<NewsFeedEvent, NewsFeedState> {
  final NewsApiService newsApiService;

  NewsFeedBloc(this.newsApiService) : super(NewsFeedInitial()) {
    on<LikeNewsEvent>(_onLikeNews);
    on<DislikeNewsEvent>(_onDislikeNews);
  }

  Future<void> _onLikeNews(LikeNewsEvent event, Emitter<NewsFeedState> emit) async {
    emit(NewsFeedLoading());
    try {
      final response = await newsApiService.likeNews(event.newsId);
      if (response.status == 200) {
        emit(NewsFeedLiked());
      } else {
        emit(NewsFeedError('Failed to like news: ${response.message}'));
      }
    } catch (e) {
      emit(NewsFeedError('Error: $e'));
    }
  }

  Future<void> _onDislikeNews(DislikeNewsEvent event, Emitter<NewsFeedState> emit) async {
    emit(NewsFeedLoading());
    try {
      final response = await newsApiService.dislikeNews(event.newsId);
      if (response.status == 200) {
        emit(NewsFeedDisliked());
      } else {
        emit(NewsFeedError('Failed to dislike news: ${response.message}'));
      }
    } catch (e) {
      emit(NewsFeedError('Error: $e'));
    }
  }
}
