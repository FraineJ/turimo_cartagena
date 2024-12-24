import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'initial_event.dart';
part 'initial_state.dart';

class InitialBloc extends Bloc<InitialEvent, InitialState> {
  InitialBloc()
      : super(const InitialState(
    isAuthenticated: false,
  )) {
    on<AppInitialEvent>((event, emit) async {
      await _initIsAuthenticated(emit);
    });

    on<IsAuthenticatedEvent>((event, emit) {
      emit(state.copyWith(
        isAuthenticated: event.isAuthenticated,
      ));
    });

    add(AppInitialEvent());
  }

  Future<void> _initIsAuthenticated(Emitter<InitialState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAuthenticated = prefs.containsKey('user_login');

    emit(state.copyWith(isAuthenticated: isAuthenticated));
  }
}
