import 'package:turismo_cartagena/domain/repositorys/place.repository.dart';
import 'package:turismo_cartagena/domain/models/place.model.dart';
import 'package:turismo_cartagena/presentation/global/environments/environment.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as Global;
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpPlaceService extends PlaceRepository {

  @override
  Future getPlaceByCategory(String id) async {
    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/lugar/list/$id";

    try {
      final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
      );

      final body = jsonDecode(utf8.decode(response.bodyBytes));

      final List<dynamic> jsonDataList = body as List<dynamic>;
      final List<PlaceModel> place = jsonDataList.map((jsonData) => PlaceModel.fromJson(jsonData)).toList();

      if(response.statusCode == 200) {
        return place;
      }

      return [];

    } catch (error) {
      return error;
    }
  }


  @override
  Future addPlaceFavorite(int id) async {

    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/lugar/add-favorite/$id";

    Map<String, String> userDetails = await Global.Utils.getUserDetails();
    String token = userDetails['token']!;

    try {
      final response = await http.get(Uri.parse(
        apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final body = jsonDecode(response.body);
      print("response $body");

      if(response.statusCode == 200) {
        return body;
      }

      return [];

    } catch (error) {
      print("error $error" );
      return error;
    }
  }

  @override
  Future<List<PlaceModel>> addPlaceFavoriteByUser() async {
    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/lugar/favorites-by-user";

    Map<String, String> userDetails = await Global.Utils.getUserDetails();
    String token = userDetails['token']!;

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final body = jsonDecode(response.body);

      final List<dynamic> jsonDataList = body as List<dynamic>;
      final List<PlaceModel> place = jsonDataList.map((jsonData) => PlaceModel.fromJson(jsonData)).toList();

      if(response.statusCode == 200) {
        print("Lista de favoritos $place");
        return place;
      }

      return [];

    } catch (error) {
      print("error $error" );
      return [];
    }
  }
}
