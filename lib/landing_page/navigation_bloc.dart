// navigation_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class SelectPageEvent extends NavigationEvent {
  final int index;

  const SelectPageEvent(this.index);

  @override
  List<Object> get props => [index];
}

class NavigationState extends Equatable {
  final int selectedIndex;

  const NavigationState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(0)) {
    on<SelectPageEvent>((event, emit) {
      emit(NavigationState(event.index));
    });
  }
}
