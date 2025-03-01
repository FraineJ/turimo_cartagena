import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:turismo_cartagena/domain/usecases/auth.usecases.dart';

part 'social_auth_event.dart';
part 'social_auth_state.dart';

class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  final AuthCaseUse authCaseUse;

  SocialAuthBloc({required this.authCaseUse}) : super(SocialAuthInitial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<SocialAuthState> emit) async {
    emit(SocialAuthLoading());
    try {
      final user = await authCaseUse.signInWithGoogle();
      emit(SocialAuthSuccess(user));
    } catch (e) {
      emit(SocialAuthFailure(error: e.toString()));
    }
  }
}
