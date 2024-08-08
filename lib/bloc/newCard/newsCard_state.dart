import 'package:equatable/equatable.dart';

abstract class NewsFeedState extends Equatable {
  const NewsFeedState();

  @override
  List<Object> get props => [];
}

class NewsFeedInitial extends NewsFeedState {}

class NewsFeedLoading extends NewsFeedState {}

class NewsFeedLiked extends NewsFeedState {}

class NewsFeedDisliked extends NewsFeedState {}

class NewsFeedError extends NewsFeedState {
  final String message;

  const NewsFeedError(this.message);

  @override
  List<Object> get props => [message];
}
