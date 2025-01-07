import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/auth/auth_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/alertMessage.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as W;
import 'package:turismo_cartagena/presentation/modules/auth/widgets/password-validator.widget.dart';
import 'package:turismo_cartagena/presentation/modules/layuot.dart';
import 'package:url_launcher/url_launcher.dart';

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
    {"name": "Argentina", "flag": "🇦🇷"},
    {"name": "Australia", "flag": "🇦🇺"},
    {"name": "Brazil", "flag": "🇧🇷"},
    {"name": "Canada", "flag": "🇨🇦"},
    {"name": "Chile", "flag": "🇨🇱"},
    {"name": "Colombia", "flag": "🇨🇴"},
    {"name": "Ecuador", "flag": "🇪🇨"},
    {"name": "France", "flag": "🇫🇷"},
    {"name": "Germany", "flag": "🇩🇪"},
    {"name": "India", "flag": "🇮🇳"},
    {"name": "Italy", "flag": "🇮🇹"},
    {"name": "Japan", "flag": "🇯🇵"},
    {"name": "Mexico", "flag": "🇲🇽"},
    {"name": "Peru", "flag": "🇵🇪"},
    {"name": "Russia", "flag": "🇷🇺"},
    {"name": "South Africa", "flag": "🇿🇦"},
    {"name": "South Korea", "flag": "🇰🇷"},
    {"name": "Spain", "flag": "🇪🇸"},
    {"name": "United Kingdom", "flag": "🇬🇧"},
    {"name": "United States", "flag": "🇺🇸"},
    {"name": "Venezuela", "flag": "🇻🇪"},
  ];

  String? selectedCountry;

  void openWebPage(Uri uri, bool inApp) async {
    try {
      if (inApp) {
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  bool validatePassword(String password) {

    if (password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && password.length > 6 ) {
      return true;
    }

    return false;
  }


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

          showDialog(
            context: context,
            barrierDismissible: false, // Evita cerrar el diálogo al tocar fuera
            builder: (BuildContext context) {
              return W.AlertScreenPopup(
                title: S.current.userRegister,
                message: S.current.textSuccessRegister,
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
                          MaterialPageRoute(builder: (context) => Layout()),
                      (route) => false);
                    },
                  ),

                ],
              );
            },
          );

        } else if (state is ErrorRegisterState) {

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${state.responsePages.menssage}"))
          );
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
                    PasswordValidatorWidget(controller: password),
                    const SizedBox(height: 16),
                    InkWell(

                      onTap: (){
                        openWebPage(Uri.parse("https://www.gooway.co/politica-de-privacidad-de-la-aplicacion-gooway/"), true);
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
                              text: S.current.messagePolityOne,
                              style: const TextStyle(
                                  fontSize: 16
                              ),
                            ),
                            TextSpan(

                              text: " " + S.current.messagePolityTow,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),

                    const SizedBox(height: 16),
                    W.ButtonPrimaryCustom(
                      color: const Color(0xFF009C47),
                      text: 'Registrarse',
                      onPressed: () => _submitForm(context),
                    ),
                    const SizedBox(height: 16),
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

        showDialog(
          context: context,
          barrierDismissible: false, // Evita cerrar el diálogo al tocar fuera
          builder: (BuildContext context) {
            return W.AlertScreenPopup(
              title: S.current.titleEmailInvalid,
              message: S.current.textEmailInvalid,
              icon: Icons.alternate_email,
              iconColor: Colors.red,
              actions: [
                W.ButtonPrimaryCustom(
                  width: MediaQuery.of(context).size.width  - 128,
                  color: const Color(0xFF009C47),
                  text: S.current.back,
                  onPressed: () =>  Navigator.of(context).pop(),
                ),

              ],
            );
          },
        );

        return;
      }

      if(!validatePassword(password.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.current.passwordRequirements))
        );
        return;
      }

      if (password.text != passwordConfirm.text) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.current.passwordNotMatch))
        );
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
