import 'package:bloc/bloc.dart';
import '../../repositories/profileApi.dart';
import 'menu_event.dart';
import 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final ProfileApiService _profileApiService;

  MenuBloc(this._profileApiService) : super(MenuInitial()) {
    on<FetchUserProfile>(_onFetchUserProfile);
  }

  Future<void> _onFetchUserProfile(FetchUserProfile event, Emitter<MenuState> emit) async {
    emit(MenuLoading());
    try {
      final userProfile = await _profileApiService.fetchUserDetails();
      emit(MenuLoaded(userProfile));
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }
}
