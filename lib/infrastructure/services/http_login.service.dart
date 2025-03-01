import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_cartagena/domain/models/respose.model.dart';
import 'package:turismo_cartagena/domain/models/user.model.dart';
import 'package:turismo_cartagena/domain/repositorys/auth.repository.dart';
import 'package:turismo_cartagena/core/environments/environment.dart';
import 'package:turismo_cartagena/core/utils/all.dart' as Global;
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpLoginService extends AbstractAuthRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


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

      print("response register ${body}");

      final ResponsePages dataResponse = ResponsePages.fromJson(body);
      return dataResponse;

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
      print("recoverPassword $body");
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
    print("changePassword");
    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/auth/changePassword";

    try {
      Map<String, String> userDetails = await Global.Utils.getLocalInfo();
      print("changePassword ${userDetails}");
      final String? userId = userDetails['id'];


      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'password': password, 'id': userId})
      );

      final body = jsonDecode(response.body);
      final ResponsePages dataResponse = ResponsePages.fromJson(body);

      return dataResponse;

    } catch (error) {
      return error;
    }
  }

  @override
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // El usuario canceló el inicio de sesión

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print("user google ${googleAuth}");
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      UserModel userModel = UserModel(
          name: user!.displayName ?? "",
          lastName: '',
          email: user.email ?? "",
          password: '',
          nationality: '',
          status: 'ACTIVE',
      );
      await register(userModel);

      return userCredential.user;
    } catch (e) {
      print("Error en Google Sign-In: $e");
      throw Exception("Error en Google Sign-In");
    }
  }
}
