abstract class DeviceUserRepository {

  Future saveInfoDeviceUser(String token);

  Future sendNotificationToDeviceUser();

}