
import 'package:turismo_cartagena/domain/repositorys/device_user.repository.dart';

class DeviceUserCaseUse {

  final DeviceUserRepository _deviceUserRepository;
  DeviceUserCaseUse(this._deviceUserRepository);

  Future saveInfoDeviceUser(String token) async{
    return await _deviceUserRepository.saveInfoDeviceUser(token);
  }

  Future sendNotificationDeviceUser() async{
    return await _deviceUserRepository.sendNotificationToDeviceUser();
  }
}