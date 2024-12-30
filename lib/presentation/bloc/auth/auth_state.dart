
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

class ErrorRegisterState extends AuthBlocState {}


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