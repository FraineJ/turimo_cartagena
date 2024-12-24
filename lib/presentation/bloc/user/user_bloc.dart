import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:turismo_cartagena/domain/models/respose.model.dart';
import 'package:turismo_cartagena/domain/models/user.model.dart';
import 'package:turismo_cartagena/domain/usecases/user.usecases.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserCaseUse  userCaseUse;

  UserBloc(this.userCaseUse) : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }


  Future getInfoUser(GetUserInfoEvent event, Emitter<UserState> emit) async {
    emit(LoadingInfoUser());

    final List<UserModel> response = await userCaseUse.getInfoUser();

    if(response.isNotEmpty){
      emit(GetUsersSuccessState(userModel: response[0]));
    }  else {
      emit(GetUsersErrorState());
    }

  }

  Future uploadAvatarUser(UploadAvatarUserEvent event, Emitter<UserState> emit ) async {
     final ResponsePages response = await userCaseUse.uploadAvatarUser(event.image);

     if(response.status == 200) {
       emit(SuccessUploadAvatarState());
     } else {
       emit(ErrorUploadAvatarState());
     }
  }

  Future<void>  updateInfoUse(Map data) async {
  }


}
