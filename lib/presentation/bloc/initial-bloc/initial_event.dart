part of 'initial_bloc.dart';

class InitialEvent extends Equatable {

  const InitialEvent();

  @override
  List<Object?> get props => [];

}

class AppInitialEvent extends InitialEvent {}

class IsAuthenticatedEvent extends InitialEvent {

  final bool isAuthenticated;

  const IsAuthenticatedEvent({
    required this.isAuthenticated
  });

}