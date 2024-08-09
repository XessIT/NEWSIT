import 'package:equatable/equatable.dart';

abstract class NewsCardEvent extends Equatable {
  const NewsCardEvent();

  @override
  List<Object> get props => [];
}

class LikeNewsEvent extends NewsCardEvent {
  final String newsId;

  const LikeNewsEvent(this.newsId);

  @override
  List<Object> get props => [newsId];
}

class DislikeNewsEvent extends NewsCardEvent {
  final String newsId;

  const DislikeNewsEvent(this.newsId);

  @override
  List<Object> get props => [newsId];
}

class SaveNewsEvent extends NewsCardEvent {
  final String newsId;

  const SaveNewsEvent(this.newsId);

  @override
  List<Object> get props => [newsId];
}

class UnsaveNewsEvent extends NewsCardEvent {
  final String newsId;

  const UnsaveNewsEvent(this.newsId);

  @override
  List<Object> get props => [newsId];
}

