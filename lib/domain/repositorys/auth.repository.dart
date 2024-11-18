import 'package:turismo_cartagena/domain/models/user.model.dart';

abstract class AbstractAuthRepository {

  Future login(String username, String password);

  Future register(UserModel user);

  Future<bool> logout();

  Future<bool> isUserAuthenticated();
}