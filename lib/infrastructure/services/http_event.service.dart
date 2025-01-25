import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:turismo_cartagena/domain/models/event.model.dart';
import 'dart:convert';
import 'package:turismo_cartagena/domain/repositorys/event.repository.dart';
import 'package:turismo_cartagena/core/environments/environment.dart';

class HttpEventsService extends EventRepository {

  @override
  Future getAllEvents() async {


    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/events/list";

    try {
      final response = await http.get(
          Uri.parse(apiUrl)
      ).timeout(Duration(seconds: 5));

      final body = jsonDecode(response.body);
      final List<dynamic> jsonDataList = body["data"] as List<dynamic>;
      final List<EventModel> category = jsonDataList.map((jsonData) => EventModel.fromJson(jsonData)).toList();

      if(response.statusCode == 200) {
        return category;
      }

      return [];

    } on TimeoutException {

      return [];
    }
    catch (error) {
      return error;
    }
  }
}
