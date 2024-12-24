import 'package:image_picker/image_picker.dart';
import 'package:turismo_cartagena/domain/repositorys/user.repository.dart';

class UserCaseUse {

  final UserRepository _userRepository;
  UserCaseUse(this._userRepository);

  Future getInfoUser() async {
    return await _userRepository.getInfoUser();
  }

  Future uploadAvatarUser(XFile avatar) async {
    return await _userRepository.uploadAvatarUser(avatar);
  }

  Future<void>  updateInfoUse(Map data) async {
    return await _userRepository.updateInfoUse(data);
  }

}