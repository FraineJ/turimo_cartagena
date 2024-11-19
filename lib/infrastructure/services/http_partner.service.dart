import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/domain/repositorys/partner.repository.dart';
import 'package:turismo_cartagena/presentation/global/environments/environment.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as Global;
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpPartnerService extends PartnerRepository {

  @override
  Future getPartnerByCategory(String id) async {
    print("llego el id ${id}");
    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/partners/getPartnerByCategory/$id";

    try {
      final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
      );

      final body = jsonDecode(utf8.decode(response.bodyBytes));
      print("body el id ${body["data"]}");
      final List<dynamic> jsonDataList = body["data"] as List<dynamic>;
      final List<PartnersModel> partner = jsonDataList.map((jsonData) => PartnersModel.fromJson(jsonData)).toList();

      if(response.statusCode == 200) {
        return partner;
      }

      return [];

    } catch (error) {
      return error;
    }
  }


  @override
  Future addPartnerFavorite(int id) async {

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
  Future addPartnerFavoriteByUser() async {
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
      final List<PartnersModel> place = jsonDataList.map((jsonData) => PartnersModel.fromJson(jsonData)).toList();

      if(response.statusCode == 200) {
        return place;
      }

      return [];

    } catch (error) {
      print("error $error" );
      return error;
    }
  }
}
