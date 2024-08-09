import 'package:equatable/equatable.dart';

abstract class NewsCardState extends Equatable {
  const NewsCardState();

  @override
  List<Object> get props => [];
}

class NewsFeedInitial extends NewsCardState {}

class NewsFeedLoading extends NewsCardState {}

class NewsFeedLiked extends NewsCardState {}

class NewsFeedDisliked extends NewsCardState {}

class NewsFeedSaved extends NewsCardState {}

class NewsFeedUnsaved extends NewsCardState {}



class NewsFeedError extends NewsCardState {
  final String message;

  const NewsFeedError(this.message);

  @override
  List<Object> get props => [message];
}
