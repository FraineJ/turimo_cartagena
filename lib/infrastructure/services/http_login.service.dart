import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_cartagena/domain/models/user.model.dart';
import 'dart:convert';

import 'package:turismo_cartagena/domain/repositorys/auth.repository.dart';
import 'package:turismo_cartagena/presentation/global/environments/environment.dart';

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
          'usernameOrEmail': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        print("envia al bock $body");
        return body;
      } else {
        return null; // O manejar el error de otra manera
      }

    } catch (error) {
      print("envia al bock $error");
      return error;
    }
  }

  @override
  Future register(UserModel user) async {

    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/auth/register";

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: {user});

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
}