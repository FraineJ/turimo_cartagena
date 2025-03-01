import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:turismo_cartagena/core/widgets/show_custom_snackbar.dart';
import 'package:turismo_cartagena/domain/models/authorization/login_response_model.dart';
import 'package:turismo_cartagena/domain/models/response_model.dart';
import 'package:turismo_cartagena/domain/repositorys/socail_repo.dart';
import 'package:turismo_cartagena/generated/l10n.dart';



class SocialAuthController extends GetxController {
  SocialAuthRepo authRepo;
  SocialAuthController({required this.authRepo});
  static const List<String> scopes = [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final GoogleSignIn googleSignIn = GoogleSignIn(
    forceCodeForRefreshToken: false,
    scopes: scopes,
  );

  bool isGoogleSignInLoading = false;
  Future<void> signInWithGoogle() async {
    try {
      isGoogleSignInLoading = true;
      update();
      googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        isGoogleSignInLoading = false;
        update();
        return;
      }
      final googleAuth = await googleUser.authentication;
      await socialLoginUser(
          provider: 'google', accessToken: googleAuth.accessToken ?? '');
    } catch (e) {
      CustomSnackBar.error(errorList: [e.toString()]);
    }

    isGoogleSignInLoading = false;
    update();
  }

  bool isAppleSignInLoading = false;

  Future socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    try {
      final ResponseModel responseModel = await authRepo.socialLoginUser(
        accessToken: accessToken,
        provider: provider,
      );

      if (responseModel.statusCode == 200) {
        LoginResponseModel loginModel =  LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (loginModel.status.toString().toLowerCase() ==
            S.current.success.toLowerCase()) {

         print("login ${loginModel.data}");

        } else {

          CustomSnackBar.error(
              errorList:
              loginModel.message ?? [S.current.loginFailedTryAgain.tr]
          );
        }
      } else {

        CustomSnackBar.error(errorList: [responseModel.message]);

      }
    } catch (e) {
      print(e.toString());
    }
  }
}
