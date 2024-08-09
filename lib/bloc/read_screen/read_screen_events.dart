import 'package:equatable/equatable.dart';

abstract class ReadScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNewsCategories extends ReadScreenEvent {
  final String token;

  FetchNewsCategories(this.token);

  @override
  List<Object> get props => [token];
}
