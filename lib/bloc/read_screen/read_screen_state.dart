import 'package:equatable/equatable.dart';

import '../../model/news_model.dart';

abstract class ReadScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class ReadScreenInitial extends ReadScreenState {}

class ReadScreenLoading extends ReadScreenState {}

class ReadScreenLoaded extends ReadScreenState {
  final List<NewsCategory> newsCategories;

  ReadScreenLoaded(this.newsCategories);

  @override
  List<Object> get props => [newsCategories];
}

class ReadScreenError extends ReadScreenState {
  final String error;

  ReadScreenError(this.error);

  @override
  List<Object> get props => [error];
}
