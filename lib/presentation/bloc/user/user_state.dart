part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}


class LoadingRequestedState extends UserState{}

//UPLOAD AVATAR USER
class SuccessUploadAvatarState extends UserState{}

class ErrorUploadAvatarState extends UserState{}
//UPLOAD AVATAR USER END

//GET INFO USER
class LoadingInfoUser extends UserState{}

class GetUsersSuccessState extends UserState{
  final UserModel userModel;
   GetUsersSuccessState({required this.userModel});
}

class GetUsersErrorState extends UserState{}
//GET INFO USER END

//UPDATE INFO USER STATES
class SuccessUpdateUserState extends UserState {}

class ErrorUpdateUserState extends UserState{}