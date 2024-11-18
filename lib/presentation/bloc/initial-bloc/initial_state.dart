part of 'initial_bloc.dart';

@immutable
sealed class InitialState {}

class AppStartedState extends InitialState {}

class IsAuthenticatedState extends InitialState {}

class IsAuthenticatedSuccess extends InitialState {
}

class IsAuthenticatedFailure extends InitialState {
}
