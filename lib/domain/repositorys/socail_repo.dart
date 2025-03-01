import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:turismo_cartagena/core/environments/environment.dart';
import 'package:turismo_cartagena/core/utils/helper/shared_preference_helper.dart';
import 'package:turismo_cartagena/core/utils/method.dart';
import 'package:turismo_cartagena/infrastructure/services/auth/api_service.dart';

import '../models/response_model.dart';


class SocialAuthRepo {
  ApiClient apiClient;

  SocialAuthRepo({required this.apiClient});

  Future<ResponseModel> socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    Map<String, String>? map;

    if (provider == 'google') {
      map = {'token': accessToken, 'provider': "google"};
    }

    if (provider == 'linkedin') {
      map = {'token': accessToken, 'provider': "linkedin"};
    }

    if (provider == 'facebook') {
      map = {'token': accessToken, 'provider': "facebook"};
    }

    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/auth/register-social";


    ResponseModel model =
        await apiClient.request(apiUrl, Method.postMethod, map, passHeader: false);
    return model;
  }

  Future<bool> sendUserToken() async {
    String deviceToken;
    if (apiClient.sharedPreferences
        .containsKey(SharedPreferenceHelper.fcmDeviceKey)) {
      deviceToken = apiClient.sharedPreferences
              .getString(SharedPreferenceHelper.fcmDeviceKey) ??
          '';
    } else {
      deviceToken = '';
    }
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    bool success = false;
    if (deviceToken.isEmpty) {
      firebaseMessaging.getToken().then((fcmDeviceToken) async {
        success = await sendUpdatedToken(fcmDeviceToken ?? '');
      });
    } else {
      firebaseMessaging.onTokenRefresh.listen((fcmDeviceToken) async {
        if (deviceToken == fcmDeviceToken) {
          success = true;
        } else {
          apiClient.sharedPreferences
              .setString(SharedPreferenceHelper.fcmDeviceKey, fcmDeviceToken);
          success = await sendUpdatedToken(fcmDeviceToken);
        }
      });
    }
    return success;
  }

  Future<bool> sendUpdatedToken(String deviceToken) async {

    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/auth/register-social";

    Map<String, String> map = deviceTokenMap(deviceToken);
    await apiClient.request(apiUrl, Method.postMethod, map, passHeader: true);
    return true;
  }

  Map<String, String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }
}
