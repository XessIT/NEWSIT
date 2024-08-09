import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../repositories/likeApi.dart';
import '../../repositories/saveApi.dart';
import 'newsCard_event.dart';
import 'newsCard_state.dart';


class NewsCardBloc extends Bloc<NewsCardEvent, NewsCardState> {
  final NewsApiService newsApiService;
  final SaveApiService saveApiService;

  NewsCardBloc(this.newsApiService, this.saveApiService) : super(NewsFeedInitial()) {
    on<LikeNewsEvent>(_onLikeNews);
    on<DislikeNewsEvent>(_onDislikeNews);
    on<SaveNewsEvent>(_onSaveNews);
    on<UnsaveNewsEvent>(_onUnsaveNews);
  }

  Future<void> _onLikeNews(LikeNewsEvent event, Emitter<NewsCardState> emit) async {
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

  Future<void> _onDislikeNews(DislikeNewsEvent event, Emitter<NewsCardState> emit) async {
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

  Future<void> _onSaveNews(SaveNewsEvent event, Emitter<NewsCardState> emit) async {
    emit(NewsFeedLoading());
    try {
      final response = await saveApiService.saveNews(event.newsId);
      if (response.status == 200) {
        emit(NewsFeedSaved());
      } else {
        emit(NewsFeedError('Failed to save news: ${response.message}'));
      }
    } catch (e) {
      emit(NewsFeedError('Error: $e'));
    }
  }

  Future<void> _onUnsaveNews(UnsaveNewsEvent event, Emitter<NewsCardState> emit) async {
    emit(NewsFeedLoading());
    try {
      final response = await saveApiService.unsaveNews(event.newsId);
      if (response.status == 200) {
        emit(NewsFeedUnsaved());
      } else {
        emit(NewsFeedError('Failed to unsave news: ${response.message}'));
      }
    } catch (e) {
      emit(NewsFeedError('Error: $e'));
    }
  }
}
