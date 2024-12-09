part of 'event_bloc.dart';

@immutable
sealed class EventEvent {}


class GetEventEvent extends EventEvent {}