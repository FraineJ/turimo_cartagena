import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'dart:io';


class AlertScreen extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color colorIcon;
  final VoidCallback onPressed;
  const AlertScreen({Key? key, required this.message, required this.onPressed, required this.title, required this.icon, required this.colorIcon}) : super(key: key);

  void mostrarAlertaIOS(BuildContext context) {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title:  Text(title),
            content:  Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(
                height: 10,
              ),
              const Icon(
                Icons.check_circle,
                color: Color(0xFF01e63d),
                size: 32,
              ),
              Text(message),

            ]),
            actions: [
              TextButton(
                  child: const Text('Cancelar', style: TextStyle(color: Colors.red),),
                  onPressed: () => Navigator.pop(context)),
              TextButton(
                  child: const Text('Ok'),
                  onPressed: onPressed
              )
            ],
          );
        });
  }

  void mostrarAlertaAndroid(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title:  Text(title),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content:  Column(mainAxisSize: MainAxisSize.min, children: [

              Icon(
                icon,
                color: colorIcon,
                size: 64,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(message),

            ]),
            actions: [

              TextButton(
                  child: const Text('Aceptar'),
                  onPressed: onPressed
              )
            ],
          );
        });
  }

  void mostrarAlerta(BuildContext context) {
    if (Platform.isIOS) {
      mostrarAlertaIOS(context);
    } else {
      mostrarAlertaAndroid(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    mostrarAlerta(context);
    return Container();

  }
}
