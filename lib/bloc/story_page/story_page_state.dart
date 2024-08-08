import 'package:equatable/equatable.dart';
import 'package:story_view/story_view.dart';

abstract class StoryPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class StoryPageInitial extends StoryPageState {}

class StoryPageLoading extends StoryPageState {}

class StoryPageLoaded extends StoryPageState {
  final List<StoryItem> storyItems;

  StoryPageLoaded(this.storyItems);

  @override
  List<Object> get props => [storyItems];
}

class StoryPageError extends StoryPageState {
  final String error;

  StoryPageError(this.error);

  @override
  List<Object> get props => [error];
}
