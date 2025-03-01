part of 'social_auth_bloc.dart';

abstract class SocialAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SocialAuthInitial extends SocialAuthState {}

class SocialAuthLoading extends SocialAuthState {}

class SocialAuthSuccess extends SocialAuthState {
  final dynamic user; // Puedes cambiar el tipo según el modelo de usuario
  SocialAuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SocialAuthFailure extends SocialAuthState {
  final String error;
  SocialAuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
