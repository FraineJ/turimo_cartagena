part of 'social_auth_bloc.dart';

abstract class SocialAuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInWithGoogleEvent extends SocialAuthEvent {}
