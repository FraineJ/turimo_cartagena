import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:turismo_cartagena/domain/models/respose.model.dart';
import 'package:turismo_cartagena/domain/models/user.model.dart';
import 'package:turismo_cartagena/domain/usecases/auth.usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/l10n.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  final AuthCaseUse authCaseUse;

  AuthBloc(this.authCaseUse) : super(LoginStarted()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<LogoutRequested>(_logout);
    on<RecoverPasswordEvent>(_recoverPassword);
    on<VerifyCodeOtpEvent>(_verifyCodeOtp);
    on<ChangePasswordEvent>(_changePassword);
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

      emit(LoadingRRegisterState());

      final ResponsePages  response = await authCaseUse.register(user);
      print("resoonse register ${response}");

      if (response.status == 200) {
        final data = jsonEncode(response.data);

        //prefs.setString('user_login', data);
        emit(SuccessRegisterState());
      } else{
        emit(ErrorRegisterState(responsePages: response));
      }
    } catch (error) {
      print("resoonse register ${error}");
      final ResponsePages  response = ResponsePages(data: [], menssage: S.current.errorServer, status: 500);
      emit(ErrorRegisterState(responsePages: response));
    }
  }

  Future _logout(LogoutRequested event, Emitter<AuthBlocState> emit) async {
    emit(LoadingRequestedState());
    final response = await authCaseUse.logout();
    if (response == true) {
      emit(LogoutRequestedSuccessState());
    }
  }

  Future _recoverPassword(RecoverPasswordEvent event, Emitter<AuthBlocState> emit) async {

    try {
      emit(LoadingRecoverPasswordState());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final ResponsePages response = await authCaseUse.recoverPassword(event.email);
      if (response.status == 200) {

        String userJson = jsonEncode({
          "id": response.data[0]['id'],
          "email": response.data[0]['email'],
        });

        prefs.setString('local_info', userJson);

        emit(SuccessRecoverPasswordState(responsePages: response ));
      } else {
        emit(ErrorRecoverPasswordState(responsePages: response ));
      }
    } catch (error) {
      print("error ${error}");
      ResponsePages response = ResponsePages(data: [], menssage: "Ha ocurrido un error inesperado", status: 400);
      emit(ErrorRecoverPasswordState(responsePages: response));
    }
  }

  Future _verifyCodeOtp(VerifyCodeOtpEvent event, Emitter<AuthBlocState> emit) async {
    String code = event.code;

    emit(VerifyCodeLoadingState());
    try {
      final ResponsePages response = await authCaseUse.verifyOtp(code);
      if (response.status == 200) {
        emit(VerifyCodeSuccessState(responsePages: response));
      } else {
        emit(VerifyCodeErrorState(responsePages: response));
      }
    } catch (error) {
      ResponsePages response = ResponsePages(data: [], menssage: "Ha ocurrido un error inesperado", status: 400);
      emit(VerifyCodeErrorState(responsePages: response));
    }

  }

  Future _changePassword(ChangePasswordEvent event, Emitter<AuthBlocState> emit) async {

    try {
      emit(LoadingChangePasswordState());
      print("ChangePasswordEvent");
      final ResponsePages response = await authCaseUse.changePassword(event.password);

      if (response.status == 200) {

        emit(SuccessChangePasswordState(responsePages: response ));
      } else {
        emit(ErrorChangePasswordState(responsePages: response ));
      }
    } catch (error) {
      print("error ${error}");
      ResponsePages response = ResponsePages(data: [], menssage: "Ha ocurrido un error inesperado", status: 400);
      emit(ErrorChangePasswordState(responsePages: response));
    }
  }

}
