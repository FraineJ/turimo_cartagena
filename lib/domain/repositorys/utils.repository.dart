import 'dart:ui';

abstract class UtilsRepository {

  Future convertCopToDolar(double id);

  Future<void> saveLocales(Locale locale);

  Future<Locale> get locale;

}