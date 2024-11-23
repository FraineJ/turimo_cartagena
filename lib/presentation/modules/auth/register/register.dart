import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/auth/auth_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/auth/login/login.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as W;

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl()),
      child: CustomerForm(),
    );
  }
}

class CustomerForm extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirm = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> countries = [
    {"name": "United States", "flag": "🇺🇸"},
    {"name": "Canada", "flag": "🇨🇦"},
    {"name": "Germany", "flag": "🇩🇪"},
    {"name": "France", "flag": "🇫🇷"},
    {"name": "Brazil", "flag": "🇧🇷"},
    {"name": "Argentina", "flag": "🇦🇷"},
    {"name": "United Kingdom", "flag": "🇬🇧"},
    {"name": "Italy", "flag": "🇮🇹"},
    {"name": "Mexico", "flag": "🇲🇽"},
    {"name": "Spain", "flag": "🇪🇸"},
  ];
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {

        if (state is LoadingRRegisterState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is SuccessRegisterState) {
          W.AlertScreen(
            message: "Uusario registrado",
            title: "Registro Exitoso",
            icon: Icons.check_circle,
            colorIcon: const Color(0xFF01e63d),
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
                  (route) => false,
            ),
          ).mostrarAlerta(context);
        } else if (state is ErrorRegisterState) {
          W.AlertScreen(
            message: "Verifique los datos ingresados",
            title: "Registro Fallido",
            icon: Icons.cancel,
            colorIcon: const Color(0xFFf03705),
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pop(context)
            },
          ).mostrarAlerta(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const W.AppBarCustom(textTitle: "Registrarte", botonVolver: true,),
                    const SizedBox(height: 8),
                    const Text(
                      "Por favor rellenar todos los campos",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    W.InputTextCustom(
                      hintText: 'Ingrese su nombre',
                      labelText: S.current.nameRegister,
                      controller: name,
                      prefixIcon: Icons.person_2_rounded,
                      isRequired: true,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    W.InputTextCustom(
                      hintText: 'Ingrese sus apellidos',
                      labelText:  S.current.lastNameRegister,
                      controller: lastName,
                      isRequired: true,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    W.InputTextCustom(
                      hintText: 'Ingrese un correo electrónico',
                      labelText:  S.current.emailRegister,
                      controller: email,
                      prefixIcon: Icons.email,
                      isRequired: true,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedCountry,
                      items: countries.map((country) {
                        return DropdownMenuItem<String>(
                          value: country['name'],
                          child: Text(
                            "${country['flag']} ${country['name']}",
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedCountry = value!;
                      },
                      hint: const Text("Seleccione su país de origen"), // Placeholder

                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione un país';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    W.InputTextCustom(
                      hintText: 'Contraseña',
                      labelText: S.current.passwordRegister,
                      prefixIcon: Icons.lock,
                      suffixIcon: Icons.visibility_off,
                      controller: password,
                      isPassword: true,
                      isRequired: true,
                      maxLines: 3,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 16),
                    W.InputTextCustom(
                      hintText: S.current.confirmPasswordRegister,
                      labelText: S.current.confirmPasswordRegister,
                      prefixIcon: Icons.lock,
                      suffixIcon: Icons.visibility_off,
                      controller: passwordConfirm,
                      isPassword: true,
                      isRequired: true,
                      maxLines: 3,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 16),
                    Text(S.current.messagePolity,
                      style: const TextStyle(fontSize: 16, color: Color(0xFFFF6969)),
                    ),
                    const SizedBox(height: 16),
                    W.ButtonPrimaryCustom(
                      color: const Color(0xFF22014D),
                      text: 'Registrarse',
                      onPressed: () => _submitForm(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (email.text.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email.text)) {
        W.AlertScreen(
          message: "Por favor, ingrese un correo electrónico válido.",
          title: "Correo Inválido",
          icon: Icons.warning,
          colorIcon: Colors.orange,
          onPressed: () => Navigator.pop(context),
        ).mostrarAlerta(context);
        return;
      }

      if (password.text != passwordConfirm.text) {
        W.AlertScreen(
          message: "Las contraseñas no coinciden.",
          title: "Error en Contraseñas",
          icon: Icons.warning,
          colorIcon: Colors.orange,
          onPressed: () => Navigator.pop(context),
        ).mostrarAlerta(context);
        return;
      }

      final event = RegisterEvent(
        name:  name.text,
        lastName:  lastName.text,
        email:  email.text,
        password:  password.text,
        nationality:  selectedCountry ?? ""
      );
      context.read<AuthBloc>().add(event);
    }
  }

  @override
  void dispose() {
    name.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
  }
}
