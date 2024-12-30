import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:turismo_cartagena/domain/models/event.model.dart';
import 'package:turismo_cartagena/domain/repositorys/device_user.repository.dart';
import 'dart:convert';
import 'package:turismo_cartagena/presentation/global/environments/environment.dart';

class HttpDeviceUserService extends DeviceUserRepository {



  @override
  Future saveInfoDeviceUser(String token) async {
    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/device/create";

    try {
      if(token.isEmpty){
        return [];
      }

      final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body:  jsonEncode({"token" : token})
      );

      final body = jsonDecode(response.body);
      final List<dynamic> jsonDataList = body["data"] as List<dynamic>;
      final List<EventModel> category = jsonDataList.map((jsonData) => EventModel.fromJson(jsonData)).toList();

      if(response.statusCode == 200) {
        return category;
      }

      return [];

    }
    catch (error) {
      return error;
    }
  }

  @override
  Future sendNotificationToDeviceUser() {
    // TODO: implement sendNotificationToDeviceUser
    throw UnimplementedError();
  }
}
