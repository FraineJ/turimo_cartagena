import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/presentation/bloc/auth/auth_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as W;
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as SHARED;
import 'package:turismo_cartagena/presentation/modules/auth/recoverPassword/valitate-code.dart';

class RecoverPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl()),
      child: RecoverPasswordView(),
    );
  }
}

class RecoverPasswordView extends StatelessWidget {
  RecoverPasswordView({super.key});

  final email = TextEditingController();
  final GlobalKey<FormState> _formKeyRecovery = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {

        if(state is LoadingRecoverPasswordState) {
          showDialog(
             context: context,
             barrierDismissible: false,
             builder: (context) => const Center(
               child: CircularProgressIndicator(),
             ),
           );
        }
        if (state is SuccessRecoverPasswordState) {
          SHARED.Utils.showSnackBar(context, state.responsePages.menssage, Colors.black54);

          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  ValidateCode()), (route) => false
          );
        } else if(state is ErrorRecoverPasswordState) {
          Navigator.pop(context);
          SHARED.Utils.showSnackBar(context, state.responsePages.menssage, Colors.red);
        }


      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKeyRecovery,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const W.AppBarCustom(
                    textTitle: "",
                    botonVolver: true,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Recuperar contraseña",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 26, height: 1.0),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Ingresa tu correo electrónico para reestablecer tu contraseña.",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 19,
                        height: 1.3,
                        color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: W.InputTextCustom(
                        hintText: 'micorreo@gmail.com',
                        labelText: 'Correo electrónico',
                        prefixIcon: Icons.email,
                        controller: email,
                        isRequired: false,
                        keyboardType: TextInputType.emailAddress,
                        isEmail: true,
                    ),

                  ),
                  const SizedBox(height: 16),
                  W.ButtonPrimaryCustom(
                    color: const Color(0xFF009C47),
                    text: 'Validar correo',
                    onPressed: () {
                      if (_formKeyRecovery.currentState!.validate()) {
                        if (email.text.isNotEmpty) {
                          final event = RecoverPasswordEvent(email: email.text);
                          context.read<AuthBloc>().add(event);
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
