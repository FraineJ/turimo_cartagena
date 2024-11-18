part of 'initial_bloc.dart';

@immutable
sealed class InitialEvent {}

class AppInitialEvent extends InitialEvent {
}

class IsAuthenticatedEvent extends InitialEvent {
}