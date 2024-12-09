part of 'event_bloc.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}

//GET CATEGORY STATE
class LoadingGetEvent extends EventState {}

class SuccessGetEvent extends EventState {

  final List<EventModel> events;
  SuccessGetEvent({required this.events} );

  @override
  List<Object> get props => [events];
}

class ErrorGetEvent extends EventState {}