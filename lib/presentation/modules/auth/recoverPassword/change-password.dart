import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/auth/auth_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as W;
import 'package:turismo_cartagena/presentation/modules/auth/recoverPassword/recover-password.dart';
import 'package:turismo_cartagena/presentation/modules/auth/widgets/password-validator.widget.dart';
import 'package:turismo_cartagena/presentation/modules/profile/profile.dart';



class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl()),
      child: const ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  State<ChangePasswordView> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordView> {

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose(); // Asegúrate de limpiar el controlador para evitar fugas de memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBloc, AuthBlocState>(
          listener: (context, state) {

            if (state is LoadingChangePasswordState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if(state is SuccessChangePasswordState) {
              showDialog(
                context: context,
                barrierDismissible: false, // Evita cerrar el diálogo al tocar fuera
                builder: (BuildContext context) {
                  return W.AlertScreenPopup(
                    title: S.current.updatePassword,
                    message: S.current.textUpdatePassword,
                    icon:  Icons.check_circle,
                    iconColor: Color(0xFF01e63d),
                    actions: [
                      W.ButtonPrimaryCustom(
                        width: MediaQuery.of(context).size.width  - 128,
                        color: const Color(0xFF009C47),
                        text: S.current.textContinue,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileView()),
                                  (route) => false
                          );
                        },
                      ),

                    ],
                  );
                },
              );
            }

            if(state is ErrorChangePasswordState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${state.responsePages.menssage}"))
              );
            }
          },
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 40),
              Transform.rotate(
                angle: 0.8,
                child: const CircleAvatar(
                  backgroundColor: Color.fromARGB(66, 193, 193, 193),
                  radius: 60,
                  child: Icon(Icons.key, size: 90,),
                ),
              ),
              const SizedBox(height: 40),
              const Text("Cambiar contraseña", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const Text("Ingrese su nueva contraseña abajo"),
              const SizedBox(height: 40),
              W.InputTextCustom(
                  hintText: 'Ingrese su contraseña',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility_off,
                  controller: passwordController,
                  isPassword: true,
                  isRequired: true,
                  minLength: 5
              ),
              const SizedBox(height: 16,),
              W.InputTextCustom(
                  hintText: 'Confirmar contraseña',
                  labelText: 'Confirmar Contraseña',
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility_off,
                  controller: confirmPasswordController,
                  isPassword: true,
                  isRequired: true,
                  minLength: 5
              ),
              const SizedBox(height: 16,),
              PasswordValidatorWidget(controller: passwordController),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  W.RegistrationButton(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    color: Colors.red,
                    text: S.current.cancel,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>  RecoverPassword()), (route) => false
                      );
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  W.ButtonPrimaryCustom(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    color: const Color(0xFF009C47),
                    text: S.current.textContinue,
                    onPressed: () {
                      final password = passwordController.text;
                      if (password.isEmpty ||
                          password.length < 6 ||
                          !RegExp(r'[A-Z]').hasMatch(password) ||
                          !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Por favor, ingrese una contraseña válida.'),
                          ),
                        );
                        return;
                      }
                      if(passwordController.text != confirmPasswordController.text){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Las contraseñas no coinciden'
                            ),
                          ),
                        );

                        return;
                      }

                      final event = ChangePasswordEvent(
                        password:  password,
                      );
                      context.read<AuthBloc>().add(event);
                    },
                  ),
               ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
)
    );
  }
}