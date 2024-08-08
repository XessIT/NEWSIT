import 'package:equatable/equatable.dart';

abstract class NewsFeedEvent extends Equatable {
  const NewsFeedEvent();

  @override
  List<Object> get props => [];
}

class LikeNewsEvent extends NewsFeedEvent {
  final String newsId;

  const LikeNewsEvent(this.newsId);

  @override
  List<Object> get props => [newsId];
}

class DislikeNewsEvent extends NewsFeedEvent {
  final String newsId;

  const DislikeNewsEvent(this.newsId);

  @override
  List<Object> get props => [newsId];
}

class SaveNewsEvent extends NewsFeedEvent {
  final String newsId;

  const SaveNewsEvent(this.newsId);

  @override
  List<Object> get props => [newsId];
}

class UnsaveNewsEvent extends NewsFeedEvent {
  final String newsId;

  const UnsaveNewsEvent(this.newsId);

  @override
  List<Object> get props => [newsId];
}

