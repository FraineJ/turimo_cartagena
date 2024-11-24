import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/presentation/bloc/auth/auth_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as W;
import 'package:turismo_cartagena/presentation/modules/auth/register/register.dart';
import 'package:turismo_cartagena/presentation/modules/layuot.dart';


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
              const SnackBar(content: Text("Ha ocurrido un error inesperado")));
        }

        if (state is SuccessAuthenticationState) {
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
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Container(

                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            W.AppBarCustom(textTitle: "", botonVolver: true,),
                            const SizedBox(height: 32,),
                            const Text("Inicia sesión o regrístrate",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  height: 1.0
                              ),
                            ),
                            const SizedBox(height: 32),
                            W.InputTextCustom(
                                hintText: 'Ingrese su usuario',
                                labelText: 'Usuario',
                                prefixIcon: Icons.email,
                                controller: username,
                                isRequired: true,
                                keyboardType: TextInputType.emailAddress
                            ),
                            const SizedBox(height: 16),
                            W.InputTextCustom(
                                hintText: 'Ingrese su contraseña',
                                labelText: 'Contraseña',
                                prefixIcon: Icons.lock,
                                suffixIcon: Icons.visibility_off,
                                controller: password,
                                isPassword: true,
                                isRequired: true,
                                minLength: 5
                            ),
                            const SizedBox(height: 16),
                            W.ButtonPrimaryCustom(
                              color: const Color(0xFF22014D),
                              text: 'Iniciar sesión',
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
                            const SizedBox(height: 24),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Register())
                                );
                              },
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(

                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.black,

                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '¿No tienes una cuenta? ',
                                      style: TextStyle(
                                          fontSize: 16
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Crear una nueva cuenta es gratis.!',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFFF6969)
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}