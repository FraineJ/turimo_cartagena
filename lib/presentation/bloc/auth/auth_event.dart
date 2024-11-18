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
  final String email;
  final String name;
  final String username;
  final String numberPhone;
  final String password;
  final String nacionalidad;
  const RegisterEvent(this.name, this.email, this.password, this.username, this.numberPhone, this.nacionalidad );
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();

  List<Object?> get props => [];
}


class ErrorRequested extends AuthEvent {
  const ErrorRequested();

  List<Object?> get props => [];
}
