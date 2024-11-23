import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:turismo_cartagena/domain/usecases/auth.usecases.dart';

part 'initial_event.dart';
part 'initial_state.dart';
class InitialBloc extends Bloc<InitialEvent, InitialState> {
  final AuthCaseUse authUseCase;

  InitialBloc(this.authUseCase) : super(AppStartedState()) {
    on<AppInitialEvent>(_initialApp);
    on<IsAuthenticatedEvent>(_isAuthenticated);
  }

  void _initialApp(AppInitialEvent event, Emitter<InitialState> emit) async {
    add(IsAuthenticatedEvent());
  }

  Future<void> _isAuthenticated(IsAuthenticatedEvent event, Emitter<InitialState> emit) async {
    bool response = await this.authUseCase.isUserAuthenticated();
    if (response) {
      emit(IsAuthenticatedSuccess());
    } else {
      emit(IsAuthenticatedFailure());
    }
  }
}
