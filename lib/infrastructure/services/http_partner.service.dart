import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/domain/models/respose.model.dart';
import 'package:turismo_cartagena/domain/repositorys/partner.repository.dart';
import 'package:turismo_cartagena/core/environments/environment.dart';
import 'package:turismo_cartagena/core/utils/all.dart' as Global;
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpPartnerService extends PartnerRepository {

  @override
  Future getPartnerByCategory(String id) async {
    final environment = await Environment.forEnvironment('environment-dev');

    Map<String, String> userDetails = await Global.Utils.getUserDetails();
    final String? userId = userDetails['id'];

    String apiUrl = "${environment.baseUrl}/partners/getPartnerByCategory/$id";
    if (userId != null && userId.isNotEmpty) {
      apiUrl += "/$userId";
    }


    try {
      final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
      );

      final body = jsonDecode(utf8.decode(response.bodyBytes));

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
  Future<ResponsePages> addPartnerFavorite(String id) async {

    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/favorite/add";

    Map<String, String> userDetails = await Global.Utils.getUserDetails();
    String userId = userDetails['id']!;

    final response = await http.post(Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "partnerId": id,
        "userId": userId
      })
    );

    final  body = jsonDecode(response.body);
    final ResponsePages dataResponse =  ResponsePages.fromJson(body);

    if(dataResponse.status == 200) {
      return dataResponse;
    }

    return dataResponse;

  }

  @override
  Future getPartnerFavoriteByUser() async {
    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl = "${environment.baseUrl}/favorite/lista";

    Map<String, String> userDetails = await Global.Utils.getUserDetails();
    String userId = userDetails['id']!;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "userId": userId,
        }),
      );

      final body = jsonDecode(response.body);

      if (body["status"] == 200) {
        final List<Map<String, dynamic>> jsonDataList = List<Map<String, dynamic>>.from(body["data"]);
        return jsonDataList;
      }

      return [];
    } catch (error) {
      print("error $error");
      return {"error": error.toString()};
    }
  }

}
