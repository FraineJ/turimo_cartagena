import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


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

    if (user.isEmpty) {
      return {};
    }

    try {
      // Decodifica el JSON correctamente
      Map<String, dynamic> userMap = jsonDecode(user);

      // Extrae el token o devuelve vacío si no existe
      String token = userMap['tokenAcces'] ?? '';
      String id = userMap['id'] ?? '';
      String name = userMap['name'] ?? '';
      String email = userMap['email'] ?? '';
      String avatar = userMap['avatar'] ?? '';

      return {'token': token, 'id': id, 'name': name, 'email': email, 'avatar': avatar };
    } catch (e) {
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

  static String haversineDistanceString(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371000; // Radio de la Tierra en metros

    // Convertir grados a radianes
    double phi1 = lat1 * pi / 180;
    double phi2 = lat2 * pi / 180;
    double deltaPhi = (lat2 - lat1) * pi / 180;
    double deltaLambda = (lon2 - lon1) * pi / 180;

    // Aplicar la fórmula de Haversine
    double a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) *
            sin(deltaLambda / 2) * sin(deltaLambda / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Distancia en metros
    double distanceInMeters = R * c;

    // Devolver en kilómetros o metros según la distancia
    if (distanceInMeters >= 1000) {
      double distanceInKilometers = distanceInMeters / 1000;
      return '${distanceInKilometers.toStringAsFixed(2)} km';
    } else {
      return '${distanceInMeters.toStringAsFixed(0)} m';
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Radio de la Tierra en kilómetros

    // Convertir grados a radianes
    double lat1Rad = lat1 * pi / 180;
    double lon1Rad = lon1 * pi / 180;
    double lat2Rad = lat2 * pi / 180;
    double lon2Rad = lon2 * pi / 180;

    // Diferencias entre las coordenadas
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Fórmula de Haversine
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) *
            sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Distancia en kilómetros
    double distance = R * c;

    return distance; // Retorna la distancia en kilómetros
  }


  static void launchURL(Uri uri, bool inApp) async {
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

  static  void showSnackBar(BuildContext context, String message,
      Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }


  static Future<Map<String, String>> getLocalInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String user = prefs.getString('local_info') ?? '';

    if (user.isEmpty) {
      return {};
    }

    try {
      Map<String, dynamic> userMap = jsonDecode(user);

      String id = userMap['id'] ?? '';
      String email = userMap['email'] ?? '';

      return {'id': id, 'email': email };
    } catch (e) {
      return {'token': ''};
    }
  }

}
