import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNews extends NewsEvent {
  final int page;
  final int pageSize;
  final String language;

  const FetchNews(this.page, this.pageSize, this.language);

  @override
  List<Object> get props => [page, pageSize, language];
}
