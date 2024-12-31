import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_cartagena/domain/models/respose.model.dart';
import 'package:turismo_cartagena/domain/models/user.model.dart';
import 'package:turismo_cartagena/domain/repositorys/auth.repository.dart';
import 'package:turismo_cartagena/presentation/global/environments/environment.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as Global;
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpLoginService extends AbstractAuthRepository {
  @override
  Future login(String? username, String? password) async {

    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/auth/login";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Establecer el tipo de contenido
        },
        body: jsonEncode({
          'email': username,
          'password': password,
        }),
      );

      final body = jsonDecode(response.body);

      if (body["status"] == 200) {

        return body;
      } else {
        return null; // O manejar el error de otra manera
      }

    } catch (error) {
      return error;
    }
  }

  @override
  Future register(UserModel user) async {

    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/users/insertar";

    try {
      final response = await http.post(Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(user.toJson())
      );

      final body = jsonDecode(response.body);

      return body;
    } catch (error) {
      return error;
    }
  }

  @override
  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }

  @override
  Future<bool> isUserAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user_login');
  }

  @override
  Future recoverPassword(String email) async {
    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/mail/sendMailRecoveryPassword";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Establecer el tipo de contenido
        },
        body: jsonEncode({
          'email': email
        }),
      );

      final body = jsonDecode(response.body);
      ResponsePages responsePages = ResponsePages.fromJson(body);

      return responsePages;

    } catch (error) {
      return error;
    }
  }


  @override
  Future verifyOtp(String code) async {
    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/mail/validateCodeOTP";

    try {
      Map<String, String> userDetails = await Global.Utils.getLocalInfo();
      final String? userId = userDetails['id'];


      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'code': code, 'id': userId})
      );

      final body = jsonDecode(response.body);
      final ResponsePages dataResponse = ResponsePages.fromJson(body);

      return dataResponse;

    } catch (error) {
      return error;
    }
  }

  @override
  Future changePassword(String password) async {
    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/mail/validateCodeOTP";

    try {
      Map<String, String> userDetails = await Global.Utils.getLocalInfo();
      final String? userId = userDetails['id'];


      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'code': password, 'id': userId})
      );

      final body = jsonDecode(response.body);
      final ResponsePages dataResponse = ResponsePages.fromJson(body);

      return dataResponse;

    } catch (error) {
      return error;
    }
  }
}
