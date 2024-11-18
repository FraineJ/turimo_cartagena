import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:turismo_cartagena/domain/repositorys/utils.repository.dart';

class HttpUtilsService extends UtilsRepository {

  static const String _localeLanguageCodeKey = 'localeLanguageCode';
  static const String _localeScriptCodeKey = 'localeScriptCode';
  static const String _localeCountryCodeKey = 'localeCountryCode';

  @override
  Future convertCopToDolar(double copValue) async {
    String apiUrl = 'https://www.datos.gov.co/resource/32sa-8pi3.json';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body;
      } else {
        return null; // O manejar el error de otra manera
      }

    } catch (error) {
      return error;
    }
  }

  @override
  // TODO: implement locale
  Future<Locale> get locale async {
    final prefs = await SharedPreferences.getInstance();

    final languageCode =  await prefs.getString(_localeLanguageCodeKey);
    final scriptCode =  await prefs.getString(_localeScriptCodeKey);
    final countryCode = await prefs.getString(_localeCountryCodeKey);

    if(languageCode != null) {
      return Locale.fromSubtags(
          languageCode: languageCode,
          scriptCode: scriptCode,
          countryCode: countryCode
      );
    }

    return Locale('es_ES');
  }

  @override
  Future<void> saveLocales(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_localeLanguageCodeKey, locale.languageCode);
    await prefs.setString(_localeScriptCodeKey, locale.scriptCode ?? "");
    await prefs.setString(_localeCountryCodeKey, locale.countryCode ?? "");

  }
}
