import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/core/theme/colors.dart';
import 'package:turismo_cartagena/core/theme/sizes.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/auth/auth_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/core/widgets/all-widgets.dart' as W;
import 'package:turismo_cartagena/presentation/modules/auth/recoverPassword/recover-password.dart';
import 'package:turismo_cartagena/presentation/modules/auth/register/register.dart';
import 'package:turismo_cartagena/presentation/modules/layuot.dart';

import '../widgets/SocialAuthSection.dart';
import '../widgets/login_or_bar.dart';


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl()),
      child: Authentication(),
    );
  }
}

class Authentication extends StatelessWidget {
  final username = TextEditingController();
  final password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {

        if (state is LoadingRequestedState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ErrorAuthenticationState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Usuario o contraseña inválidos. Intenta nuevamente.")));
        }

        if (state is SuccessAuthenticationState) {
          context.read<InitialBloc>().add(IsAuthenticatedEvent(isAuthenticated: true));

          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Layout()), (route) => false
          );
        }
      },

      child: Scaffold(
          body: GestureDetector(
            onHorizontalDragEnd: (details) {

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Layout()), (route) => false
              );

            },
            child: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const W.AppBarCustom(textTitle: "", botonVolver: true,),
                      const SizedBox(height: 32,),
                      Text(S.current.loginOrRegister,
                        style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.textLarge,
                            height: 1.0
                        ),
                      ),
                      SizedBox(height: AppSizes.marginLarge),
                      const SocialAuthSection(),
                      SizedBox(height: AppSizes.marginMedium),
                      const LoginOrBar(stock: 0.8),
                      SizedBox(height: AppSizes.marginMedium),
                      Form(
                        key: _formKey,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              W.InputTextCustom(
                                  hintText: 'micorreo@gmail.com',
                                  labelText: 'Correo electrónico',
                                  prefixIcon: Icons.email,
                                  controller: username,
                                  isRequired: false,
                                  isEmail: true,
                                  keyboardType: TextInputType.emailAddress
                              ),
                              const SizedBox(height: 16),
                              W.InputTextCustom(
                                  hintText: S.current.passwordRegister,
                                  labelText: S.current.hintTexPassword,
                                  prefixIcon: Icons.lock,
                                  suffixIcon: Icons.visibility_off,
                                  controller: password,
                                  isPassword: true,
                                  isRequired: true,
                                  minLength: 5
                              ),
                              const SizedBox(height: 16),
                              W.ButtonPrimaryCustom(
                                color: AppColors.primary,
                                text: S.current.textLogin,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (username.text.isNotEmpty &&
                                        password.text.isNotEmpty) {
                                      final event = LoginEvent(username.text, password.text);
                                      context.read<AuthBloc>().add(event);
                                    }
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RecoverPassword())
                                  );
                                },
                                child:  Center(
                                  child:  Text(S.current.forgotYourPassword,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:  AppColors.primary
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              W.RegistrationButton(
                                width: double.infinity,
                                color: AppColors.error,
                                text: S.current.signUp,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Register())
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Register())
                                  );
                                },
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text:  TextSpan(
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: S.current.notAccount,
                                        style: const TextStyle(
                                            fontSize: 16
                                        ),
                                      ),
                                      TextSpan(
                                        text: S.current.registrationIsFree,
                                        style:  TextStyle(
                                            fontSize: AppSizes.textMedium,
                                            color: AppColors.error
                                        ),
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                              const SizedBox(height: 24),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}