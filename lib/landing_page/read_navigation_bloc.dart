import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Event
abstract class ReadNavigationEvent extends Equatable {
  const ReadNavigationEvent();
}

class SelectReadPageEvent extends ReadNavigationEvent {
  final int index;
  const SelectReadPageEvent(this.index);

  @override
  List<Object> get props => [index];
}

// State
class ReadNavigationState extends Equatable {
  final int selectedIndex;
  const ReadNavigationState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}

// BLoC
class ReadNavigationBloc extends Bloc<SelectReadPageEvent, ReadNavigationState> {
  ReadNavigationBloc() : super(const ReadNavigationState(0)) {
    on<SelectReadPageEvent>((event, emit) {
      emit(ReadNavigationState(event.index));
    });
  }
}
