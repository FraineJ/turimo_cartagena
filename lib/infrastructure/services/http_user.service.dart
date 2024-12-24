import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_cartagena/domain/models/respose.model.dart';
import 'package:turismo_cartagena/domain/models/user.model.dart';
import 'package:turismo_cartagena/domain/repositorys/user.repository.dart';
import 'package:turismo_cartagena/presentation/global/environments/environment.dart';
import 'package:http/http.dart' as http;


class HttpUserService extends UserRepository {

  @override
  Future getInfoUser() async {
    final environment = await Environment.forEnvironment('environment-dev');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String dataUser = prefs.getString('user_login') ?? '';
    final jsonMap = json.decode(dataUser);
    String userId = jsonMap['id']!;
    String apiUrl = '${environment.baseUrl}/users/listById/${userId}';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final body = jsonDecode(response.body);

    final List<dynamic> jsonDataList = body["data"] as List<dynamic>;
    final List<UserModel> users = jsonDataList.map((jsonData) => UserModel.fromJson(jsonData)).toList();

    if(response.statusCode == 200) {
      return users;
    }

    return [];

  }

  @override
  Future<void> updateInfoUse(Map data) {
    // TODO: implement updateInfoUse
    throw UnimplementedError();
  }


  Future uploadAvatarUser(XFile avatar) async {
    try {
      final environment = await Environment.forEnvironment('environment-dev');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String dataUser = prefs.getString('user_login') ?? '';
      final jsonMap = json.decode(dataUser);
      String userId = jsonMap['id']!;

      String apiUrl = '${environment.baseUrl}/users/uploadAvatar/${userId}';

      final request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
      request.headers['Content-Type'] = 'multipart/form-data';

      request.files.add(await http.MultipartFile.fromPath(
        'avatar',
        avatar.path,
      ));

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      final body = jsonDecode(response.body);
      final ResponsePages dataResponse = ResponsePages.fromJson(body);

      return dataResponse;
    } catch (error) {
      return error;
    }
  }



}
