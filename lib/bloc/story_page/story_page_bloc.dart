import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:story_view/story_view.dart';
import 'story_page_events.dart';
import 'story_page_state.dart';

class StoryPageBloc extends Bloc<StoryPageEvent, StoryPageState> {
  final StoryController _storyController = StoryController();

  StoryPageBloc() : super(StoryPageInitial()) {
    on<LoadStories>(_onLoadStories);
  }

  Future<void> _onLoadStories(
      LoadStories event,
      Emitter<StoryPageState> emit,
      ) async {
    emit(StoryPageLoading());
    try {
      List<StoryItem> storyItems = event.category.news.map((newsItem) {
        return StoryItem.pageImage(
          url: newsItem.newsCardImage?.originalUrl ?? 'https://via.placeholder.com/150',
          caption: Text(newsItem.webContent),
          controller: _storyController, // Providing the controller
        );
      }).toList();
      emit(StoryPageLoaded(storyItems));
    } catch (e) {
      emit(StoryPageError(e.toString()));
    }
  }
}
