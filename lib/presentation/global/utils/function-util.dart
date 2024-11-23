import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  // Formatear fechas
  static String formatearFecha(String fechaOriginal, {String formato = 'dd/MM/yyyy'}) {
    DateTime fecha = DateTime.parse(fechaOriginal);
    return DateFormat(formato).format(fecha);
  }

  static String formatearFechaEspanol(DateTime fecha) {

    String dia = DateFormat.d('es_ES').format(fecha);
    String mes = DateFormat.MMMM('es_ES').format(fecha);
    String anio = DateFormat.y('es_ES').format(fecha);
    return '$dia de $mes del $anio';
  }

  // Mostrar un SnackBar
  static void mostrarSnackBar(BuildContext context, String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Mostrar un diálogo de carga
  static void mostrarDialogoCarga(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Cerrar un diálogo
  static void cerrarDialogo(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Validar un correo electrónico
  static bool validarEmail(String email) {
    final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  // Formatear número
  static String formatearNumero(double numero) {
    final NumberFormat numFormat = NumberFormat('###,##0.00', 'en_US');
    return numFormat.format(numero);
  }

  static Future<Map<String, String>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String user = prefs.getString('user_login') ?? '';
    print("store user $user");

    if (user.isEmpty) {
      return {'token': ''};
    }

    try {
      // Decodifica el JSON correctamente
      Map<String, dynamic> userMap = jsonDecode(user);
      print("store userMap: $userMap");

      // Extrae el token o devuelve vacío si no existe
      String token = userMap['tokenAcces'] ?? '';
      String id = userMap['id'] ?? '';

      return {'token': token, 'id': id};
    } catch (e) {
      // Si ocurre un error, devuelve un token vacío
      print("Error decoding user: $e");
      return {'token': ''};
    }
  }


  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('d MMM y');
    return formatter.format(date);
  }

  static String sanitizeValue(String value) {
    String sanitizedValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

    int firstDecimalIndex = sanitizedValue.indexOf('.');
    if (firstDecimalIndex != -1) {
      sanitizedValue = sanitizedValue.substring(0, firstDecimalIndex + 1) + sanitizedValue.substring(firstDecimalIndex + 1).replaceAll('.', '');
    }

    if (sanitizedValue.contains('.')) {
      int decimalIndex = sanitizedValue.indexOf('.');
      int decimalPlaces = sanitizedValue.length - decimalIndex - 1;
      if (decimalPlaces < 2) {
        sanitizedValue = sanitizedValue.padRight(decimalIndex + 3, '0');
      } else if (decimalPlaces > 2) {
        sanitizedValue = sanitizedValue.substring(0, decimalIndex + 3);
      }
    } else {
      sanitizedValue += '.00';
    }

    return sanitizedValue;
  }

  static statusPayment(String status) {
    if(status.isEmpty) {
      return "En revisión";
    }

    if(status == "PAYMENT_SUCCESS") {
      return "Aprobado";
    } else  if(status == "PAYMENT_CANCEL"){
      return  "Cancelado";
    }
  }

  static typePayment(String type) {

    if(type == "TOTAL") {
      return "Total";
    } else  if(type == "PARTIAL"){
      return  "Parcial";
    }
  }

  static formatMoney(int value) {

    final NumberFormat numFormat = NumberFormat('###,##0.00', 'en_US');
    return numFormat.format(value);

  }

  static Future<Position?> getPositionCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? positionString = prefs.getString('position');

    if (positionString != null) {
      List<String> parts = positionString.split(',');
      double latitude = double.parse(parts[0]);
      double longitude = double.parse(parts[1]);

      return Position(
          latitude: latitude,
          longitude: longitude,
          timestamp: DateTime.now(), // Puedes poner la fecha actual o un valor específico
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0,
          headingAccuracy: 0
      );
    }

    return null; // Si no hay ninguna posición guardada
  }

  static String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return text.substring(0, maxLength) + "...";
    } else {
      return text;
    }
  }
}
