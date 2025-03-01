import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'social_auth_event.dart';
part 'social_auth_state.dart';

class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  SocialAuthBloc() : super(SocialAuthInitial()) {
    on<SocialAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
