part of 'auth_bloc.dart';

abstract class AuthEvent  {
  const AuthEvent();
}


class AuthInitialEvent extends AuthEvent {
  const AuthInitialEvent();
}


class AppStartedEvent extends AuthEvent {
  const AppStartedEvent();

  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {

  final String name;
  final String lastName;
  final String email;
  final String nationality;
  final String password;

  const RegisterEvent({required  this.name, required this.lastName, required this.email, required this.nationality, required this.password});
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();

  List<Object?> get props => [];
}


class ErrorRequested extends AuthEvent {
  const ErrorRequested();

  List<Object?> get props => [];
}


class RecoverPasswordEvent extends AuthEvent {
  final String email;
  const RecoverPasswordEvent({required this.email});
}


class VerifyCodeOtpEvent extends AuthEvent {
  final String code;
  const VerifyCodeOtpEvent(this.code);
}