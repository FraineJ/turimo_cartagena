
part  of 'auth_bloc.dart';

abstract class AuthBlocState extends Equatable  {
  const AuthBlocState();

  @override
  List<Object> get props => [];

}
class LoginStarted extends AuthBlocState {}

class LoginRequestedState extends AuthBlocState {}

class LogoutRequestedState extends AuthBlocState {}

class LoadingRequestedState extends AuthBlocState {}

class ErrorAuthenticationState extends AuthBlocState {}

class SuccessAuthenticationState extends AuthBlocState {}

class LogoutRequestedSuccessState extends AuthBlocState {}

// STATES REGISTER
class LoadingRRegisterState extends AuthBlocState {}

class SuccessRegisterState extends AuthBlocState {}

class ErrorRegisterState extends AuthBlocState {
  final ResponsePages responsePages;
  const ErrorRegisterState({required this.responsePages});

  @override
  List<Object> get props => [responsePages];
}


// STATES RECOVERY PASSWORD
class LoadingRecoverPasswordState extends AuthBlocState {}

class SuccessRecoverPasswordState extends AuthBlocState {
  final ResponsePages responsePages;
  const SuccessRecoverPasswordState({required this.responsePages});

  @override
  List<Object> get props => [responsePages];

}

class ErrorRecoverPasswordState extends AuthBlocState {
  final ResponsePages responsePages;
  const ErrorRecoverPasswordState({required this.responsePages});

  @override
  List<Object> get props => [responsePages];
}


// STATES VERIFY CODE

class VerifyCodeSuccessState extends AuthBlocState {
  final ResponsePages responsePages;
  const VerifyCodeSuccessState({required this.responsePages});

  @override
  List<Object> get props => [responsePages];
}

class VerifyCodeErrorState extends AuthBlocState {
  final ResponsePages responsePages;
  const VerifyCodeErrorState({required this.responsePages});

  @override
  List<Object> get props => [responsePages];
}

class VerifyCodeLoadingState extends AuthBlocState {}


// STATES CHANGE PASSWORD

class LoadingChangePasswordState extends AuthBlocState {}

class SuccessChangePasswordState extends AuthBlocState {
  final ResponsePages responsePages;
  const SuccessChangePasswordState({required this.responsePages});

  @override
  List<Object> get props => [responsePages];

}

class ErrorChangePasswordState extends AuthBlocState {
  final ResponsePages responsePages;
  const ErrorChangePasswordState({required this.responsePages});

  @override
  List<Object> get props => [responsePages];
}



class SocialAuthLoading extends AuthBlocState {}

class SocialAuthSuccess extends AuthBlocState {
  final dynamic user; // Puedes cambiar el tipo según el modelo de usuario
  const SocialAuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class SocialAuthFailure extends AuthBlocState {
  final String error;
  const SocialAuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}
