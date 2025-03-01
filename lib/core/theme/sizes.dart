import 'package:flutter/cupertino.dart';

class AppSizes {
  static late double screenWidth;
  static late double screenHeight;
  static late double scaleFactorWidth;
  static late double scaleFactorHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    scaleFactorWidth = screenWidth / size.width; // Se normaliza al ancho actual
    scaleFactorHeight = screenHeight / size.height; // Se normaliza al alto actual
  }

  static double scaleWidth(double size) {
    return size * (screenWidth / 375.0); // Escala basado en un ancho base de 375 (puedes ajustar).
  }


  static double scaleHeight(double size) {
    return size * (screenHeight / 812.0); // Escala basado en un alto base de 812.
  }

  static double get paddingSmall => scaleWidth(8.0);
  static double get paddingMedium => scaleWidth(16.0);
  static double get paddingLarge => scaleWidth(24.0);

  static double get textSmall => scaleWidth(12.0);
  static double get textMedium => scaleWidth(16.0);
  static double get textLarge => scaleWidth(24.0);
  static double get textLarge32 => scaleWidth(32.0);

  static double get borderRadiusSmall => scaleWidth(8.0);
  static double get borderRadiusMedium => scaleWidth(16.0);
  static double get borderRadiusLarge => scaleWidth(30.0);

  static double get marginSmall => scaleWidth(8.0);
  static double get marginMedium => scaleWidth(16.0);
  static double get marginLarge => scaleWidth(24.0);


  static double get heightSmall => scaleWidth(24.0);
  static double get heightMedium => scaleWidth(32.0);
}
