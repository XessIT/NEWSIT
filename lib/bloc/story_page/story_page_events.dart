import 'package:equatable/equatable.dart';

import '../../model/read_story_model.dart';


abstract class StoryPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStories extends StoryPageEvent {
  final NewsCategory category;

  LoadStories(this.category);

  @override
  List<Object> get props => [category];
}
