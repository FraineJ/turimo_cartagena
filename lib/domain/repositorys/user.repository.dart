import 'package:image_picker/image_picker.dart';

abstract class UserRepository {

  Future getInfoUser();

  Future<void> uploadAvatarUser(XFile avatar);

  Future<void>  updateInfoUse(Map data);

}