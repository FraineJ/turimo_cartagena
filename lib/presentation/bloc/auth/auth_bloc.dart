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

      List userDta = response["data"];

      if (userDta.isNotEmpty) {


        String userJson = jsonEncode({
          "tokenAcces": response["data"][0]['token'],
          "name": response["data"][0]['name'],
          "email": response["data"][0]['email'],
          "id": response["data"][0]['id'],
        });


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

    try {
      final UserModel user = UserModel(
          lastName: event.lastName,
          name: event.name,
          email: event.email,
          password: event.password,
          nationality: event.nationality,
          status: ""
      );

      print("block enviar response ${user}");

      emit(LoadingRRegisterState());

      final  response = await authCaseUse.register(user);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("response ${response}");
      final dataResponse = UserModel.fromJson(response["data"]);

      if (response["status"] == 200) {
        final data = jsonEncode(dataResponse);

        prefs.setString('user_login', data);
        emit(SuccessRegisterState());
      } else{
        emit(ErrorRegisterState());
      }
    } catch (error) {
      print("error ${error}");
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
