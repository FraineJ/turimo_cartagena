import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/domain/models/respose.model.dart';
import 'package:turismo_cartagena/presentation/bloc/auth/auth_bloc.dart';
import 'dart:async';
import 'package:turismo_cartagena/core/widgets/all-widgets.dart' as W;
import 'package:turismo_cartagena/core/utils/all.dart' as Global;
import 'package:turismo_cartagena/presentation/modules/auth/recoverPassword/change-password.dart';



class ValidateCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl()),
      child: const PinCodeWidget(),
    );
  }
}


class PinCodeWidget extends StatefulWidget {
  const PinCodeWidget({super.key});
  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  String enteredPin = "";
  bool ispinvisible = false;
  int intentos = 3;
  Timer? time;
  static const maxsegundo = 180;
  int segundos = maxsegundo;

  /// this widget will be use for each digit
  Widget numButton(int number) {
    return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: TextButton(
          onPressed: () {
            setState(() {
              enteredPin += number.toString();
              if (enteredPin.length < 4) {
              } else if (enteredPin.length == 4) {
                verifyCode(enteredPin);
              }
            });
          },
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        )
    );
  }

  Future<void> sendMailOtp() async {
    Map<String, String> userDetails = await Global.Utils.getLocalInfo();
    final String? email = userDetails['email'];
    if(email != null) {
      final event = RecoverPasswordEvent(email: email);
      context.read<AuthBloc>().add(event);
    } else {
      Global.Utils.showSnackBar(context, "Ha ocurrido un error. No se pudo reenviar el código. Por favor, inténtalo más tarde.", Colors.red);
    }

  }

  Future<void> verifyCode(String code) async {
    final event = VerifyCodeOtpEvent(code);
    context.read<AuthBloc>().add(event);
  }

  void StartTime() {
    time = Timer.periodic(const Duration(seconds: 1), (_) {
      if (segundos > 0) {
        setState(() {
          segundos--;
        });
      } else {
        stop();
        enteredPin = "";
      }
    });
  }

  void reiniciar() {
    setState(() {
      segundos = maxsegundo;
      StartTime();
    });
  }

  void stop() {
    time?.cancel();
  }

  @override
  void initState() {
    super.initState();
    //sendMailOtp();
    StartTime();
  }

  @override
  Widget build(BuildContext context) {
    if (segundos > 0 && intentos == 0) {
      setState(() {
        stop();
        // modal(context);
      });
    }
    return BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {


          //STATES VERIFY CODE
          if (state is VerifyCodeLoadingState) {
            loading();
          }
          print("estados de verificación ${state}");
          if (state is VerifyCodeSuccessState) {
            print("estados de verificación ${state}");
            final ResponsePages response = state.responsePages;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.menssage)));

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>  ChangePassword()), (route) => false
            );
          }

          if (state is VerifyCodeErrorState) {
            intentos -= 1;
            Navigator.pop(context);
            setState(() {
              enteredPin = "";
            });
            final ResponsePages response = state.responsePages;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(response.menssage)));
            // final route = MaterialPageRoute(
            //   builder: (context) => PerfilScreen(),
            // );
            // if (intentos == 0) Navigator.pushReplacement(context, route);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                const W.AppBarCustom(
                  textTitle: "Cambio de contraseña",
                  botonVolver: false,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Hemos enviado un código de verificación a tu Correo electrónico",
                  style: TextStyle(
                       fontSize: 18
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text("Ingresa tu pin",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
                // pin code area
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                          margin: const EdgeInsets.all(6),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              color: Colors.blue.withOpacity(0.1)),
                          child: index < enteredPin.length
                              ? Center(
                            child: Text(
                              enteredPin[index],
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                              : null);
                    })
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: SizedBox(
                    height: 25,
                    width: 35,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: segundos / maxsegundo,
                          strokeWidth: 5,
                          strokeAlign: 2.5,
                        ),
                        Container(
                          child: Center(
                              child: Text(
                                "$segundos",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                segundos > 0
                    ? const TextButton(
                  onPressed: null,
                  child: Text(
                    "Reenviar codigo",
                    style: TextStyle(color: Colors.black26),
                  ),
                )
                    : TextButton(
                    onPressed: () {
                      sendMailOtp();
                      stop();
                      reiniciar();
                    },
                    child:  const Text(
                      "Reenviar Codigo",
                    )
                ),

                const SizedBox(height: 32),

                for (var i = 0; i < 3; i++)
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                              (index) => numButton(1 + 3 * i + index),
                        ).toList(),
                      )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextButton(
                        onPressed: null,
                        child: SizedBox(),
                      ),
                      numButton(0),
                      TextButton(
                        onPressed: () {
                          if (enteredPin.isNotEmpty) {
                            enteredPin =
                                enteredPin.substring(0, enteredPin.length - 1);
                          }
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.backspace,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                /*TextButton(
                    onPressed: () {
                      setState(() {
                        enteredPin = "";
                      });
                    },
                    child: const Text(
                      "reset",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ))*/
              ],
            ),
          ),
        )
    );
  }

  void loading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
