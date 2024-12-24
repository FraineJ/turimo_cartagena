part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}


class GetUserInfoEvent extends UserEvent{}

class UploadAvatarUserEvent extends UserEvent{
  final XFile image;
  UploadAvatarUserEvent(this.image);
}


class UpdateInfoUserEvent extends UserState {}