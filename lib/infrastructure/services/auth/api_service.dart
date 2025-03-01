import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_cartagena/core/utils/helper/shared_preference_helper.dart';
import 'package:turismo_cartagena/core/utils/method.dart';
import 'package:turismo_cartagena/domain/models/response_model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import '../../../domain/models/authorization/authorization_response_model.dart';
import '../../helpers/router-helper.dart';

class ApiClient extends GetxService {
  final SharedPreferences sharedPreferences;
  String token = '';
  String tokenType = '';

  ApiClient({required this.sharedPreferences}) {
    token = sharedPreferences.getString(SharedPreferenceHelper.token) ?? '';
    tokenType = sharedPreferences.getString(SharedPreferenceHelper.accessTokenType) ?? '';
  }

  Future<ResponseModel> request(
      String uri,
      String method,
      Map<String, dynamic>? params, {
        bool passHeader = false,
        bool isOnlyAcceptType = false,
      }) async {
    Uri url = Uri.parse(uri);
    http.Response response;
    Map<String, String> headers = {
      "Accept": "application/json",
      "dev-token": "\$2y\$12\$mEVBW3QASB5HMBv8igls3ejh6zw2A0Xb480HWAmYq6BY9xEifyBjG",
    };

    if (passHeader && !isOnlyAcceptType) {
      headers["Authorization"] = "$tokenType $token";
    }

    try {
      switch (method) {
        case Method.postMethod:
          response = await http.post(url, body: params, headers: headers);
          break;
        case Method.deleteMethod:
          response = await http.delete(url, headers: headers);
          break;
        case Method.updateMethod:
          response = await http.patch(url, body: params, headers: headers);
          break;
        default:
          response = await http.get(url, headers: headers);
          break;
      }

      return _handleResponse(response);
    } on SocketException {
      return ResponseModel(false, S.current.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, S.current.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, S.current.somethingWentWrong.tr, 499, '');
    }
  }

  ResponseModel _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        if (response.body.isEmpty) {
          Get.offAllNamed(RouteHelper.loginScreen);
        }
        return ResponseModel(true, 'Success', 200, response.body);
      case 401:
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(false, 'Unauthorized', 401, '');
      case 500:
        return ResponseModel(false, 'Internal Server Error', 500, '');
      default:
        return ResponseModel(false, 'Error ${response.statusCode}', response.statusCode, response.body);
    }
  }
}
