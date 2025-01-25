import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Environment {
  final String baseUrl;
  //final String apiKey;

  Environment({required this.baseUrl});

  static Future<Environment> forEnvironment(String env) async {
    final contents = await rootBundle.loadString('lib/presentation/global/environments/$env.json');
    final json = jsonDecode(contents);

    return Environment(
      baseUrl: json['baseUrl'],
      //apiKey: json['apiKey'],
    );
  }
}
