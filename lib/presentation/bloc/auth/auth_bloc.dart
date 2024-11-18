import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:turismo_cartagena/domain/models/login-response.dart';
import 'package:turismo_cartagena/domain/models/user.model.dart';
import 'package:turismo_cartagena/domain/usecases/auth.usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final AuthCaseUse authCaseUse;

  AuthBloc(this.authCaseUse) : super(LoginStarted()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<LogoutRequested>(_logout);
  }

  Future _login(LoginEvent event, Emitter<AuthBlocState> emit) async {
    final user = event.email;
    final pass = event.password;

    emit(LoadingRequestedState());

    try {
      final  response = await authCaseUse.login(user, pass);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      LoginResponse loginResponse = LoginResponse(
          tokenType: response['tokenType'],
          tokenAcces: response['tokenAcces'],
          name: response['userDTO']['name'],
          ok: response['ok']
      );

      String userJson = jsonEncode(loginResponse);

      if (loginResponse.ok) {
        prefs.setString('user_login', userJson);

        emit(SuccessAuthenticationState());
      } else{
        emit(ErrorAuthenticationState());
      }
    } catch (error) {
      print("login ${error}");
      emit(ErrorAuthenticationState());
    }

  }

  Future _register(RegisterEvent event, Emitter<AuthBlocState> emit) async {

    final UserModel user = UserModel(
        username: event.username,
        name: event.name,
        email: event.email,
        numberPhone: event.numberPhone,
        password: event.password,
        nacionalidad: event.nacionalidad
    );

    emit(LoadingRRegisterState());

    final  response = await authCaseUse.register(user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dataResponse = UserModel.fromJson(response);

    if (dataResponse.hashCode == 200) {
      final data = jsonEncode(dataResponse);
      prefs.setString('user_login', data);
      emit(SuccessRegisterState());
    } else{
      emit(ErrorRegisterState());
    }
  }

  Future _logout(LogoutRequested event, Emitter<AuthBlocState> emit) async {
    emit(LoadingRequestedState());
    final response = await authCaseUse.logout();
    if (response == true) {
      emit(LogoutRequestedSuccessState());
    }
  }
}
