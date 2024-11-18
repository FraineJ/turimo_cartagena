
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

