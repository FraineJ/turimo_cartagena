

import 'package:turismo_cartagena/domain/models/user.model.dart';
import 'package:turismo_cartagena/domain/repositorys/auth.repository.dart';

class AuthCaseUse {

  final AbstractAuthRepository _authRepository;
  AuthCaseUse(this._authRepository);

  Future login(String username, String password) async{
    return await _authRepository.login(username, password);
  }

  Future register(UserModel user) async{
    return await _authRepository.register(user);
  }

  Future<bool> logout() async {
    return await _authRepository.logout();
  }

  Future<bool> isUserAuthenticated() async {
    return _authRepository.isUserAuthenticated();
  }

  Future recoverPassword(String email) async {
    return _authRepository.recoverPassword(email);
  }

  Future verifyOtp(String code) async{
    return await _authRepository.verifyOtp(code);
  }
}