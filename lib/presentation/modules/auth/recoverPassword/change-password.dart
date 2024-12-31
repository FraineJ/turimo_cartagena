import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart';
import 'package:flutter/material.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as W;
import 'package:turismo_cartagena/presentation/modules/auth/widgets/password-validator.widget.dart';

class ChangePassword extends StatefulWidget {

  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

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
        body: Container(
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
                    text: 'Cancelar',
                    onPressed: () {

                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  W.ButtonPrimaryCustom(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    color: const Color(0xFF009C47),
                    text: 'Continuar',
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

                      print("Contraseña válida: $password");
                    },
                  ),
               ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        )
    );
  }
}